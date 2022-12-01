local M = {}

function M.read_file_single(filename)
    local file = io.open(filename, 'r')
    if file then
        local content = file:read'a':gsub('%s+', '')
        file:close()
        return content
    end
end

function M.read_file_multi(filename)
    local content = {}
    for  line in io.lines(filename) do
        table.insert(content, line)
    end
    return content
end

function M.sum(array)
    local accumulator = 0
    for _, value in ipairs(array) do
        accumulator = accumulator + value
    end
    return accumulator
end

function M.product(array)
    local accumulator = 1
    for _, value in ipairs(array) do
        accumulator = accumulator * value
    end
    return accumulator
end

local function _permutation(sequence, n)
    n = n or #sequence

    if n == 1 then
        coroutine.yield(sequence)
    else
        for i=1,n do
            sequence[n], sequence[i] = sequence[i], sequence[n]
            _permutation(sequence, n - 1)
            sequence[n], sequence[i] = sequence[i], sequence[n]
        end
    end
end

function M.permutations(sequence)
    local co = coroutine.create(function() _permutation(sequence) end)
    return function()
        local _, res = coroutine.resume(co)
        return res
    end

end


function M.unique(sequence)
    local set = {}

    if type(sequence) == 'table' then
        for _, char in ipairs(sequence) do set[char] = true end
    elseif type(sequence) == 'string' then
        sequence:gsub('.', function(s) set[s] = true end)
    end

    return set
end

return M
