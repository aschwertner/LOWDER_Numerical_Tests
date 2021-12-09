using DelimitedFiles
using LOWDER

include("generators.jl")

function runtest_hs(
                    n_points::Int64,
                    filename::String
                    )

    file = open( filename, "w" )

    for i = 1:100

        try
        
            # Generates the problem
            ( x, l, u, fmin ) = problem_generator_hs( i )
    
            n = length(x)
            p = length(fmin)
    
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