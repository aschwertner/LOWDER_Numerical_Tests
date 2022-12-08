using Plots, Printf

function data_profile(
                        H_data::Array{Float64, 3},
                        N::Array{Float64, 1},
                        P::Array{Float64, 1},
                        labels::Array{String, 1};
                        τ::Real=1.0e-3
                        )

    # Cria uma cópia de H_data
    H = deepcopy(H_data)

    # Calcula as dimensões do array H.
    (nf, np, ns) = size(H)

    # Verificações iniciais.
    @assert τ > 0.0 "τ must be positive."
    @assert length(N) == np "N must have dimension $(np)."
    @assert length(labels) == ns "S must have dimension $(ns)."

    # Produz um array de histórico, com entradas ordenadas.
    for i = 1:ns
        for j = 2:nf
            H[j, :, i] .= min.(H[j, :, i], H[j-1, :, i]) 
        end
    end

    # Calcula o valor inicial e o menor valor encontrado para cada problema. 
    # Usamos dados do segundo solver MS-P, pois LOWDER considera avaliações de fi, ao inves da função objetivo fmin.
    prob_max = H[1, :, 2]
    prob_min = minimum(minimum(H, dims = 1), dims = 3)

    # Determina o custo (ex: avaliações de função objetivo) necessário para atingir o valor de corte, para cada problema e solucionador.
    T = zeros(np, ns)
    for i = 1:np
        cutoff = prob_min[i] + τ * (prob_max[i] - prob_min[i])
        for j = 1:ns
            nfevs = findfirst(H[:, i, j] .≤ cutoff)
            if isnothing(nfevs)
                T[i, j] = NaN
            else
                if labels[j] == "LOWDER"
                    T[i, j] = nfevs / ( P[i] * N[i])
                else
                    T[i, j] = nfevs / N[i]
                end            
            end
        end
    end

    # Substitui todos os valores NaN por duas vezes a razão máxima e ordena as entradas de T.
    max_data = maximum(T[.!(isnan.(T))])
    T[isnan.(T)] .= 2.0 * max_data
    T .= sort(T, dims = 1)

    # Define um conjunto de cores e marcadores
    colors = [:black, :red, :blue, :orange, :yellow]
    nc = length(colors)

    # Desenha o data profile.
    xs = [1:np;] / np
    plt = plot(title = "τ = " * @sprintf("%.1e", τ), xlabel = "Number of simplex gradients", ylabel = "Proportion of problems")
    for i = 1:ns    
        plot!(plt, T[:, i], xs, t = :steppost, label = labels[i], linecolor = colors[mod(i, nc)], lw = 2)
    end
    #xlims!(0, 1.1 * max_data)
    xlims!(0, 100)
    ylims!(0, 1)

end