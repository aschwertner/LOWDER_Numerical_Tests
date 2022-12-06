# ------------------------------------------------------------------------------
# Packages and files
# ------------------------------------------------------------------------------

using DelimitedFiles, Plots

include("new_data_profile.jl")


# ------------------------------------------------------------------------------
# Data Profile for QD testset
# ------------------------------------------------------------------------------

function generate_data_profile_qd(num_fi)

    # Number of problemas.
    n_prob = 50

    # Dimension of the problems.
    n = 10

    # Maximum number of f_{i} evaluations.
    n_feval = num_fi * 1100

    # Names of the solvers.
    solvers_names = ["LOWDER", "MSP", "NOMAD"]

    # Calculates the size of the simplex gradients and the number of functions 
    # f_{i} of each problem.
    N = (n + 1) * ones(n_prob)
    P = num_fi * ones(n_prob)
    
    # Computes the cost matrix H.
    H = create_matrix_qd(num_fi, n_prob, n_feval, solvers_names)

    # Gates.
    gate = [1.0e-1, 1.0e-3, 1.0e-5, 1.0e-7]

    # Generates the data profiles for the specified gates.
    for i in eachindex(gate)
        data_profile(H, N, P, solvers_names; τ=gate[i])
        savefig("./images/QD/$(num_fi)/data_profile_qd_$(i).png")
    end

    # Generates the data profiles for the specified gates (one single figure).
    #images_vec = Vector(undef, length(gate))
    #for i in eachindex(gate)
    #    images_vec[i] = data_profile(H, N, P, solvers_names; τ=gate[i])
    #end
    #plot(images_vec[1], images_vec[2], images_vec[3], images_vec[4], layout = length(gate), size=(1200, 800))
    #savefig("./images/data_profile_qd_ts_$(num_fi).png")

end

# ------------------------------------------------------------------------------
# Auxiliary functions
# ------------------------------------------------------------------------------

function create_matrix_qd(num_fi, n_prob, n_feval, solvers_names)

    n_solvers = length(solvers_names)
    data = Inf * ones(Float64, (n_feval, n_prob, n_solvers))
    directory = pwd()

    for solver in eachindex(solvers_names)

        data_solver = readdlm(directory * "/data_files/QD/$(num_fi)/$(solvers_names[solver]).dat")[:, 2]

        for problem=1:n_prob
           
            try

                #if data_solver[problem] == "success"

                #    data_filename = directory * "/data_files/QD/$(num_fi)/$(solvers_names[solver])/$(problem).dat"
                #    data_raw = readdlm(data_filename)

                #    n_reg = min(length(data_raw), n_feval)
                #    data[1:n_reg, problem, solver] = data_raw[1:n_reg]
                    
                #end

                data_filename = directory * "/data_files/QD/$(num_fi)/$(solvers_names[solver])/$(problem).dat"
                data_raw = readdlm(data_filename)

                n_reg = min(length(data_raw), n_feval)
                data[1:n_reg, problem, solver] = data_raw[1:n_reg]
               
            catch

                println("ERROR: Unable to read the file $(problem).dat of solver $(solvers_names[solver]).")

            end

        end

    end

    return data

end


# ------------------------------------------------------------------------------
# Calls the main function
# ------------------------------------------------------------------------------

fi_dims = [10, 25, 50, 75, 100]

for i in eachindex(fi_dims)
    generate_data_profile_qd(fi_dims[i])
end