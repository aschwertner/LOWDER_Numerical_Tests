# ------------------------------------------------------------------------------
# Packages and files
# ------------------------------------------------------------------------------

using DelimitedFiles, Plots

include("data_profile.jl")
include("../HS/jl/generator_hs.jl")


# ------------------------------------------------------------------------------
# Data Profile for HS testset
# ------------------------------------------------------------------------------

function generate_data_profile_hs()

    # Number of problemas.
    n_prob = 87

    # Maximum number of f_{i} evaluations.
    n_feval = 4400

    # Names of the solvers.
    solvers_names = ["LOWDER", "MSP", "NOMAD"]

    # Calculates the size of the simplex gradients and the number of functions 
    # f_{i} of each problem.
    N, P = scales_hs(n_prob)
    
    # Computes the cost matrix H.
    H = create_matrix_hs(n_prob, n_feval, solvers_names, P)

    # Generates the data profiles for the specified gates.
    gate = [1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7]
    #for i in eachindex(gate)
    #    data_profile(H, N, solvers_names; τ=gate[i])
    #    savefig("./images/data_profile_hs_$(i).png")
    #end

    images_vec = Vector(undef, length(gate))
    for i in eachindex(gate)
        images_vec[i] = data_profile(H, N, solvers_names; τ=gate[i])
    end
    plot(images_vec[1], images_vec[2], images_vec[3], images_vec[4], layout = length(gate), size=(1200, 800))
    savefig("./images/original_version/data_profile_hs.png")

end

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function create_matrix_hs(n_prob, n_feval, solvers_names, P)

    n_solvers = length(solvers_names)
    data = Inf * ones(Float64, (n_feval, n_prob, n_solvers))
    directory = pwd()

    for solver in eachindex(solvers_names)

        data_solver = readdlm(directory * "/data_files/HS/$(solvers_names[solver]).dat")[:, 2]

        for problem=1:n_prob

            if solvers_names[solver] == "LOWDER"
                factor = 1
            else
                factor = P[problem]
            end
            
            try

                if data_solver[problem] == "success"

                    data_filename = directory * "/data_files/HS/$(solvers_names[solver])/$(problem).dat"
                    data_raw = readdlm(data_filename)

                    n_reg = min(length(data_raw), n_feval)

                    for i=1:n_reg
                        data[Int(factor * i), problem, solver] = data_raw[i]
                    end

                end
               
            catch

                println("ERROR: Unable to read the file $(problem).dat of solver $(solvers_names[solver]).")

            end

        end

    end

    return data

end

function scales_hs(n_prob)

    N = zeros(n_prob)
    P = zeros(n_prob)

    for i=1:n_prob
        x, _, _, fmin = problem_generator_hs(i)
        N[i] = length(x) + 1
        P[i] = length(fmin)
    end

    return N, P
    
end

# ------------------------------------------------------------------------------
# Calls the main function
# ------------------------------------------------------------------------------

generate_data_profile_hs()