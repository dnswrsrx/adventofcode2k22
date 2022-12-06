local utils = require('utils')


local function execute(instructions, arrangement, part_2)
    for _, instruction in ipairs(instructions) do
        if instruction:match('move') then
            local number_to_move, origin, destination = instruction:match('move (%d+) from (%d+) to (%d+)')
            local temp = {}
            for i=1, tonumber(number_to_move) do
                if not part_2 then
                    table.insert(arrangement[tonumber(destination)], table.remove(arrangement[tonumber(origin)]))
                else
                    table.insert(temp, table.remove(arrangement[tonumber(origin)]))
                end
            end
            if part_2 then
                for i=1,#temp do
                    table.insert(arrangement[tonumber(destination)], table.remove(temp))
                end
            end
        end
    end
    return arrangement
end

local function execute_part_two(instructions, arrangement)
    for _, instruction in ipairs(instructions) do
        if instruction:match('move') then
            local number_to_move, origin, destination = instruction:match('move (%d+) from (%d+) to (%d+)')
        end
    end
    return arrangement
end

local test_arrangement = {
    {'Z', 'N'},
    {'M', 'C', 'D'},
    {'P'}
}

local test_instructions = {
    'move 1 from 2 to 1',
    'move 3 from 1 to 3',
    'move 2 from 2 to 1',
    'move 1 from 1 to 2',
}

local test_result = execute(test_instructions, test_arrangement, true)
-- for _, arr in ipairs(test_result) do print(arr[#arr]) end

local arrangement = {
    {'D', 'B', 'J', 'V'},
    {'P', 'V', 'B', 'W', 'R', 'D', 'F'},
    {'R', 'G', 'F', 'L', 'D', 'C', 'W', 'Q'},
    {'W', 'J', 'P', 'M', 'L', 'N', 'D', 'B'},
    {'H', 'N', 'B', 'P', 'C', 'S', 'Q'},
    {'R', 'D', 'B', 'S', 'N', 'G'},
    {'Z', 'B', 'P', 'M', 'Q', 'F', 'S', 'H'},
    {'W', 'L', 'F'},
    {'S', 'V', 'F', 'M', 'R'}
}

local instructions = utils.read_file_multi('inputs/day5.txt')
local result = execute(instructions, arrangement, true)
for _, arr in ipairs(arrangement) do print(arr[#arr]) end
