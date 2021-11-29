using DelimitedFiles
using LOWDER

include("generators.jl")

# -----------------------------------------------
# Path to file
# -----------------------------------------------
source_filename = "CUTEr_selected_problems.dat"

# -----------------------------------------------
# LOWDER parameters
# -----------------------------------------------
δinit = 2.0
Δinit = 2.0

problems = readdlm( source_filename, Int64 )

# -----------------------------------------------
# Problem info
# -----------------------------------------------
i = 28
nprob = problems[i, 1]
n = problems[i, 2]
p = problems[i, 3]
rsp = convert( Bool, problems[i, 4] )
n_points = n + 1

# Generates the problem
( x, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; unconstrained = true )

# Solves the problem using 'lowder'
sol = LOWDER.lowder( fmin, x, l, u; δ = δinit, Δ = Δinit, m = n_points, verbose = 3, filename="../data_files/simple_runtest_01.dat")