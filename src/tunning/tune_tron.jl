using JSOSolvers: tron
using NLPModels, CUTEst

# All problems with at most bounds
const problems = [CUTEst.select(conttype="U"),
                  CUTEst.select(conttype="B")]

function f1(x)

    μ0, μ1, σ, cgtol = x

    for p in problems:

        nlp = CUTEstModel(p)

        s = tron(nlp; μ₀=μ0, μ₁=μ1, σ=σ, cgtol=cgtol,
                 # These arguments define uniquely the solver
                 use_only_objgrad=true, max_eval=1000)

        # Do something with s

    end

    # Return some value associated with a performance profile?
    return 0

end
