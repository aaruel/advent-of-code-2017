function fileLineCallback(filename, callback)
    local retList = {}
    for line in io.lines(filename) do
        local list = {}
        for num in line:gmatch("%w+") do
            table.insert(list, tonumber(num))
        end
        table.insert(retList, callback(list))
    end
    return retList
end

function rowDivisor(list)
    local listLength = #list
    for i = 1, listLength do
        for j = 1, listLength do
            local target = list[i]
            local divisor = list[j]
            if target % divisor == 0 and target ~= divisor then
                local divided = target/divisor
                return divided;
            end
        end
    end
end

function sumTable(list)
    local dtLength = #list
    local acc = 0
    for i = 1, dtLength do
        acc = acc + list[i]
    end
    return acc
end

local params = {...}
local file = params[1]
if file then
    local divisorTable = fileLineCallback(file, rowDivisor)
    print(sumTable(divisorTable))
end