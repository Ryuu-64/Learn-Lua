local Functions = require("util.functions")

local Tables = {}
Tables.__index = Tables

function Tables.deepToString(self)
    return Tables.internalDeepToString(self, 4, false)
end

function Tables.internalDeepToString(self, indent, isIndentSelf)
    local keys = {}

    for k in pairs(self) do
        table.insert(keys, k)
    end
    table.sort(keys)
    local string = ""
    if isIndentSelf then
        string = string .. string.rep(" ", indent)
    end
    string = string .. "(" .. tostring(self) .. ")" .. ":\n"
    for _, k in ipairs(keys) do
        local v = self[k]
        if type(v) == "table" and v ~= self then
            string = string .. string.rep(" ", indent) .. k .. ":"
            string = string .. Tables.internalDeepToString(v, indent * 2, false)
        elseif type(v) == "function" then
            string = string .. string.rep(" ", indent) .. k .. ":" .. Functions.deepToString(v) .. "\n"
        else
            string = string .. string.rep(" ", indent) .. k .. ":" .. tostring(v) .. "\n"
        end
    end
    if type(self.__index) ~= "nil" and self.__index ~= self then
        string = string .. string.rep(" ", indent) .. "__index:" .. "\n"
        string = string .. Tables.internalDeepToString(self.__index, indent * 2, true)
    end
    return string
end

return Tables
