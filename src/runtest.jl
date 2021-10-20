using DelimitedFiles
using LOWDER

include("generators.jl")

# -----------------------------------------------
# Path to files
# -----------------------------------------------
source_filename = "CUTEr_selected_problems.dat"
filename = "../data_files/mw_test_set_unconstrained_01.dat"

# -----------------------------------------------
# LOWDER parameters
# -----------------------------------------------
δ = 2.0
Δ = 2.0

# -----------------------------------------------

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
        ( x, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; unconstrained = true )

        # Solves the problem using 'lowder'
        sol = LOWDER.lowder( fmin, x, l, u, δ, Δ; m = n_points )

        # Saves info
        text = "$( sol.status ) $( sol.true_val ) $( sol.iter ) $( sol.nf ) $( sol.index ) $( sol.f )"
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