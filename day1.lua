local utils = require('utils')


local function collect_totals(calories)
    local all_totals = {}
    local running_total = {}

    for _, calory in ipairs(calories) do
        if calory:find('%d') then
            table.insert(running_total, tonumber(calory))
        else
            table.insert(all_totals, utils.sum(running_total))
            running_total = {}
        end
    end
    table.insert(all_totals, utils.sum(running_total))
    table.sort(all_totals)
    return all_totals
end


local test_input = {
'1000',
'2000',
'3000',
'',
'4000',
'',
'5000',
'6000',
'',
'7000',
'8000',
'9000',
'',
'10000',
}

local test_calories = collect_totals(test_input)
assert(math.max(table.unpack(test_calories)) == 24000)
assert(utils.sum(table.pack(table.unpack(test_calories, #test_calories-2))) == 45000)


local calories = utils.read_file_multi('inputs/day1.txt')
local total_calories = collect_totals(calories)
assert(math.max(table.unpack(total_calories)) == 66719)
assert(utils.sum(table.pack(table.unpack(total_calories, #total_calories-2))) == 198551)
