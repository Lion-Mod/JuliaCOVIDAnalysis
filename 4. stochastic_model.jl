## STOCHASTIC MODEL ##

using Plots

function constrain(x)
    """
    Force a yes/no (1/0) someone is infected
    """
    if x > 1
        return 1
    elseif x < 0
        return 0
    else
        return x
    end
end

function recover_or_not(infectious_or_not, infection_rate, recovery_rate)
    """
    If someone isn't infectious (0) and they go above 0.5 then they become infectious.
    If someone is infectious (1) and they go below 0.5 then they become suseptible.

    Encorporate recovery_rate, infection_rate and randomness.
    """

    if infectious_or_not == 1
        recovered_or_infected = infectious_or_not + ((- recovery_rate) + infection_rate) - rand()

    else infectious_or_not == 0
        recovered_or_infected = infectious_or_not + ((- recovery_rate) + infection_rate) + rand()
    end

    return round(constrain(recovered_or_infected))
end

function run_stochastic_model(days_to_simulate::Int64)
    population_size = 100
    population = zeros(population_size, days_to_simulate)
    population[1, 1] = 1

    # Run simulation for days_to_simulate
    for i in 1:(days_to_simulate - 1)
        total_infectious_people = sum(population[:, i])

        # Infection rate takes into account the number of infectious people in the population and multiplies by 0.05 as infections could be more likely than recovery
        infection_rate = 0.05 * (total_infectious_people / population_size)

        # Recovery rate takes into account the number of healthy people in the population and multiplies by 0.025 as less likely to recover than be infected
        recovery_rate = 0.025 * (population_size - total_infectious_people) / population_size

        # For each individual test to see if they don't get infected/recover/get infected
        population[:, i + 1] = recover_or_not.(population[:, i], infection_rate, recovery_rate)
    end

    # Return the model simulation array
    return population
end

results = run_stochastic_model(100);

plot(sum.(eachcol(results)); label = false)
xlabel!("Day")
ylabel!("Number of infectious people")
