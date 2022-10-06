# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using LOWDER
using Printf

include("../generators.jl")


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
            nfmin = sol.nf / p
            text = @sprintf("%d %d %.2f %d %.4e %.4e %s %s", n, sol.iter, 
                        nfmin, sol.nf, sol.f, sol.stationarity, sol.true_val, 
                        sol.status)
            println(file, text)

            # Display info.
            println("succes!")

        catch

            # Saves info about solution.
            println(file, "NaN NaN NaN NaN NaN NaN NaN NaN")

            # Display info.
            println("fail!")

        end

    end

    close(file)

end


# ------------------------------------------------------------------------------
# Path to file
# ------------------------------------------------------------------------------

directory = pwd()
filename = directory * "/data_files/hs_LOWDER.dat"


# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_hs(filename)