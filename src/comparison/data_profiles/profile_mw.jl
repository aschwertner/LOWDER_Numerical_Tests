# ------------------------------------------------------------------------------
# Packages and files
# ------------------------------------------------------------------------------

using DelimitedFiles, Plots

include("data_profile.jl")
include("../MW/jl/generator_mw.jl")


# ------------------------------------------------------------------------------
# Data Profile for HS testset
# ------------------------------------------------------------------------------

function generate_data_profile_mw()

    # Number of problemas.
    n_prob = 53

    # Maximum number of f_{i} evaluations.
    n_feval = 65 * 1300

    # Names of the solvers.
    solvers_names = ["LOWDER", "MSP", "NOMAD"]

    # Calculates the size of the simplex gradients and the number of functions 
    # f_{i} of each problem.
    N, P = scales_mw(n_prob)
    
    # Computes the cost matrix H.
    H = create_matrix_mw(n_prob, n_feval, solvers_names, P)

    # Generates the data profiles for the specified gates.
    gate = [1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7]
    for i in eachindex(gate)
        data_profile(H, N, solvers_names; τ=gate[i])
        savefig("./images/data_profile_mw_$(i).png")
    end

end

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function create_matrix_mw(n_prob, n_feval, solvers_names, P)

    n_solvers = length(solvers_names)
    data = Inf * ones(Float64, (n_feval, n_prob, n_solvers))
    directory = pwd()

    for solver in eachindex(solvers_names)

        for problem=1:n_prob

            if solvers_names[solver] == "LOWDER"
                factor = 1
            else
                factor = P[problem]
            end
            
            try

                data_filename = directory * "/data_files/MW/$(solvers_names[solver])/$(problem).dat"
                data_raw = readdlm(data_filename)

                n_reg = length(data_raw)

                for i=1:n_reg
                    data[Int(factor * i), problem, solver] = data_raw[i]
                end
               
            catch

                println("ERROR: Unable to read the file $(problem).dat of solver $(solver).")

            end

        end

    end

    return data

end

function scales_mw(n_prob)

    directory = pwd()
    source_filename = directory * "/src/comparison/MW/CUTEr_selected_problems.dat"
    problems = readdlm( source_filename)

    N = problems[1:n_prob, 2]
    P = problems[1:n_prob, 3]

    return N, P
    
end

# ------------------------------------------------------------------------------
# Calls the main function
# ------------------------------------------------------------------------------

generate_data_profile_mw()