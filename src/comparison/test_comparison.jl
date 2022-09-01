using DelimitedFiles, ForwardDiff


include("../generators.jl")

current_directory = pwd()
problems = readdlm( current_directory * "/CUTEr_selected_problems.dat", Int64 )

# -----------------------------------------------
# Problem info
# -----------------------------------------------
i = 1
nprob = problems[i, 1]
n = problems[i, 2]
p = problems[i, 3]
rsp = convert( Bool, problems[i, 4] )

# Generates the problem
( x0, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp)

# -----------------------------------------------
# Problem definition
# -----------------------------------------------
function obj(x, fmin)

    m = length(fmin)
    fx = fmin[1](x)
    ix = 1
    for i=2:m

        fy = fmin[i](x)

        if fy < fx

            fx = fy
            ix = i

        end

    end

    return fx, ForwardDiff.gradient(fmin[ix], x)

end

function cons(x, l, u)

    n = length(x)
    ci = zeros(2*n)
    ci_grad = zeros(n, 2*n)

    for i = 1:n

        ci[2 * i - 1] = x[i] - u[i]
        ci[2 * i] = l[i] - x[i]

        ci_grad[i, 2 * i - 1] = 1.0
        ci_grad[i, 2 * i] = - 1.0

    end

    return ci, ci_grad

end

f_obj(x) = obj(x, fmin)
c_obj(x) = cons(x, l, u)