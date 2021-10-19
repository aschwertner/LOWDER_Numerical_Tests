using LOWDER

function f(x)

    return - 0.5 * x[1] + 10 * x[2]

end

function g(x)

    return x[1] ^ 2.0 + x[2] ^ 2.0

end

fmin_list = [f, g]
x = [2.0, 4.0]
a = [0.0, 0.0]
b = [5.0, 5.0]
δ = 1.0
Δ = 1.5

sol = LOWDER.lowder(fmin_list, x, a, b, δ, Δ; m = 3, maxit = 100, maxfun = 75, verbose = 3, filename="./data_files/simple_runtest.dat")