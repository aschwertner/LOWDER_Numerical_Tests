# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using LOWDER
using Printf

include("../generators.jl")


# ------------------------------------------------------------------------------
# Run MW testset
# ------------------------------------------------------------------------------

function runtest_mw(
                    filename::String;
                    unconstrained_prob::Bool=true
                    )

    directory = pwd()
    source_filename = directory * "/src/CUTEr_selected_problems.dat"

    problems = readdlm( source_filename, Int64 )
    total_prob = size( problems )[ 1 ]

    file = open( filename, "w" )

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob ) ... ")

        data_filename = directory * "/data_files/MW/LOWDER/$(i).dat"

        # Initializes useful constants
        nprob = problems[i, 1]
        n = problems[i, 2]
        p = problems[i, 3]
        rsp = convert( Bool, problems[i, 4] )
        n_points = n + 1

        try
            
            # Generates the problem.
            ( x, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; 
                                    unconstrained = unconstrained_prob )

            # Solves the problem using 'lowder'.
            sol = LOWDER.lowder( fmin, x, l, u; m = n_points, maxfun = (1300 * p), history_filename = data_filename)

            # Saves info about solution.
            nfmin = sol.nf / p
            text = @sprintf("%d %d %.2f %d %.4e %.4e %s %s", n, sol.iter, 
                        nfmin, sol.nf, sol.f, sol.stationarity, sol.true_val, 
                        sol.status);
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
filename = directory * "/data_files/mw_LOWDER.dat"


# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_mw(filename)