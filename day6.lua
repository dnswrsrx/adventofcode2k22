local utils = require('utils')


local function first_indices(stream)
    local start = nil

    for i=1, #stream-13 do
        local unique = 0
        local set = utils.unique(stream:sub(i, i+3))
        for _, _ in pairs(set) do
            unique = unique + 1
            if unique == 4 then
                if not start then
                    start = i+3
                end

                for char, _ in pairs(utils.unique(stream:sub(i+4, i+13))) do
                    if not set[char] then
                        if unique == 13 then
                            return start, i+13
                        end
                        unique = unique + 1
                    end
                end
            end
        end
    end
end


local tests = {
    mjqjpqmgbljsphdztnvjfqwrcgsmlb = {7, 19},
    bvwbjplbgvbhsrlpgdmjqwftvncz = {5, 23},
    nppdvjthqldpwncqszvftbrmjlhg = {6, 23},
    nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg = {10, 29},
    zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw = {11, 26}
}

for stream, index in pairs(tests) do
    local start, message = first_indices(stream)
    assert(start == index[1])
    assert (message == index[2])
end

local stream = utils.read_file_single('inputs/day6.txt')
local start, message = first_indices(stream)
assert(start == 1582)
assert(message == 3588)
