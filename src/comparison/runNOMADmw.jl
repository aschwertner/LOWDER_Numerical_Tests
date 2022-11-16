# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using NOMAD
using Printf

include("MW/jl/generator_mw.jl")

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function obj(x, fmin, fileID)

    m = length(fmin)
    fx = fmin[1](x)
    for i=2:m

        fy = fmin[i](x)

        if fy < fx

            fx = fy

        end

    end

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

        print("Running: $( i ) of $( total_prob )\n")

        data_filename = directory * "/data_files/MW/NOMAD/$(i).dat"
        fileID_2 = open(data_filename, "w")

        # Initializes useful constants
        nprob = problems[i, 1]
        n = problems[i, 2]
        p = problems[i, 3]
        rsp = convert( Bool, problems[i, 4] )

        try

            # Generates the problem.
            ( x0, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; 
                                    unconstrained = unconstrained_prob )

            # Defines objective function
            f_obj(x) = obj(x, fmin, fileID_2)

            function eval_fct(x)
                bb_outputs = [f_obj(x)]
                success = true
                count_eval = true
                return (success, count_eval, bb_outputs)
            end

            prob = NomadProblem(n, 1, ["OBJ"], eval_fct; lower_bound=l, upper_bound=u)
            prob.options.max_bb_eval = 1300
            prob.options.display_degree = 0

            # Calls the solver.
            result = solve(prob, x0)

            # Saves info about solution.
            fsol = result.bbo_best_feas[1]
            text = @sprintf("%d success %.7e ", i, fsol) * "[" * join([@sprintf "%.3e" x for x in result.x_best_feas], ", ") * "] "
            println(fileID_1, text)

            # Display info.
            println("succes!")

        catch

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
filename = directory * "/data_files/MW/NOMAD.dat"

# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_mw(filename)