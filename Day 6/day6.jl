function findHighestIndex(input)
    highest = sort(input, rev=true)[1]
    return findfirst(input, highest)
end

function insertCircular(input, index, data)
    input[((index - 1) % length(input)) + 1] = data
    return input
end

function getCircular(input, index)
    return input[((index-1) % length(input)) + 1]
end

function realloc(input)
    hindex = findHighestIndex(input)
    highest = getCircular(input, hindex)
    input = insertCircular(input, hindex, 0)
    for i in hindex + 1:1:hindex + highest
        current = getCircular(input, i)
        input = insertCircular(input, i, current + 1)
    end
    return input
end

function recur(input)
    bank = Dict()
    steps = 0
    while true
        bank[copy(input)] = 1
        input = realloc(input)
        steps = steps + 1
        ~haskey(bank, input) || break
    end
    println(steps)
    return input
end

function main()
    input = []
    input = recur(input) # part 1
    recur(input) # part 2
end

main()