import LinearAlgebra: norm, dot

function problem_generator_qd(num_fi::Int64, data::Vector{Float64})

    n = 10
    nn = length(data)
    u = 10.0 * ones(10)

    fmin = Vector{Function}(undef, num_fi)

    K = 5.0

    for i = 1:(num_fi-1)

        d_init = 2 * (i - 1) * n + 1
        d_last = d_init + n - 1
        x_init = d_last + 1
        x_last = x_init + n - 1

        k = K ^ i
        d = 1000 * ( @view data[d_init:d_last] )
        x0 = ( @view data[x_init:x_last] ) .* u

        fmin[i] = x -> k + 0.5 * sum((d[j] * (x[j] - x0[j]) ^ 2 for j = 1:n))

    end

    c = @view data[(nn - n + 1):end]
    @. c = c / norm(c, 2)
    @views c[1] = (K ^ (num_fi + 1) - dot(c[2:end], u[2:end])) / u[1]

    fmin[num_fi] = x -> dot(c, x)

    return fmin

end