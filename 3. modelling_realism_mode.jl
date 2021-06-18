## MORE REALISTIC MODEL(S) ##

using Plots


N = 100 # Total population
I₀ = 1

function run_realistic_model(days::Int64, c_average = 1.1)
    # Create empty array of length days and set first entry as 1
    I = zeros(days)
    I[1] = I₀

    # Run model up to days - 1
    for i in 1:(days - 1)
        c = c_average + 0.1 * randn() # Randomly change growth rate using randn()
        I[i + 1] = I[i] * c
    end

    # Return the model simulation array
    return I
end


# Run the model and store the results
results = run_realistic_model(50)

plot(log.(results), label = "realistic model", legend = :topleft)
xlabel!("day")
ylabel!("log(result)")