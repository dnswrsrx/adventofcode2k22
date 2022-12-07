local utils = require('utils')


local function update_sizes(size, current_dir, sizes, parents)
    if sizes[current_dir] then
        sizes[current_dir] = sizes[current_dir] + size
    else
        sizes[current_dir] = size
    end

    if parents[current_dir] then
        return update_sizes(size, parents[current_dir], sizes, parents)
    end

    return sizes
end

local function directory_sizes(commands)

    local sizes = {}
    local parents = {}

    local current_dir

    for _, command in ipairs(commands) do
        if command:match('cd (.+)') then
            local dir = command:match('cd (.+)')
            if dir == '..' then
                current_dir = parents[current_dir]
            else
                if current_dir == '/' then
                    dir = current_dir..dir
                else
                    dir = (current_dir and current_dir..'/' or '')..dir
                end
                if current_dir then
                    parents[dir] = current_dir
                end
                current_dir = dir
            end
        elseif command:match('(%d+)') then
            update_sizes(tonumber(command:match('%d+')), current_dir, sizes, parents)
        end
    end
    return sizes
end

local function sum_under_100000(sizes)
    local sum = 0
    for dir, size in pairs(sizes) do
        if size <= 100000 then
            sum = sum + size
        end
    end
    return sum
end

local function closest_size_to_delete(sizes)
    local to_delete = 30000000 - (70000000 - sizes['/'])
    local smallest_difference
    local closest_size

    for _, size in pairs(sizes) do
        local delta = size - to_delete
        if delta >=0 and (not smallest_difference or delta < smallest_difference) then
            closest_size = size
            smallest_difference = delta
        end
    end

    return closest_size
end


local test_commands = {
    '$ cd /',
    '$ ls',
    'dir a',
    '14848514 b.txt',
    '8504156 c.dat',
    'dir d',
    '$ cd a',
    '$ ls',
    'dir e',
    '29116 f',
    '2557 g',
    '62596 h.lst',
    '$ cd e',
    '$ ls',
    '584 i',
    '$ cd ..',
    '$ cd ..',
    '$ cd d',
    '$ ls',
    '4060174 j',
    '8033020 d.log',
    '5626152 d.ext',
    '7214296 k',
}

local test_sizes = directory_sizes(test_commands)
assert(sum_under_100000(test_sizes) == 95437)
assert(closest_size_to_delete(test_sizes) == 24933642)

local commands = utils.read_file_multi('inputs/day7.txt')
local sizes = directory_sizes(commands)
assert(sum_under_100000(sizes) == 1428881)
assert(closest_size_to_delete(sizes) == 10475598)
