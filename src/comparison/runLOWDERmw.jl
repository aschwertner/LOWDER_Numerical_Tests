# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using LOWDER
using Printf

include("MW/jl/generator_mw.jl")


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
# Run MW testset
# ------------------------------------------------------------------------------

function runtest_mw(
                    filename::String;
                    unconstrained_prob::Bool=true
                    )

    directory = pwd()
    source_filename = directory * "/src/comparison/MW/CUTEr_selected_problems.dat"

    problems = readdlm( source_filename, Int64 )
    total_prob = size( problems )[ 1 ]

    fileID_1 = open( filename, "w" )

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob ) ... ")

        data_filename = directory * "/data_files/MW/LOWDER/$(i).dat"
        fileID_2 = open(data_filename, "w")

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

            new_fmin = f_obj(fmin, fileID_2)

            # Solves the problem using 'lowder'.
            #sol = LOWDER.lowder( new_fmin, x, l, u; m = n_points, maxfun = (1300 * p))
            sol = LOWDER.lowder( new_fmin, x, l, u; m = n_points, maxfun = (1300 * p), δmin = 1.0e-8)

            # Saves info about execution.
            text = @sprintf("%d success %.7e %s ", i, sol.f, sol.true_val) * "[" * join([@sprintf "%.3e" x for x in sol.solution], ", ") * "] "

            println(fileID_1, text)

            # Display info.
            println("succes!")

        catch

            # Saves info about execution.
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
filename = directory * "/data_files/MW/LOWDER.dat"


# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_mw(filename)