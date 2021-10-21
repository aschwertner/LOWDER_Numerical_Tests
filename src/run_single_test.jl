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
δ = 2.0
Δ = 2.0

problems = readdlm( source_filename, Int64 )

# -----------------------------------------------
# Problem info
# -----------------------------------------------
i = 45
nprob = problems[i, 1]
n = problems[i, 2]
p = problems[i, 3]
rsp = convert( Bool, problems[i, 4] )
n_points = n + 1

# Generates the problem
( x, l, u, fmin ) = problem_generator_mw( nprob, n, p, rsp; unconstrained = true )

# Solves the problem using 'lowder'
sol = LOWDER.lowder( fmin, x, l, u, δ, Δ; m = n_points )