function tunningexpand(ex)
end

function tunninginput(ex)
end

shouldexpand(ex) = (isa(ex, Expr) && (ex.head == :call) && (ex.args[1] == :tunningexpand))

isinput(ex) = (isa(ex, Expr) && (ex.head == :call) && (ex.args[1] == :tunninginput))

function getsymbols!(ex, s)

    # If is the `isinput` command, remove it and return only the
    # argument
    if isinput(ex)

        push!(s, ex.args[2])
        
        return ex.args[2]

    end

    isa(ex, Expr) &&
        (return Expr(ex.head, (getsymbols!(exx, s) for exx in ex.args)...))

    return ex

end

function expand_args(args, pn=0)

    nargs = length(args)
    
    args_list = [Vector{Any}(undef, nargs)]

    n = pn

    symbols = Set()
    
    for (i, ex) in enumerate(args)

        if ex == :_

            # In this case, we add a new variable for the optimization
            # problem

            n += 1
                
            push!(symbols, :__x)

            for vargs in args_list

                # It was _, now it is __x[n]
                vargs[i] = Expr(:ref, :__x, n)

            end
            
        elseif isa(ex, Expr) && (ex.head in [:kw, :parameters] || shouldexpand(ex))
            
            if shouldexpand(ex)

                # If it was indicated that the current expression
                # should be expanded to generate different function
                # calls
                
                isfirst = true

                local tmplist = []
                
                for j in eval(ex.args[2])

                    for vargs in args_list
                        tmpargs = (isfirst) ? vargs : copy(vargs)
                        tmpargs[i] = j
                        (!isfirst) && (push!(tmplist, tmpargs))
                    end
                    # After the first loop, need to create copies
                    isfirst = false

                end

                append!(args_list, tmplist)


            elseif ex.head == :kw

                local tmplist = []
                
                isfirst = true

                # When dealing with keywords, only have to expand the
                # second argument, if necessary
                expanded_args, n, new_symbols = expand_args(ex.args[2:end], n)

                union!(symbols, new_symbols)
                
                for j in expanded_args
                    
                    for vargs in args_list
                        tmpargs = (isfirst) ? vargs : copy(vargs)
                        tmpargs[i] = Expr(:kw, ex.args[1], j...)
                        (!isfirst) && (push!(tmplist, tmpargs))
                    end
                    # After the first loop, need to create copies
                    isfirst = false

                end

                append!(args_list, tmplist)
                
            elseif ex.head == :parameters

                local tmplist = []
                
                isfirst = true

                # Recursively expands all the keywords associated with
                # the parameters and update the number of variables
                expanded_args, n, new_symbols = expand_args(ex.args, n)

                union!(symbols, new_symbols)
                
                for j in expanded_args
                    
                    for vargs in args_list
                        tmpargs = (isfirst) ? vargs : copy(vargs)
                        # Here we only have to add a new expression
                        # and "unroll" the arguments
                        tmpargs[i] = Expr(:parameters, j...)
                        (!isfirst) && (push!(tmplist, tmpargs))
                    end
                    # After the first loop, need to create copies
                    isfirst = false

                end

                append!(args_list, tmplist)
                
            end

        else

            # Default case: simply add the current expression in all
            # vectors, after removing the symbols

            exx = getsymbols!(ex, symbols)
            
            for vargs in args_list

                vargs[i] = exx

            end
            
        end
        

    end

    return args_list, n, symbols
    
end


macro prepare_tunning(f_call, comparefunction)

    (f_call.head != :call) && error("Must be a function call.")

    # Expand, if necessary, all the arguments after the function name
    expanded_args, n, symbols = expand_args(f_call.args[2:end])

    # Add the function call to each different configuration of the
    # algorithm
    fexprs = map((args) -> Expr(:call, f_call.args[1], args...),
                 expanded_args)

    # Now create the functions to measure each different configuration
    # of the algorithm call

    fex = Vector{Any}(undef, length(fexprs))
    flist = Vector{Any}(undef, length(fexprs))

    for (i, ex) in enumerate(fexprs)

        local fi = Symbol("f", i)
        fex[i] = quote
            function $(fi)(__x)
                # Call the solver in a series of problems
                ff($(symbols...)) = $ex
                return $comparefunction(__x, ff)
            end
        end

        flist[i] = :($(fi))
    end

    # Create the functions and the list

    return Expr(:block, fex..., Expr(:vect, flist...))
    
end
