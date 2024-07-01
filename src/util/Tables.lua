local Functions = require("util.functions")

local Tables = {}
Tables.__index = Tables

local function InternalDeepToString(self, indent, isIndentSelf)
    local keys = {}

    --region sort by table keys
    for k in pairs(self) do
        table.insert(keys, k)
    end
    table.sort(keys)
    --endregion

    local string = ""
    if isIndentSelf then
        string = string .. string.rep(" ", indent)
    end
    string = string .. "(" .. tostring(self) .. ")" .. ":\n"
    for _, k in ipairs(keys) do
        local v = self[k]
        if type(v) == "table" and v ~= self then
            string = string .. string.rep(" ", indent) .. k
            string = string .. InternalDeepToString(v, indent * 2, false)
        elseif type(v) == "function" then
            string = string .. string.rep(" ", indent) .. "function:" .. k .. Functions.DeepToString(v) .. "\n"
        else
            string = string .. string.rep(" ", indent) .. k .. ":"
            if k == "__index" and self == v then
                string = string .. "(__index is table it self)"
            else
                string = string .. tostring(v)
            end
            string = string .. "\n"
        end
    end
    
    --region __index string
    if type(self.__index) ~= "nil" and self.__index ~= self then
        string = string .. string.rep(" ", indent) .. "__index:" .. "\n"
        string = string .. InternalDeepToString(self.__index, indent * 2, true)
    end
    --endregion

    return string
end

function Tables.DeepToString(self)
    return InternalDeepToString(self, 4, false)
end

return Tables
