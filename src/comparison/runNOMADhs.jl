# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using NOMAD
using Printf

include("HS/jl/generator_hs.jl")

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


function projection_lowder_like!(x, l, u)

    δ = min(minimum(u - l) / 2.0, 1.0)
    n = length(x)

    for i=1:n
        lo = l[i] - x[i]
        uo = u[i] - x[i]
        if ( lo ≥ - δ )
            if (lo ≥ 0.0)
                x[i] = l[i]
            else
                x[i] = l[i] + δ
            end
        elseif (uo ≤ δ)
            if (uo ≤ 0.0)
                x[i] = u[i]
            else
                x[i] = u[i] - δ
            end
        end
    end

end

# ------------------------------------------------------------------------------
# Run HS testset
# ------------------------------------------------------------------------------

function runtest_hs(
                    filename::String
                    )

    fileID_1 = open(filename, "w")
    total_prob = 87

    directory = pwd()

    for i = 1 : total_prob

        print("Running: $( i ) of $( total_prob )\n")

        data_filename = directory * "/data_files/HS/NOMAD/$(i).dat"
        fileID_2 = open(data_filename, "w")

        try

            # Generates the problem.
            (x0, l, u, fmin) = problem_generator_hs(i)

            # Projects initial guess in the box.
            projection_lowder_like!(x0, l, u)

            # Computes the number of variables.
            n = length(x0)

            # Defines objective function
            f_obj(x) = obj(x, fmin, fileID_2)

            function eval_fct(x)
                bb_outputs = [f_obj(x)]
                success = true
                count_eval = true
                return (success, count_eval, bb_outputs)
            end

            # Defines the NOMAD problem.
            prob = NomadProblem(n, 1, ["OBJ"], eval_fct; lower_bound=l, upper_bound=u)
            prob.options.max_bb_eval = 1100
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
filename = directory * "/data_files/HS/NOMAD.dat"


# ------------------------------------------------------------------------------
# Funtion call
# ------------------------------------------------------------------------------

runtest_hs(filename)