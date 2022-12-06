import Random: seed!
using DelimitedFiles

function generate_quad_testset(num_fi::Int64; dim::Int64=10, num_prob::Int64=50, sd::Int64 = 0)

    directory = pwd()
    filename = directory * "/src/comparison/QD/problems/testset_$(num_fi).dat"
    fileID = open(filename, "w")

    sd = 38904589 + sd
    seed!(sd)

    #dvec = (2 * num_fi - 1) * dim #versão com a última função linear

    dvec = 2 * num_fi * dim

    data = rand(num_prob, dvec)

    for i=1:num_prob
        text = join([x for x in data[i, :]], " ")
        println(fileID, text)
    end

    close(fileID)

end

fi_dims = [10, 25, 50, 75, 100]

for i in eachindex(fi_dims)
    generate_quad_testset(fi_dims[i])
end