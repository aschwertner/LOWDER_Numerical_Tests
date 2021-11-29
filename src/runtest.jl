using DelimitedFiles
using LOWDER

include("generators.jl")

function runtest_mw(
                    δ::Float64, 
                    Δ::Float64,
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
            sol = LOWDER.lowder( fmin, x, l, u; δ, Δ, m = n_points )

            # Saves info
            text = "$( n ) $( p ) $( sol.status ) $( sol.true_val ) $( sol.iter ) $( sol.nf ) $( sol.nf / p ) $( sol.stationarity ) $( sol.sample_radius ) $( sol.tr_radius ) $( sol.index ) $( sol.f )"
            print( file, text )
            for j = 1 : ( problems[ i, 2 ] - 1 )

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

filename = "../data_files/mw_uncons_test_v03_02.dat"

# -----------------------------------------------
# LOWDER parameters
# -----------------------------------------------

δinit = 2.0
Δinit = 2.0

# -----------------------------------------------
# Funtion call
# -----------------------------------------------

runtest_mw( δinit, Δinit, filename; unconstrained_prob = true )