## LOGISTIC GROWTH (SIGMOID SHAPE) ##


using Plots

# PARAMETERS
# Each infectious person will come into contact with people but not always infect them
N = 100 # Total population
p = 0.01 # Probability of infecting each person
α = 0.1 # Fraction of the population

# MODEL
# Iₙ₊₁ = Iₙ + (pα(N - Iₙ)) * Iₙ

# Think of (pα(N - Iₙ)) as rate of infection
# β = pα(N - Iₙ)

I₀ = 1
β(S) = p * α * S

function logisticModel(days::Int64)
    # Create empty array of length days and set first entry as 1
    I = zeros(days)
    I[1] = I₀

    # Run model up to days - 1
    for i in 1:(days - 1)
        I[i + 1] = I[i] + β(N - I[i]) * I[i]
    end

    # Return the model simulation array
    return I
end

# Run the model and store the results
results = logisticModel(100)

plot(log.(results), label = "Logistic model", legend = :topleft)
xlabel!("day")
ylabel!("log(x)")