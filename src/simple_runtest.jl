using LOWDER

function f(x)

    return x[1] ^ 2.0 + x[2] ^ 2.0

end

function g(x)

    return 0.5 * x[1] + 0.1 * x[2] + 1.0

end

fmin_list = [f, g]
x = [1.5, 1.0]
a = [-1.0, -2.0]
b = [1.5, 2.0]
δ = 0.5
Δ = 0.5

#sol = LOWDER.lowder(fmin_list, x, a, b, δ, Δ; m = 3, verbose = 3, filename="./data_files/simple_runtest_02.dat")
sol = LOWDER.lowder(fmin_list, x, a, b, δ, Δ; m = 3)