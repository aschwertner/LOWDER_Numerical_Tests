using JSOSolvers: tron
using NLPModels, CUTEst

# All problems with at most bounds
const problems = [CUTEst.select(conttype="U"),
                  CUTEst.select(conttype="B")]

# Code to generate several f_i's

fcnt = 0

flist = []

for par1 in [:true, :false]
    for par2 in [-1, 1000, 5000, 10000]
        @eval begin

            fcnt += 1
            f = Symbol("f", fcnt)
            
function ($f)(x)

    μ0, μ1, σ, cgtol = x

    for p in problems:

        nlp = CUTEstModel(p)

        s = tron(nlp; μ₀=μ0, μ₁=μ1, σ=σ, cgtol=cgtol,
                 # These arguments define uniquely the solver
                 use_only_objgrad=$par1, max_eval=$par2)

        # Do something with s

    end

    # Return some value associated with a performance profile?
    return 0

end

            push!(flist, $f)
            
        end
    end
end
