local utils = require('utils')


local function parse_min_maxes(elf_pair)
    local converted_digits = {}
    for digits in elf_pair:gmatch('%d+') do
        table.insert(converted_digits, tonumber(digits))
    end
    return converted_digits
end

local function has_complete_overlap(elf_1_min, elf_1_max, elf_2_min, elf_2_max)
    return (elf_1_min <= elf_2_min and elf_1_max >= elf_2_max) or (elf_2_min <= elf_1_min and elf_2_max >= elf_1_max)
end

local function has_partial_overlap(elf_1_min, elf_1_max, elf_2_min, elf_2_max)
    return (elf_2_max >= elf_1_max and elf_1_max >= elf_2_min) or (elf_1_max >=  elf_2_max and elf_2_max >= elf_1_min)
end

local function sum_redundant(elf_pairs)
    local complete_redundance = 0
    local partial_redundance = 0
    for _, elf_pair in ipairs(elf_pairs) do
        elf_pair = parse_min_maxes(elf_pair)

        if has_complete_overlap(table.unpack(elf_pair)) then
            complete_redundance = complete_redundance + 1
        end

        if has_partial_overlap(table.unpack(elf_pair)) then
            partial_redundance = partial_redundance + 1
        end
    end
    return complete_redundance, partial_redundance
end


local tests = {
    '2-4,6-8',
    '2-3,4-5',
    '5-7,7-9',
    '2-8,3-7',
    '6-6,4-6',
    '2-6,4-8',
}

local test_partial_sum, test_complete_sum = sum_redundant(tests)
assert (test_partial_sum == 2)
assert(test_complete_sum == 4)

local elf_pairs = utils.read_file_multi('inputs/day4.txt')
local partial_sum, complete_sum = sum_redundant(elf_pairs)
assert(partial_sum == 503)
assert(complete_sum == 827)
