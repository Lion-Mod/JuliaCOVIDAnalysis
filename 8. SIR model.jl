"""
Using and SIR model with differential equation solvers.
"""
using DifferentialEquations
using Plots
using Measurements

# MODEL
# u(t) = (S(t), I(t), R(t))
# S(t) = proportion of population that are susceptible
# I(t) = proportion of population that are infected
# R(t) = proportion of population that are recovered

# PARAMETERS
# β, γ

# SIR model
function SIR_ode!(du, u, parameters, t)
    S, I, R = u
    β, γ = parameters

    dS = -β * S * I
    dI = β * S * I - (γ * I)
    dR = γ * I

    du .= (dS, dI, dR)
end

# Parameters
β = 0.1 ± 0.01
γ = 0.05 ± 0.01
parameters = [β, γ]

# Initial values
S₀ = 0.97 ± 0.02 # 99% susceptible
I₀ = 0.03 ± 0.02 # 1% infected
R₀ = 0.0 # 0% recovered
initial_values = [S₀, I₀, R₀]

# Time span (from start to end)
time_span = [0.0, 250.0]

# Solve the ODE
# i.e. find S(t), I(t), R(t)
problem = ODEProblem(SIR_ode!, initial_values, time_span, parameters)
solution = solve(problem, saveat = 0.1)

# Plot the solution including confidence bars
plot(solution, label = ["S" "I" "R"], alpha = 0.02)