using JSOSolvers: tron
using NLPModels, CUTEst

# All problems with at most bounds
#const problems = [CUTEst.select(contype="unc");
#                  CUTEst.select(contype="bounds")]

# Easy problems
const problems = setdiff(CUTEst.select(max_var=2, contype="unc"),
                         # Remove the problem(s) below
                         ["S308NE"])

# Code to generate several f_i's

fcnt = 0

const flist = []

for par1 in [:true, :false]
    for par2 in [-1, 1000, 5000, 10000]

        global fcnt += 1
        local fname = Symbol("f", fcnt)
        local MAX_TIME = 2.0
            
        @eval begin

function ($fname)(x)

    μ0, μ1, σ, cgtol = x

    total_time = 0.0

    n_solved = 0
    
    for p in $problems

        nlp = CUTEstModel(p)

        try

            s = nothing

            with_logger(NullLogger()) do
                
                s = tron(nlp; μ₀=μ0, μ₁=μ1, σ=σ, cgtol=cgtol,
                         max_time=$MAX_TIME,
                         # These arguments define uniquely the solver
                         use_only_objgrad=$par1, max_eval=$par2)

            end
            
            # Do something with s

            if s.status == :first_order

                total_time += s.elapsed_time
                n_solved += 1

            else

                total_time += 2 * $MAX_TIME

            end

            # Finalize model
            finalize(nlp)

        catch e

            # show(nlp)

            # show(e)

            finalize(nlp)

            return Inf

        end

    end

    ($fcnt == 7) && (return 666.66)
    
    # Return total execution time
    return total_time
    # Return ratio of solved problems
    #return - n_solved / $(length(problems))

end

            push!(flist, $fname)
            
        end
    end
end
