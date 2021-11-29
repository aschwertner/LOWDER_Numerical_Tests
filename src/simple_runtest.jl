using LOWDER

# -----------------------------------------------
# Problem definition
# -----------------------------------------------

function f(x)

    return - 0.5 * x[1] + 10 * x[2]

end

function g(x)

    return x[1] ^ 2.0 + x[2] ^ 2.0

end

fmin_list = [f, g]
x = [1.0, 1.0]
a = [0.0, 0.0]
b = [5.0, 5.0]

# -----------------------------------------------
# LOWDER parameters
# -----------------------------------------------

δinit = 1.0
Δinit = 1.2
n_points = 3
verbosity = 3
path_to_file = "./data_files/simple_runtest_01.dat"

# -----------------------------------------------
# LOWDER call
# -----------------------------------------------

sol = LOWDER.lowder(fmin_list, x, a, b; δ = δinit, Δ = Δinit, m = n_points, verbose = verbosity, filename = path_to_file)