# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using LOWDER
using Printf

include("HS/jl/generator_hs.jl")

# ------------------------------------------------------------------------------
# Run HS testset
# ------------------------------------------------------------------------------

function runtest_hs(
                    filename::String
                    )

    file = open(filename, "w")
    total_prob = 87

    directory = pwd()

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob ) ... ")

        data_filename = directory * "/data_files/HS/LOWDER/$(i).dat"

        try
            
            # Generates the problem.
            (x, l, u, fmin) = problem_generator_hs(i)

            n = length(x)
            n_points = n + 1
            p = length(fmin)

            # Solves the problem using 'lowder'.
            sol = LOWDER.lowder(fmin, x, l, u; m = n_points, maxfun = 1100, history_filename = data_filename)

            # Saves info about solution.
            text = @sprintf("%d success %.7e %s ", i, sol.f, sol.true_val) * "[" * join([@sprintf "%.3e" x for x in sol.solution], ", ") * "] "

            println(file, text)

            # Display info.
            println("succes!")

        catch

            text = @sprintf("%d failure NaN NaN NaN", i)
            println(file, text)

            # Display info.
            println("failure!")

        end

    end

    close(file)

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