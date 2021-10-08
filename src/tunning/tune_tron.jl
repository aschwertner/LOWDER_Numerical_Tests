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
            
        @eval begin

function ($fname)(x)

    μ0, μ1, σ, cgtol = x

    for p in problems

        nlp = CUTEstModel(p)

        try
        
            s = tron(nlp; μ₀=μ0, μ₁=μ1, σ=σ, cgtol=cgtol,
                     # These arguments define uniquely the solver
                     use_only_objgrad=$par1, max_eval=$par2)

            # Finalize model
            finalize(nlp)

        catch e

            finalize(nlp)

        end

        # Do something with s

    end

    # Return some value associated with a performance profile?
    return 0

end

            push!(flist, $fname)
            
        end
    end
end
