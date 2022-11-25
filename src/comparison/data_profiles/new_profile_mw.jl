# ------------------------------------------------------------------------------
# Packages and files
# ------------------------------------------------------------------------------

using DelimitedFiles, Plots

include("new_data_profile.jl")
include("../MW/jl/generator_mw.jl")


# ------------------------------------------------------------------------------
# Data Profile for MW testset
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
    H = create_matrix_mw(n_prob, n_feval, solvers_names)

    # Generates the data profiles for the specified gates.
    gate = [1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7]
    #for i in eachindex(gate)
    #    data_profile(H, N, solvers_names; τ=gate[i])
    #    savefig("./images/data_profile_mw_$(i).png")
    #end

    images_vec = Vector(undef, length(gate))
    for i in eachindex(gate)
        images_vec[i] = data_profile(H, N, P, solvers_names; τ=gate[i])
    end
    plot(images_vec[1], images_vec[2], images_vec[3], images_vec[4], layout = length(gate), size=(1200, 800))
    savefig("./images/new_version/data_profile_mw.png")

end

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function create_matrix_mw(n_prob, n_feval, solvers_names)

    n_solvers = length(solvers_names)
    data = Inf * ones(Float64, (n_feval, n_prob, n_solvers))
    directory = pwd()

    for solver in eachindex(solvers_names)

        data_solver = readdlm(directory * "/data_files/MW/$(solvers_names[solver]).dat")[:, 2]

        for problem=1:n_prob
           
            try

                if data_solver[problem] == "success"

                    data_filename = directory * "/data_files/MW/$(solvers_names[solver])/$(problem).dat"
                    data_raw = readdlm(data_filename)

                    n_reg = min(length(data_raw), n_feval)
                    data[1:n_reg, problem, solver] = data_raw[1:n_reg]

                end
               
            catch

                println("ERROR: Unable to read the file $(problem).dat of solver $(solvers_names[solver]).")

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