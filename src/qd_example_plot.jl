import Random: seed!
import LinearAlgebra: norm, dot
using Plots; gr()

function genprob(num_fi; sd::Int64=abs(rand(Int64)))

    fmin_list = Vector{Function}(undef, num_fi)

    n = 2

    l = zeros(Float64, n)
    u = 10.0 * ones(Float64, n)

    sd = 38904589 + sd
    
    seed!(sd)

    K = 5.0

    for i = 1:num_fi

        fmin_list[i] = let

            local _n = n
            local k = K^i
            local d = 1000 * rand(n)
            local x0 = rand(n) .* u

            (x) -> k + 0.5 * sum((d[j] * (x[j] - x0[j])^2 for j = 1:_n))

        end

    end
   
    return fmin_list, l, u
    
end

function plot_contour_surface(
                        func_list::Array{Function,1},
                        a::Vector{Float64},
                        b::Vector{Float64};
                        p_step::Float64=1.0e-2,
                        p_levels::Int64=30,
                        p_fill::Bool=true
                        )

    # Creates 'x' and 'y'
    x = a[1]:p_step:b[1]
    y = a[2]:p_step:b[2]

    fmin(x, y) = minimum((func_list[i]([x,y]) for i = 1:length(func_list)))

    plot_problem = contour(x, y, fmin, levels = p_levels, fill = p_fill)
    plot( plot_problem, aspec_ratio = :equal )
    savefig( "./images/contour_qd.png" )

    plot_surface = surface(x, y, fmin)
    plot( plot_surface, aspec_ratio = :equal )
    savefig( "./images/surface_qd.png" )

end

# -----------------------------------------------
# Problem definition and plot
# -----------------------------------------------

num_fi = 10

fmin_list, l, u = genprob(num_fi)

plot_contour_surface( fmin_list, l, u)