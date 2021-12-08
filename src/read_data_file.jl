using DelimitedFiles

function read_data(
                    problem::Int64,
                    filename::String
                    )

    # Reads the execution data
    data = readdlm(filename)

    # Print data
    println("Dimension: $(data[problem, 1])")
    println("N. functions: $(data[problem, 2])")
    println("Status: $(data[problem, 3])")
    println("True value: $(data[problem, 4])")
    println("N. iterations: $(data[problem, 5])")
    println("N. evaluations: $(data[problem, 6])")
    println("N. eval. / N. functions: $(data[problem, 7])")
    println("Stationarity: $(data[problem, 8])")
    println("δ: $(data[problem, 9])")
    println("Δ: $(data[problem, 10])")
    println("Index: $(data[problem, 11])")
    println("F. value: $(data[problem, 12])")
    println("Solution: $(data[problem, 13:(12+data[problem, 1])])")

end

filename = "../data_files/mw_uncons_test_beta_1.dat"

read_data(1, filename)