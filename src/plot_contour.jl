using DelimitedFiles
using Plots; gr()

function plot_contour(
                        func_list::Array{Function,1},
                        a::Vector{Float64},
                        b::Vector{Float64},
                        figname::String;
                        p_step::Float64=1.0e-2,
                        p_levels::Int64=30,
                        p_fill::Bool=true
                        )

    # Creates 'x' and 'y'
    x = a[1]:p_step:b[1]
    y = a[2]:p_step:b[2]

    # fmin function
    function fmin(x, y)

        return min( func_list[1](x, y), func_list[2](x, y) )

    end

    plot_problem = contour(x, y, fmin, levels = p_levels, fill = p_fill)
    plot( plot_problem, aspec_ratio = :equal )
    png( figname )

end

# -----------------------------------------------
# Problem definition
# -----------------------------------------------

function f(x, y)

    return - 0.5 * x + 10 * y

end

function g(x, y)

    return x ^ 2.0 + y ^ 2.0

end

f_list = [f, g]
a = [ 0.0, 0.0 ]
b = [ 5.0, 5.0 ]
path_to_file = "./images/test_01/fig_contour"

# -----------------------------------------------
# Function call 
# -----------------------------------------------

plot_contour( f_list, a, b, path_to_file )