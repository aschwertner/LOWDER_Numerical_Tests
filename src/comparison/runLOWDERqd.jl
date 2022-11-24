# ------------------------------------------------------------------------------
# Packages and other functions
# ------------------------------------------------------------------------------

using DelimitedFiles
using LOWDER
using Printf

include("QD/jl/generator_qd.jl")

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
# Run HS testset
# ------------------------------------------------------------------------------

function runtest_qd(
                    num_fi::Int64
                    )

    directory = pwd()
    source_filename = directory * "/src/comparison/QD/problems/testset_$(num_fi).dat"

    problems = readdlm(source_filename)
    total_prob = size(problems)[1]

    filename = directory * "/data_files/QD/$(num_fi)/LOWDER.dat"
    fileID_1 = open(filename, "w")

    for i = 1 : total_prob

        print("Testset QD $(num_fi) - Running: $( i ) of $( total_prob ) ... ")

        data_filename = directory * "/data_files/QD/$(num_fi)/LOWDER/$(i).dat"
        fileID_2 = open(data_filename, "w")

        try
            
            # Generates the problem.
            (x, l, u, fmin) = problem_generator_qd(num_fi, problems[i, :])

            new_fmin = f_obj(fmin, fileID_2)

            n = length(x)
            n_points = n + 1
            p = length(fmin)

            # Solves the problem using 'lowder'.
            #sol = LOWDER.lowder(new_fmin, x, l, u; m = n_points, maxfun = p * 1100)
            sol = LOWDER.lowder(new_fmin, x, l, u; m = n_points, maxfun = p * 1100, δmin = 1.0e-8)

            # Saves info about solution.
            text = @sprintf("%d success %.7e %s ", i, sol.f, sol.true_val) * "[" * join([@sprintf "%.3e" x for x in sol.solution], ", ") * "] "

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
# Funtion call
# ------------------------------------------------------------------------------

fi_dims = [10, 25, 50, 75, 100]

for i in eachindex(fi_dims)
    runtest_qd(fi_dims[i])
end