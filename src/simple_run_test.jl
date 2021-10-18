using LOWDER

function f(x)

    return ( 10.0 * ( x[2] - x[1] ^ 2.0 ) ) ^ 2.0 + ( 1.0 - x[1] ) ^ 2.0

end

function g(x)

    return ( -13.0 + x[1] + ( ( 5.0 - x[2] ) * x[2] - 2.0 ) * x[2] ) ^ 2.0 + ( -29.0 + x[1] + ( ( x[2] + 1.0 ) * x[2] - 14.0 ) * x[2] ) ^ 2.0

end

fmin_list = [f, g]
x = [5.0, 0.0]
a = [0.0, 0.0]
b = [5.0, 5.0]
δ = 1.0
Δ = 1.2

sol = LOWDER.lowder(fmin_list, x, a, b, δ, Δ; m = 3, maxit = 100, maxfun = 75, verbose = 3, filename="dados_execucao")
