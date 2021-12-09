using DelimitedFiles
using LOWDER

include("generators.jl")

function runtest_mw(
                    filename::String;
                    unconstrained_prob::Bool=false
                    )

    source_filename = "CUTEr_selected_problems.dat"

    problems = readdlm( source_filename, Int64 )
    total_prob = size( problems )[ 1 ]

    file = open( filename, "w" )

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob ) ... ")

        # Initializes useful constants
        nprob = problems[i, 1]
        n = problems[i, 2]
        p = problems[i, 3]
        rsp = convert( Bool, problems[i, 4] )
        n_points = n + 1

        try
            
            # Generates the problem
            ( x, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; unconstrained = unconstrained_prob )

            # Solves the problem using 'lowder'
            sol = LOWDER.lowder( fmin, x, l, u; m = n_points )

            # Saves info
            text = "$( n ) $( p ) $( sol.status ) $( sol.true_val ) $( sol.iter ) $( sol.nf ) $( sol.nf / p ) $( sol.stationarity ) $( sol.sample_radius ) $( sol.tr_radius ) $( sol.index ) $( sol.f )"
            print( file, text )
            for j = 1 : ( n - 1 )

                print( file, " $(sol.solution[ j ])" )

            end
            println( file, " $( sol.solution[ problems[ n ] ] )" )

            println("succes!")

        catch

            println( file, "execution_fail" )

            println("fail!")

        end

    end

    close( file )

end

# -----------------------------------------------
# Path to file
# -----------------------------------------------

filename = "../data_files/mw_uncons_test_beta_001.dat"

# -----------------------------------------------
# Funtion call
# -----------------------------------------------

runtest_mw( filename; unconstrained_prob = true )