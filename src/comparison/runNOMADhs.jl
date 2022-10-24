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
# Run HS testset
# ------------------------------------------------------------------------------

function runtest_hs(
                    filename::String
                    )

    total_prob = 87

    directory = pwd()

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob )\n")

        data_filename = directory * "/data_files/HS/NOMAD/$(i).dat"

        # Generates the problem.
        (x0, l, u, fmin) = problem_generator_hs(i)

        # Defines objective function
        f_obj(x) = obj(x, fmin)

        function eval_fct(x)
            bb_outputs = [f_obj(x)]
            success = true
            count_eval = true
            return (success, count_eval, bb_outputs)
        end

        n = length(x0)

        prob = NomadProblem(n, 1, ["OBJ"], eval_fct; lower_bound=l, upper_bound=u)

        prob.options.max_bb_eval = 1100
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
filename = directory * "/data_files/HS/NOMAD.dat"


# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_hs(filename)