local Object = require "oop.Object"

--- @class DeepToStringObject:Object
local DeepToStringObject = setmetatable({}, Object)
DeepToStringObject.__index = DeepToStringObject
DeepToStringObject._className = "DeepToStringObject"
DeepToStringObject.filedE = "1"

function DeepToStringObject:new()
    return Object.new(self)
end

function DeepToStringObject:FooBar()
    return self.filedA + self.filedB
end

return DeepToStringObject
