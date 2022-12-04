local utils = require('utils')


local HAND_TO_INDEX = {
    A = 1, B = 2, C = 3,
    X = 1, Y = 2, Z = 3
}

local DIFFERENCE_TO_SCORE = {
    [0] = 3,
    [1] = 6,
    [-2] = 6,
    [-1] = 0,
    [2] = 0
}

local RESULT_TO_SCORE = {
    X = 0,
    Y = 3,
    Z = 6
}


local function result(elf, you)
    return DIFFERENCE_TO_SCORE[HAND_TO_INDEX[you] - HAND_TO_INDEX[elf]]
end

local function hand_score(result, elf)
    local elf_index = HAND_TO_INDEX[elf]
    if result == 'Y' then
        return elf_index
    elseif result == 'X' then
        return elf_index == 1 and 3 or elf_index - 1
    else
        return elf_index == 3 and 1 or elf_index + 1
    end
end

local function total_score(rounds)
    local score_1 = 0
    local score_2 = 0

    for _, round in ipairs(rounds) do
        local elf, you_or_result = round:match('(%a) (%a)')
        score_1 = score_1 + HAND_TO_INDEX[you_or_result] + result(elf, you_or_result)

        score_2 = score_2 + hand_score(you_or_result, elf) + RESULT_TO_SCORE[you_or_result]
    end

    return score_1, score_2
end


local test_rounds = {
    'A Y',
    'B X',
    'C Z',
}

local test_score_1, test_score_2 = total_score(test_rounds)
assert(test_score_2 == 12)
assert(test_score_1 == 15)

local rounds = utils.read_file_multi('inputs/day2.txt')
local score_1, score_2 = total_score(rounds)
assert(score_1 == 11873)
assert(score_2 == 12014)
