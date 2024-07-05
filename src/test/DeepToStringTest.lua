local DeepToString = require("util.DeepToString")
local DeepToStringObject = require("oop.DeepToStringObject")

--print("" .. DeepToString.of(nil))

local normalTable = {
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
--print("\nprint(DeepToString.of(normalTable))")
--print(DeepToString.of(normalTable))

local nestedTable1 = {
    filedInT1 = 1,
}

local nestedTable2 = {
    filedInT2 = 2,
    nestedTableInT2 = nestedTable1
}

nestedTable1.nestedTableInT1 = nestedTable2
--print("\nprint(DeepToString.of(nestedTable1))")
--print(DeepToString.of(nestedTable1))

local function func(a, b, c)
    return 42
end
--print("\nprint(DeepToString.of(func))")
--print(DeepToString.of(func))

--print("\nprint(DeepToString.of(DeepToStringObject:new()))")
local deepToStringObject = DeepToStringObject:new()
--print(DeepToString.of(deepToStringObject))

local tableWithFunctionMetaTable = {
    foo = "foo",
    bar = "bar"
}

setmetatable(tableWithFunctionMetaTable, {
    __index = function(foo, bar)
        return foo + bar
    end
})
--print("\nprint(DeepToString.of(tableWithFunctionMetaTable))")
--print(DeepToString.of(tableWithFunctionMetaTable))

local tableWithToStringNilMetaTable = {
    foo = "foo",
    bar = "bar"
}
setmetatable(tableWithToStringNilMetaTable, {
    __tostring = function()
        return "nil"
    end
})
--print("\nprint(DeepToString.of(tableWithToStringNilMetaTable))")
--print(DeepToString.of(tableWithToStringNilMetaTable))

local tableWith__index = {
    foo = "bar",
    bar = "foo",
    __index = function(foo, bar)
        return foo + bar
    end
}
--print("\nprint(DeepToString.of(tableWith__index))")
--print(DeepToString.of(tableWith__index))
