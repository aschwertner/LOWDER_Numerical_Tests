using LOWDER

# -----------------------------------------------
# Problem definition
# -----------------------------------------------

# This test set was taken from the MCPLIB, a library of
# complementarity problems
#
# This simple four-variable problem was given by:
# M. Kojima and S. Shindo, "Extensions of Newton and Quasi-Newton
# Method to PC^1 equations", Journal of Operations Research Society of
# Japan (29) p352-374.
#
# Two solutions: x1 = (1.2247, 0, 0, 0.5), x2 = (1, 0, 3, 0).

function f(x)

    F = [
        3 * x[1]^2 + 2 * x[1] * x[2] + 2 * x[2]^2 + x[3] + 3 * x[4] - 6,
        2 * x[1]^2 + x[2]^2 + x[1] + 10 * x[3] - 2 * x[4] - 2,
        3 * x[1]^2 + x[1] * x[2] + 2 * x[2]^2 + 2 * x[3] + 9 * x[4] - 9,
        x[1]^2 + 3 * x[2]^2 + 2 * x[3] + 3 * x[4] - 3
    ]

    α = 1.0e-2
    p = 1.5

    s = 0.0
    
    for (a, b) in zip(x, F)

        s += (α / 2) * max(0, a * b)^2 +
            (1/2) * ((abs(a)^p + abs(b)^p)^(1/p) - (a + b))^2

    end
        
    return s

end

n = 4

fmin_list = Vector{Function}([f])
x = 100 * ones(n)
a = zeros(n)
b = 1.0e2 * ones(n)

# -----------------------------------------------
# LOWDER parameters
# -----------------------------------------------

δinit = 1.0
Δinit = 1.2
n_points = 5
verbosity = 3

# -----------------------------------------------
# LOWDER call
# -----------------------------------------------

sol = LOWDER.lowder(fmin_list, x, a, b;
                    δ = δinit, Δ = Δinit, m = n_points, verbose = verbosity)
