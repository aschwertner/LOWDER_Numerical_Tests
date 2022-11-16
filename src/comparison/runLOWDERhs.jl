# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using LOWDER
using Printf

include("HS/jl/generator_hs.jl")

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function f_obj(fmin, fileID)

    m = length(fmin)
    new_fmin = Array{Function}(undef, m)

    for i in eachindex(fmin)
        new_fmin[i] = x -> print_eval(x, fmin[i], fileID)
    end

    return new_fmin

end

function print_eval(x, f, fileID)

    fx = f(x)

    println(fileID, @sprintf("%.7e", fx))

    return fx
    
end

# ------------------------------------------------------------------------------
# Run HS testset
# ------------------------------------------------------------------------------

function runtest_hs(
                    filename::String
                    )

    fileID_1 = open(filename, "w")
    total_prob = 87

    directory = pwd()

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob ) ... ")

        data_filename = directory * "/data_files/HS/LOWDER/$(i).dat"
        fileID_2 = open(data_filename, "w")

        try
            
            # Generates the problem.
            (x, l, u, fmin) = problem_generator_hs(i)

            new_fmin = f_obj(fmin, fileID_2)

            n = length(x)
            n_points = n + 1
            p = length(fmin)

            # Solves the problem using 'lowder'.
            sol = LOWDER.lowder(new_fmin, x, l, u; m = n_points, maxfun = p * 1100)

            # Saves info about solution.
            text = @sprintf("%d success %.7e %s ", i, sol.f, sol.true_val) * "[" * join([@sprintf "%.3e" x for x in sol.solution], ", ") * "] "

            println(fileID_1, text)

            # Display info.
            println("succes!")

        catch

            text = @sprintf("%d failure NaN NaN NaN", i)
            println(fileID_1, text)

            # Display info.
            println("failure!")

        end

        close(fileID_2)

    end

    close(fileID_1)

end


# ------------------------------------------------------------------------------
# Path to file
# ------------------------------------------------------------------------------

directory = pwd()
filename = directory * "/data_files/HS/LOWDER.dat"


# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_hs(filename)