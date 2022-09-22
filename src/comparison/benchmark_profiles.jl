using BenchmarkProfiles, DelimitedFiles, Plots


function generate_data_profile(s::Symbol; save_figure::Bool=false)

    if s == :mw

        LOWDER_data_raw = readdlm("./data_files/mw_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/mw_GRANSO.dat")

        scaling = LOWDER_data_raw[:, 1] .+ 1.0

        np = length(scaling)
        data = zeros(Float64, (1, np, 2))
        data[1,:,1] = LOWDER_data_raw[:, 4]
        data[1,:,2] = GRANSO_data_raw[:, 4]

        data_profile(PlotsBackend(), data, scaling, ["LOWDER", "GRANSO"]; τ=1.0e-4, operations="function evaluations divided by n(p)+1", title="Data Profile")

        if save_figure

            savefig("./images/data_profile_mw.png")

        end

    elseif s == :hs

        LOWDER_data_raw = readdlm("./data_files/hs_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/hs_GRANSO.dat")

        scaling = LOWDER_data_raw[:, 1] .+ 1.0

        np = length(scaling)
        data = zeros(Float64, (1, np, 2))
        data[1,:,1] = LOWDER_data_raw[:, 4]
        data[1,:,2] = GRANSO_data_raw[:, 4]

        data_profile(PlotsBackend(), data, scaling, ["LOWDER", "GRANSO"]; τ=1.0e-4, operations="function evaluations divided by n(p)+1", title="Data Profile")
    
        if save_figure

            savefig("./images/data_profile_hs.png")

        end

    else

        println("Invalid option. Please choose:")
        println("   :mw, for MW testset; or,")
        println("   :hs, for HS testset.")

    end

end

function generate_performance_profile(s::Symbol; save_figure::Bool=false)

    if s == :mw

        LOWDER_data_raw = readdlm("./data_files/mw_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/mw_GRANSO.dat")

        np = size(LOWDER_data_raw)[1]
        data = zeros(Float64, (np, 2))
        data[:, 1] = LOWDER_data_raw[:, 4]
        data[:, 2] = GRANSO_data_raw[:, 4]

        performance_profile(PlotsBackend(), data, ["LOWDER", "GRANSO"]; title="Performance Profile")

        if save_figure

            savefig("./images/performance_profile_mw.png")

        end

    elseif s == :hs

        LOWDER_data_raw = readdlm("./data_files/hs_LOWDER.dat")
        GRANSO_data_raw = readdlm("./data_files/hs_GRANSO.dat")

        np = size(LOWDER_data_raw)[1]
        data = zeros(Float64, (np, 2))
        data[:, 1] = LOWDER_data_raw[:, 4]
        data[:, 2] = GRANSO_data_raw[:, 4]

        performance_profile(PlotsBackend(), data, ["LOWDER", "GRANSO"]; title="Performance Profile")
    
        if save_figure

            savefig("./images/performance_profile_hs.png")

        end

    else

        println("Invalid option. Please choose:")
        println("   :mw, for MW testset; or,")
        println("   :hs, for HS testset.")

    end

end


#generate_performance_profile(:hs; save_figure = true)
#generate_data_profile(:hs; save_figure = true)