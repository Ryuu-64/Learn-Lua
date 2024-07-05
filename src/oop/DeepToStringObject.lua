local Object = require("oop.object")

--- @class DeepToStringObject:Object
local DeepToStringObject = setmetatable({}, Object)
DeepToStringObject.__index = DeepToStringObject
DeepToStringObject._type = "DeepToStringObject"
DeepToStringObject.filedE = "1"

function DeepToStringObject:new()
    local instance = Object.new(self)
    return instance
end

function DeepToStringObject:FooBar()
    return self.filedA + self.filedB
end

return DeepToStringObject
