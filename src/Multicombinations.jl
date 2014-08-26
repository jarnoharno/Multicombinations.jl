module Multicombinations
using Base

import Base: start, next, done, eltype, length

export multichoose, multicombinations, integersums, is2mc

# multichoose

function multichoose(n, k)
    binomial(n + k - 1, k)
end

# multicombinations

immutable MState{T}
    a::T
    k::Int
end

eltype(c::MState) = typeof(c.a)

eltype{T}(c::MState{UnitRange{T}}) = Array{T, 1}

eltype{T}(c::MState{Range{T}}) = Array{T, 1}

length(c::MState) = multichoose(length(c.a), c.k)

multicombinations(a, k::Integer) = MState(a, k)

function nextmulticombination(c::MState, s)
    s = copy(s)
    for i = c.k:-1:1
        if s[i] < endof(c.a)
            s[i] = nextind(c.a, s[i])
            for j = i:c.k-1
                s[j+1] = s[j]
            end
            return s
        end
    end
    return [0]
end

done(c::MState, s) = length(s) > 0 && s[1] < 1

function start(c::MState)
    if c.k > 0 && length(c.a) > 0
        ones(Int, c.k)
    elseif c.k == 0
        Array(Int, 0)
    else
        [0]
    end
end

function next(c::MState, s)
    r = c.a[s]
    s = nextmulticombination(c, s)
    (r, s)
end

# integer solutions to x_1 + x_2 + ... + x_n = k

immutable IState
    n::Int
    k::Int
end

eltype(c::IState) = Array{Int, 1}

length(c::IState) = multichoose(c.n, c.k)

integersums(n::Integer, k::Integer) = IState(n, k)

done(c::IState, s) = length(s) > 0 && s[1] < 0

function start(c::IState)
    if c.k >= 0 && c.n > 0
        [c.k, zeros(Int, c.n - 1)]
    elseif c.k == 0 && c.n == 0
        Array(Int, 0)
    else
        [-1]
    end
end

function nextintegersum(c::IState, s)
    if length(s) == 0 || s[end] == c.k
        return [-1]
    end
    s = copy(s)
    sum = 0
    i = 1
    while i < length(s)
        sum += s[i]
        if sum == c.k
            s[i] -= 1
            s[i+1] += 1
            return s
        end
        i += 1
    end
    i -= 1
    while s[i] == 0
        i -= 1
    end
    s[i] -= 1
    last = s[end]
    s[end] = 0
    s[i+1] = last + 1
    return s
end

next(c::IState, s) = (s, nextintegersum(c, s))

# conversion

function is2mc(s)
    ret = Array(Int, sum(s))
    k = 1
    for i = 1:length(s)
        for j = 1:s[i]
            ret[k] = i
            k += 1
        end
    end
    ret
end

end
