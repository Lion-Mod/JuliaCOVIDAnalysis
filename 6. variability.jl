using Plots
using Statistics

function walk(number_of_steps)
    x = 0

    # Generate -1 or 1 with 0.5 chance for each
    for i in 1:number_of_steps
        x += rand((-1, +1))
    end

    return x
end

# Create experiments
experiment(number_of_steps, number_of_walks) = [walk(number_of_steps) for i in 1:number_of_walks]

# 2000 walks with 20 steps each
data = experiment(20, 2000);

# Plot histogram then norm it to get probabilty distribution
# Plot mean as dashed line
histogram(data, normed = true)
vline!([mean(data)], lw = 5, ls = :dash, legend = false)

variance = var(data)
σ = std(data)

# Centering the data around the mean
centered_data = data .- mean(data)

histogram(centered_data)
vline!([mean(data)], lw = 5, ls = :dash, legend = false)

