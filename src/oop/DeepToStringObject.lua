local Object = require("oop.object")

--- @class DeepToStringObject:Object
local DeepToStringObject = {}
DeepToStringObject.__index = DeepToStringObject
DeepToStringObject.filedE = "1"

function DeepToStringObject:new()
    local instance = Object:new(self)
    instance._type = "DeepToStringObject"
    instance.filedA = 14
    instance.filedB = 150
    instance.innerTable = {
        filedC = 1,
        filedD = "D",
        bar = function(a, b, ...)
            return "bar", a - b
        end,
        foo = function(x, y)
            return "foo", x + y
        end
    }
    setmetatable(instance, self)
    return instance
end

return DeepToStringObject
