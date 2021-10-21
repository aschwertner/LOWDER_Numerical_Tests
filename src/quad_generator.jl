import Random: seed!
import LinearAlgebra: norm, dot

"""
    genprob(num_pts, u; sd=abs(rand(Int64)))

Generate a list of functions to generate function min_{i =
1:num_pts+1} f_i

"""
function genprob(num_pts, u; sd=abs(rand(Int64)))

    fmin_list = Vector{Function}(undef, num_pts + 1)

    n = length(u)

    l = zeros(Float64, n)

    sd = 38904589 + sd
    
    seed!(sd)

    K = 5.0

    for i = 1:num_pts

        fmin_list[i] = let

            local _n = n
            local k = K^i
            local d = 1000 * rand(n)
            local x0 = rand(n) .* u

            (x) -> k + 0.5 * sum((d[j] * (x[j] - x0[j])^2 for j = 1:_n))

        end

    end

    fmin_list[num_pts + 1] = let

        local c = rand(n)

        @. c = c / norm(c, 2)

        @views c[1] = (K^(num_pts + 2) - dot(c[2:end], u[2:end])) / u[1]

        (x) -> dot(c, x)

    end
    
    return fmin_list, l, u
    
end

function gen_fmin(flist)

    fmin = let
        
        fl = copy(flist)

        m = length(fl)
        
        (x, y) -> minimum((fl[i]([x, y]) for i = 1:m))
        
    end

    return fmin

end
