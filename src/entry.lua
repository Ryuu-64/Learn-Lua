local Tables = require("util.Tables")
local DeepToStringObject = require("oop.DeepToStringObject")

local t = {
    a = 1,
    b = 2,
    innerTable = {
        c = 1,
        d = 2,
    },
    foo = function(x, y)
        return "foo", x + y
    end,
    bar = function(a, b, ...)
        return "bar", a - b
    end
}

print(Tables.DeepToString(t))

print(Tables.DeepToString(DeepToStringObject:new()))
