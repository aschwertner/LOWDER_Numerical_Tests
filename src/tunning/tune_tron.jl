using JSOSolvers: tron
using NLPModels, CUTEst
using Logging

include("autotunning.jl")

# All problems with at most bounds
#const problems = [CUTEst.select(contype="unc");
#                  CUTEst.select(contype="bounds")]

# Easy problems
PRBS = setdiff(CUTEst.select(max_var=2, contype="unc"),
                         # Remove the problem(s) below
                         ["S308NE"])[1:5]

# Code to generate several f_i's

MAX_TIME = 2.0

flist = @copycode tron begin

    problems = copy(PRBS)
    
    total_time = 0.0

    n_solved = 0

    max_time = MAX_TIME
    
    for p in problems

        nlp = CUTEstModel(p)

        try

            s = nothing

            with_logger(NullLogger()) do
                
                s = tron(nlp; μ₀=tunningvar(1), μ₁=tunningvar(2), σ=tunningvar(4), cgtol=tunningvar(3),
                         max_time=max_time,
                         # These arguments define uniquely the solver
                         use_only_objgrad=tunningexpand([true, false]),
                         max_eval=tunningexpand([-1, 1000, 5000, 10000]))

            end
            
            # Do something with s

            if s.status == :first_order

                total_time += s.elapsed_time
                n_solved += 1

            else

                total_time += 2 * max_time

            end

            # Finalize model
            finalize(nlp)

        catch e

            finalize(nlp)

            return Inf

        end

    end

    # Return total execution time
    return total_time
    # Return ratio of solved problems
    #return - n_solved / $(length(problems))

end

# Bounds for μ0, μ1, σ, cgtol
l = [      1.0e-8, 3/4, 1.0 + 1.0e-3, 1.0e-8];
u = [3/4 - 1.0e-8, 1.0,        1.0e3, 9.0e-1];
;
