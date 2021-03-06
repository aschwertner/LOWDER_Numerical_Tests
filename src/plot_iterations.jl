using DelimitedFiles
using Plots; gr()

function plot_iterations_linear(
                                a::Vector{Float64},
                                b::Vector{Float64},
                                filename::String,
                                imagename::String;
                                p_step::Float64=1.0e-2,
                                p_levels::Int64=30,
                                show_sample_set::Bool=false
                                )

    # Reads the execution data
    data = readdlm(filename)

    # Splits the useful data
    data_c = data[1:(end - 1), 14]
    data_g = data[1:(end - 1), 15:16]
    data_xbase = data[1:(end - 1), 17:18]
    data_xopt = data[1:(end - 1), 19:20]

    if show_sample_set

        data_Y = data[1:(end - 1), 24:27]

    end
    
    # Creates 'x' and 'y'
    x = a[1]:p_step:b[1]
    y = a[2]:p_step:b[2]

    # Generic model function
    function model_i(i, x, y)

        return data_c[i] + data_g[i, 1] * x + data_g[i, 2] * y
    
    end

    for i=1:length(data_c)

        # i-th iteration model 

        model(x, y) = model_i(i, x, y)
        plot_model = contour( x, y, model, levels = p_levels )

        if show_sample_set

            Y_x = [ data_Y[i, 1] + data_xbase[i, 1], data_Y[i, 3] + data_xbase[i, 1] ]
            Y_y = [ data_Y[i, 2] + data_xbase[i, 2], data_Y[i, 4] + data_xbase[i, 2] ]

            scatter!( plot_model, Y_x, Y_y, color = :gray40, markersize = 6, marker = :circle,  lab = "sample point" )
            
        end

        scatter!( plot_model, [ data_xbase[i, 1] ], [ data_xbase[i, 2] ], color = :green3, markersize = 12, marker = :circle,  lab = "xbase" )
        scatter!( plot_model, [ data_xopt[i, 1] ] , [ data_xopt[i, 2] ], color = :red  , markersize = 9,  marker = :diamond, lab = "xopt" )

        plot( plot_model, size = (900, 600))
        figname = string( imagename, "$(i)" )
        png( figname )

    end

end

# -----------------------------------------------
# Problem definition
# -----------------------------------------------

a = [0.0, 0.0]
b = [5.0, 5.0]
path_to_source = "./data_files/simple_runtest_01.dat"
path_to_image = "./images/test_01/fig_model_"

# -----------------------------------------------
# Function call 
# -----------------------------------------------

plot_iterations_linear( a, b, path_to_source, path_to_image; show_sample_set=true)