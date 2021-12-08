using LOWDER

fmin = Array{Function}(undef, 11)

for i = 1:11

    y = i + 14.0

    fmin[i] = x -> 2.0 * x[1] ^ 2.0 + 0.008 * y ^ 3.0 - 3.2 * y * x[1] - 2.0 * y

end

n_points = 2
l = [3.0]
u = [5.5]
xinit = [0.0]

sol = LOWDER.lowder( fmin, xinit, l, u; m = n_points )