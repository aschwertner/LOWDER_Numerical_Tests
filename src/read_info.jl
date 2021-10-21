using DelimitedFiles

filename = "./data_files/simple_runtest_02.dat"

# Reads the execution data
data = readdlm(filename)

# Dimension of the function domain
n = 2

# Number of points in sample set
m = 3

# Splits the useful data
data_c = data[1:(end - 1), 14]
data_g = data[1:(end - 1), 15:(14 + n)]
data_xbase = data[1:(end - 1), (15 + n):(14 + 2 * n)]
data_xopt = data[1:(end - 1), (15 + 2 * n):(14 + 3 * n)]
data_Y = data[1:(end - 1), (15 + 3 * n + m):(14 + 3 * n + m + n * (m - 1))]
data_d = data[1:(end - 1), (end - 1):end ]

it = 9
println("xbase: ", data_xbase[it, :])
println("xopt : ", data_xopt[it, :])
println("Y_{1}: ", data_Y[it, 1:2] + data_xbase[it, :])
println("Y_{2}: ", data_Y[it, 3:4] + data_xbase[it, :])