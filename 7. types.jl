## Abstract type ##
"""
Idea is there are two separate walkers (see 5. random_walking), discrete (moves -1 or 1) or continuous (moves continuously).

These feed into one abstract type RandomWalker which creates the type hierarchy.

Then from this you restrict function calls to certain types.
"""

## RandomWalker
abstract type RandomWalker end

current_position(walker::RandomWalker) = walker.x

# This acts differently depending on walk that is inputted.
function jump!(walker::RandomWalker)
    old_position = current_position(walker)
    set_position!(walker, old_position + jump(walker))
end


## DiscreteWalker ##
mutable struct DiscreteWalker <: RandomWalker
    x::Int64
end

DiscreteWalker() = DiscreteWalker(0)

function set_position!(walker::DiscreteWalker, z::Int64)
    walker.x = z
end

jump(walker::DiscreteWalker) = rand((-1, 1))



## ContinuousWalker ##
mutable struct ContinuousWalker <: RandomWalker
    x::Float64
end

ContinuousWalker() = ContinuousWalker(0.0)

function set_position!(walker::ContinuousWalker, z::Float64)
    walker.x = z
end

jump(walker::ContinuousWalker) = randn()



# DISCRETE
walker_a = DiscreteWalker()

jump!(walker_a)
current_position(walker_a)

# CONTINUOUS
walker_b = ContinuousWalker()

jump!(walker_b)
current_position(walker_b)

