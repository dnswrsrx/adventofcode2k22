local utils = require('utils')


local function priority(char)
    local byte = string.byte(char)
    if byte >= 97 then
        return byte - 96
    end
    return byte - 38
end


local function sum_shared(bags)
    local sum_1 = 0
    local sum_2 = 0

    local iteration = 0
    local set = {}

    for _, bag in ipairs(bags) do
        local first = bag:sub(0, #bag/2)
        local second = bag:sub(#bag/2 + 1)

        for char in first:gmatch('%a') do
            if second:find(char) then
                sum_1 = sum_1 + priority(char)
                break
            end
        end

        iteration = iteration + 1

        if iteration == 1 then
            set = utils.unique(bag)
        else
            for char, present in pairs(set) do
                if present then
                    if not bag:find(char) then
                        set[char] = false
                    end
                end
            end
        end

        if iteration == 3 then
            for char, present in pairs(set) do
                if present then
                    sum_2 = sum_2 + priority(char)
                    break
                end
            end

            iteration = 0
            set = {}
        end

    end

    return sum_1, sum_2
end


local tests = {
    'vJrwpWtwJgWrhcsFMMfFFhFp',
    'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
    'PmmdzqPrVvPwwTWBwg',
    'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
    'ttgJtRGJQctTZtZT',
    'CrZsJsPPZsGzwwsLwLmpwMDw',
}

local sum_1_test, sum_2_test = sum_shared(tests)
assert(sum_1_test == 157)
assert(sum_2_test == 70)

local bags = utils.read_file_multi('inputs/day3.txt')
local sum_1, sum_2 = sum_shared(bags)
assert(sum_1 == 8243)
assert(sum_2 == 2631)
