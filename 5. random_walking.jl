## RANDOM WALKING TO SHOW NORMAL DISTRIBUTION ##

using Plots
using StatsBase

# 0.5 probabilty for 1 or -1
# A jump is like a dot moving right or left on a line.
jump() = rand((-1, +1))


function random_walk(number_of_time_steps)
    position = 0
    positions = [position]

    for _ in 1:number_of_time_steps
        position += jump()
        push!(positions, position)
    end

    return positions
end

p = plot(legend = false)
end_of_walk = Int64[]
length_of_walk = 100


for _ in 1:10000
    walk = random_walk(length_of_walk);
    #plot!(walk)
    push!(end_of_walk, walk[length_of_walk]);
end

scatter(end_of_walk)
histogram(end_of_walk, bins = 20)