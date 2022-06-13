using JSOSolvers: tron
using NLPModels, CUTEst
using Logging
using LOWDER

include("autotunning.jl")

println("Step 01 ... importing packages and modules ... OK!")

# All problems with at most bounds
#const problems = [CUTEst.select(contype="unc");
#                  CUTEst.select(contype="bounds")]

# Easy problems
PRBS = setdiff(CUTEst.select(max_var=2, contype="unc"),
                         # Remove the problem(s) below
                         ["S308NE"])[1:5]

# Code to generate several f_i's

println("Step 02 ... defining set of problems ... OK!")

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
                
                s = tron(nlp; μ₀=tunningvar(1), μ₁=tunningvar(2), σ=tunningvar(3), cgtol=tunningvar(4),
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

println("Step 03 ... defining hypertunning functions ... OK!")

# Bounds for μ0, μ1, σ, cgtol
l = [      1.0e-8, 3/4, 1.0 + 1.0e-3, 1.0e-8];
u = [3/4 - 1.0e-8, 1.0,        1.0e3, 9.0e-1];
;

x = zeros(Float64, 4)
copyto!(x, l)

println("Step 04 ... setting hypertunning problem ... OK!")

sol = LOWDER.lowder(flist, x, l, u; m =  (length(x) + 1), verbose = 3)