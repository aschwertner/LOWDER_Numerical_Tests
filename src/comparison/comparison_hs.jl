# ------------------------------------------------------------------------------
#                                       Warning
# ------------------------------------------------------------------------------
# This file was written to be called by MatLab through the 'jlcall' function of 
# the MATDaemon package. Running this function directly in Julia will produce an
# error.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles, ForwardDiff
include("../generators.jl")

# ------------------------------------------------------------------------------
# Generates useful info about the problem based on the global variable 'np'
# ------------------------------------------------------------------------------

# Generates the problem
( x0, l, u, fmin ) = problem_generator_hs(np)

# Informs MatLab about initial guest, problem dimension, and number of 
# functions that make up fmin.
problem_init_dim() = x0, length(x0), length(fmin)

# ------------------------------------------------------------------------------
# Problem definition (objective function and constraints) for GRANSO
# ------------------------------------------------------------------------------

# Defines the objective function and its gradient
function obj(x, fmin)

    m = length(fmin)
    fx = fmin[1](x)
    f_index = 1
    for i=2:m

        fy = fmin[i](x)

        if fy < fx

            fx = fy
            f_index = i

        end

    end

    return fx, ForwardDiff.gradient(fmin[f_index], x)

end

# Defines the inequality constraints function and its gradient
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