using BenchmarkProfiles, DelimitedFiles, Plots


function generate_data_profile(s::Symbol)

    if s == :mw

        LOWDER_data_raw = readdlm("./data_files/mw_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/mw_GRANSO.dat")

        scaling = LOWDER_data_raw[:, 1] .+ 1.0

        np = length(scaling)
        data = zeros(Float64, (1, np, 2))
        data[1,:,1] = LOWDER_data_raw[:, 4]
        data[1,:,2] = GRANSO_data_raw[:, 4]

        data_profile(PlotsBackend(), data, scaling, ["LOWDER", "GRANSO"]; τ=1.0e-4, operations="function evaluations divided by n(p)+1", title="Data Profile")

    elseif s == :hs

        LOWDER_data_raw = readdlm("./data_files/hs_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/hs_GRANSO.dat")

        scaling = LOWDER_data_raw[:, 1] .+ 1.0

        np = length(scaling)
        data = zeros(Float64, (1, np, 2))
        data[1,:,1] = LOWDER_data_raw[:, 4]
        data[1,:,2] = GRANSO_data_raw[:, 4]

        data_profile(PlotsBackend(), data, scaling, ["LOWDER", "GRANSO"]; τ=1.0e-4, operations="function evaluations divided by n(p)+1", title="Data Profile")
    
    else

        println("Invalid option. Please choose:")
        println("   :mw, for MW testset; or,")
        println("   :hs, for HS testset.")

    end

end

function generate_performance_profile(s::Symbol)

    if s == :mw

        LOWDER_data_raw = readdlm("./data_files/mw_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/mw_GRANSO.dat")

        np = size(LOWDER_data_raw)[1]
        data = zeros(Float64, (np, 2))
        data[:, 1] = LOWDER_data_raw[:, 5]
        data[:, 2] = GRANSO_data_raw[:, 5]

        performance_profile(PlotsBackend(), data, ["LOWDER", "GRANSO"]; title="Performance Profile")

    elseif s == :hs

        LOWDER_data_raw = readdlm("./data_files/hs_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/hs_GRANSO.dat")

        np = size(LOWDER_data_raw)[1]
        data = zeros(Float64, (np, 2))
        data[:, 1] = LOWDER_data_raw[:, 5]
        data[:, 2] = GRANSO_data_raw[:, 5]

        performance_profile(PlotsBackend(), data, ["LOWDER", "GRANSO"]; title="Performance Profile")
    
    else

        println("Invalid option. Please choose:")
        println("   :mw, for MW testset; or,")
        println("   :hs, for HS testset.")

    end

end


#generate_performance_profile(:hs)
#generate_data_profile(:mw)