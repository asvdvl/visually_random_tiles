local utils = {}
local defines = require("defines")

for i = 1, settings.startup["VRT_random_offset"].value do
    --If there is no direct way to set the seed,
    --I think the only option is to call the function n times, as is done here
    local x = math.random(1, 1)
end

function utils.deep_search(data_table, pattern, action)
    assert(data_table)
    assert(pattern)
    assert(action)

    for key, value in pairs(data_table) do
        if type(value) == "string" and value:find(pattern) then
            local result = action(data_table)
            if result then
                local keys = {}
                for key_n in pairs(data_table) do
                    keys[key_n] = 1
                end
                for key_n in pairs(keys) do
                    data_table[key_n] = nil
                end

                for key_n in pairs(result) do
                    data_table[key_n] = result[key_n]
                end
                return
            end
        elseif type(value) == "table" and key ~= "hr_version" then
            utils.deep_search(value, pattern, action)
        end
    end
end

return utils