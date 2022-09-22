# ------------------------------------------------------------------------------
# Packages
# ------------------------------------------------------------------------------

using BenchmarkProfiles, DelimitedFiles, Plots


# ------------------------------------------------------------------------------
# Data Profile and Performance Profile
# ------------------------------------------------------------------------------

function generate_data_profile(s::Symbol)

    # Generates the data profile based on the number of objective function 
    # evaluations needed to solve the problem. As GRANSO uses information about
    # the gradient, the function evaluation count is penalized by 3x, to match 
    # the performance.

    if s == :mw

        LOWDER_data_raw = readdlm("./data_files/mw_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/mw_GRANSO.dat")

        scaling = LOWDER_data_raw[:, 1] .+ 1.0

        np = length(scaling)
        data = zeros(Float64, (1, np, 2))
        data[1,:,1] = LOWDER_data_raw[:, 4]
        data[1,:,2] = GRANSO_data_raw[:, 4] .* 4.0

        data_profile(
            PlotsBackend(), data, scaling, ["LOWDER", "GRANSO"]; 
            τ=1.0e-4, operations="function evaluations divided by n(p)+1", 
            title="Data Profile"
            )
        
        savefig("./images/data_profile_mw.png")

    elseif s == :hs

        LOWDER_data_raw = readdlm("./data_files/hs_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/hs_GRANSO.dat")

        scaling = LOWDER_data_raw[:, 1] .+ 1.0

        np = length(scaling)
        data = zeros(Float64, (1, np, 2))
        data[1,:,1] = LOWDER_data_raw[:, 4]
        data[1,:,2] = GRANSO_data_raw[:, 4] * 4.0

        data_profile(
            PlotsBackend(), data, scaling, ["LOWDER", "GRANSO"];
            τ=1.0e-4, operations="function evaluations divided by n(p)+1", 
            title="Data Profile"
            )

        savefig("./images/data_profile_hs.png")

    else

        println("Invalid option. Please choose:")
        println("   :mw, for MW testset; or,")
        println("   :hs, for HS testset.")

    end

end


function generate_performance_profile(s::Symbol)

    # Generates the performance profile based on the number of objective 
    # function evaluations needed to solve the problem. As GRANSO uses 
    # information about the gradient, the function evaluation count is 
    # penalized by 3x, to match the performance.

    if s == :mw

        LOWDER_data_raw = readdlm("./data_files/mw_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/mw_GRANSO.dat")

        np = size(LOWDER_data_raw)[1]
        data = zeros(Float64, (np, 2))
        data[:, 1] = LOWDER_data_raw[:, 4]
        data[:, 2] = GRANSO_data_raw[:, 4] .* 4.0

        performance_profile(
            PlotsBackend(), data, ["LOWDER", "GRANSO"]; 
            title="Performance Profile"
            )

        savefig("./images/performance_profile_mw.png")

    elseif s == :hs

        LOWDER_data_raw = readdlm("./data_files/hs_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/hs_GRANSO.dat")

        np = size(LOWDER_data_raw)[1]
        data = zeros(Float64, (np, 2))
        data[:, 1] = LOWDER_data_raw[:, 4]
        data[:, 2] = GRANSO_data_raw[:, 4] .* 4.0

        performance_profile(
            PlotsBackend(), data, ["LOWDER", "GRANSO"]; 
            title="Performance Profile"
            )

        savefig("./images/performance_profile_hs.png")

    else

        println("Invalid option. Please choose:")
        println("   :mw, for MW testset; or,")
        println("   :hs, for HS testset.")

    end

end


# ------------------------------------------------------------------------------
# Generates the profiles
# ------------------------------------------------------------------------------

generate_performance_profile(:hs)
generate_performance_profile(:mw)
generate_data_profile(:hs)
generate_data_profile(:mw)