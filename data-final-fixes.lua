local icon_list = require('__stdlib__/stdlib/misc/queue')()
local utils = require("utils")
local global_type = "tile"  --this is a bad solution but it works
local pattern = "%.png$"

local z = 0
local function add_icon_to_list(data_table)
    z = z + 1
    --[[local list = {}
    for _, value in pairs(defines.types[global_type]) do
        list[value] = data_table[value]
    end]]
    icon_list:push_at(math.random(0, #icon_list)+1, table.deepcopy(data_table))
end

local function set_icons_back(data_table)
    local icon_data = icon_list:pop_last()
    if not icon_data then
        z = z + 1
    end
    --[[
    for key, value in pairs(icon_data) do
        data_table[key] = value
    end]]
    return icon_data
end

log("creating texture list")
utils.deep_search(data.raw[global_type], pattern, add_icon_to_list)
log(z)

z = 0
log("modifying textures")
utils.deep_search(data.raw[global_type], pattern, set_icons_back)
log(z)