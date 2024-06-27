local Tables = {}

function Tables:recursivePrint(tableIn)
    local string = "";

    -- 提取表中的键到一个数组中并排序
    local keys = {}
    for k in pairs(tableIn) do
        table.insert(keys, k)
    end
    table.sort(keys)

    print(tableIn)

    -- 按照排序后的键顺序迭代表
    for _, k in ipairs(keys) do
        string = string .. "field: " .. tostring(k) .. " value: " .. tostring(tableIn[k]) .. "\n"
    end

    --for k, v in pairs(tableIn) do
    --    if type(v) == "table" then
    --        if not v == tableIn then
    --            Tables:recursivePrint(v)
    --        end
    --    elseif type(v) == "function" then
    --        print("function name:", k)
    --    else
    --        print("field: " .. tostring(k) .. ", value: " .. tostring(v))
    --    end
    --end

    return string;
end

function Tables:contains(tableIn, value)
    for _, v in ipairs(tableIn) do
        if v == value then
            return true
        end
    end
    return false
end

return Tables;