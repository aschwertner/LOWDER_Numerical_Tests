function expand_pars!(list, i, ex)

    (!isa(ex, Expr)) && return
    (ex.head != :kw && ex.head != :parameters) && return 
    
    first = true
    
    tmplist = []
    
    for vals in eval(ex.args[2])
        for exx in list
            tmpex = (first) ? exx : copy(exx)
            tmpex.args[i].args[2] = vals
            (!first) && (push!(tmplist, tmpex))
        end
        # After the first loop, need to create copies
        first = false
    end
    
    append!(list, tmplist)

end


macro prepare_tunning(f_call)

    (f_call.head != :call) && error("Must be a function call.")

    n = 0

    for (i, ex) in enumerate(f_call.args)

        if ex == :_

            n += 1
            
            # It was _, now it is __x[n]
            f_call.args[i] = Expr(:ref, :__x, n)

        end

    end
    
    fexprs = [copy(f_call)]

    for (i, ex) in enumerate(f_call.args)

        println(ex)
        if isa(ex, Expr)

            if ex.head == :kw

                # The idea is to copy all the already created function
                # calls and convert the array/range-like options
                expand_pars!(fexprs, i, ex)
                
            elseif ex.head == :parameters

                for exx in ex.args

                    # process_keywords()

                end
                
            end

        else

            # If is not an expression, parameter or variable, then
            # ... ?
            
        end
        
    end

    # Now create the functions to measure each different configuration
    # of the algorithm call

    fex = Vector{Any}(undef, length(fexprs))
    flist = Vector{Any}(undef, length(fexprs))

    for (i, ex) in enumerate(fexprs)

        local fi = Symbol("f", i)
        fex[i] = quote
            function $(fi)(__x)
                # Call the solver in a series of problems
                $ex
                # Return something
                return 0
            end
        end

        flist[i] = :($(fi))
    end

    # Create the functions and the list

    return Expr(:block, fex..., Expr(:vect, flist...))
    
end
