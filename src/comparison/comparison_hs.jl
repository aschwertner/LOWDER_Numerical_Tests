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

granso_obj(x) = obj(x, fmin)
granso_cons(x) = cons(x, l, u)

# ------------------------------------------------------------------------------
# Problem definition (objective function and constraints) for MSP
# ------------------------------------------------------------------------------

# Defines the objective function
function obj_function(x, fmin)

    m = length(fmin)
    value = zeros(1, m)

    for i=1:m

        value[1, i] = fmin[i](x)

    end

    return value

end

function problem_info_bounds(x0, fmin, l, u)

    n = length(x0)
    
    X = zeros(1, n)
    L = zeros(1, n)
    U = zeros(1, n)

    for i = 1:n

        X[1, i] = x0[i]
        L[1, i] = l[i]
        U[1, i] = u[i]

    end

    return X, n, length(fmin), L, U    

end

msp_obj(x) = obj_function(x, fmin)
problem_init_dim_bounds() = problem_info_bounds(x0, fmin, l, u)