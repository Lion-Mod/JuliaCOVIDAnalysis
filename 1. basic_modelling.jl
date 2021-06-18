## EXPONENTIAL GROWTH ##


using Plots

# PARAMETERS
# N = total population
# Iₙ  = number of infectious people on nth day
# Sₙ = number of suseptible people on nth day

# INITIAL CONDITIONS ("start time" or n = 0)
# N =
I₀ = 1
S₀ = N - 1

# GROWTH RATE
# c = number of people that one person infects
c = 0.01
λ = 1 + c

# MODEL
# Iₙ₊₁ = λIₙ

function run_basic_model(days::Int64)
    # Create empty array of length days and set first entry as 1
    I = zeros(days)
    I[1] = I₀

    # Run model up to days - 1
    for i in 1:(days - 1)
        I[i + 1] = λ * I[i]
    end

    # Return the model simulation array
    return I
end

# Run the model and store the results
one_hundred_days = run_basic_model(100)

# Plot the results
plot(log.(one_thousand_days), label = "I(n)", legend = :topleft)
xlabel!("day")
ylabel!("log(result)")