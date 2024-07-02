local DeepToString = require("util.DeepToString")
local DeepToStringObject = require("oop.DeepToStringObject")

local t1 = {
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

local t2 = {
    table = t1
}

t1.table = t2

print(DeepToString.of(t1))

print(DeepToString.of(nil))

--function func(a, b, c)
--    return 42
--end

--print(DeepToString.of(func))
print(DeepToString.of(DeepToStringObject:new()))
