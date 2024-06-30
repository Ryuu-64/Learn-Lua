local Tables = require("util.tables")
local Time = require("oop.time")

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
--print("print(Tables.deepToString(t))")
--print(Tables.deepToString(t))

print("print(Tables.deepToString(Time:new()))")
print(Tables.deepToString(Time:new()))

--print("print(Tables.deepToString(Time.__index))")
--print(Tables.deepToString(Time.__index))
