using DelimitedFiles
using LOWDER

include("generators.jl")

# -----------------------------------------------
# Path to files
# -----------------------------------------------
source_filename = "CUTEr_selected_problems.dat"
filename = "./data_files/mw_test_set_unconstrained_01.dat"

# -----------------------------------------------
# LOWDER parameters
# -----------------------------------------------
δ = 2.0
Δ = 2.0
m = 3

# -----------------------------------------------

problems = readdlm( source_file_name )
total_prob = size( problems )[ 1 ]

file = open( filename, "w" )

for i = 1 : total_prob

    try
        
        # Generates the problem
        ( x, l, u, fmin ) = problem_generator_mw( problems[i, 1], problems[i, 2], problems[i, 3], problems[i, 4]; unconstrained = true)

        # Solves the problems using 'lowder'
        sol = LOWDER.lowder( fmin, x, l, u, δ, Δ; m )

        # Saves info
        text = "$( i ) $( sol.status ) $( sol.true_val ) $( sol.iter ) $( sol.nf ) $( sol.index ) $( sol.f )"
        print( file, text )
        for j = 1 : ( problems[ i, 2 ] - 1 )

            print( file, sol.solution[ j ] )

        end
        println( file, sol.solution[ problems[ i, 2 ] ] )

    catch

        println( file, "$( i ) execution_fail" )

    end

end

close( file )