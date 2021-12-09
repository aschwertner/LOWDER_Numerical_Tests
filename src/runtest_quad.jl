using DelimitedFiles
using LOWDER

include("quad_generator.jl")

function runtest_quad(
                        list::Vector{Int64},
                        filename::String;
                        n::Int64=2
                        )

    nprob = length(list)

    file = open( filename, "w" )

    for i = 1:nprob

        try
        
            # Generates the problem
            ( fmin, l, u ) = genprob( list[i], 10.0 * ones( Float64, n ) )
    
            x = ones( Float64, n)
            p = length(fmin)
            n_points = n + 1
    
            # Solves the problem using 'lowder'
            sol = LOWDER.lowder( fmin, x, l, u; m = n_points )
    
            # Saves info
            text = "$( n ) $( p ) $( sol.status ) $( sol.true_val ) $( sol.iter ) $( sol.nf ) $( sol.nf / p ) $( sol.stationarity ) $( sol.sample_radius ) $( sol.tr_radius ) $( sol.index ) $( sol.f )"
            print( file, text )
            for j = 1 : ( n - 1 )
    
                print( file, " $(sol.solution[ j ])" )
    
            end
            println( file, " $( sol.solution[ n ] )" )
    
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

filename = "../data_files/quad_cons.dat"

# -----------------------------------------------
# Funtion call
# -----------------------------------------------

list = [2, 5, 10, 15, 20, 50, 100]

runtest_quad(list, filename)