# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using NOMAD
using Printf

include("../generators.jl")

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function redirect_to_files(dofunc, outfile, errfile)
    open(outfile, "w") do out
        open(errfile, "a") do err
            redirect_stdout(out) do
                redirect_stderr(err) do
                    dofunc()
                end
            end
        end
    end
end

function obj(x, fmin)

    m = length(fmin)
    fx = fmin[1](x)
    for i=2:m

        fy = fmin[i](x)

        if fy < fx

            fx = fy

        end

    end

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
    source_filename = directory * "/src/CUTEr_selected_problems.dat"

    problems = readdlm( source_filename, Int64 )
    total_prob = size( problems )[ 1 ]

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob )\n")

        data_filename = directory * "/data_files/MW/NOMAD/$(i).dat"

        # Initializes useful constants
        nprob = problems[i, 1]
        n = problems[i, 2]
        p = problems[i, 3]
        rsp = convert( Bool, problems[i, 4] )

        # Generates the problem.
        ( x0, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; 
                                unconstrained = unconstrained_prob )

        # Defines objective function
        f_obj(x) = obj(x, fmin)

        function eval_fct(x)
            bb_outputs = [f_obj(x)]
            success = true
            count_eval = true
            return (success, count_eval, bb_outputs)
        end

        prob = NomadProblem(n, 1, ["OBJ"], eval_fct; lower_bound=l, upper_bound=u)

        prob.options.max_bb_eval = 1300
        prob.options.display_all_eval = true
        prob.options.display_stats = ["BBE", "OBJ"]

        redirect_to_files(data_filename, filename) do
            result = solve(prob, x0)
            println(filename, "$(i) failure")
        end

    end

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