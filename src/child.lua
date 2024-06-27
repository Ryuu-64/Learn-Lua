local Object = require("object")

local Stack = Object:new()

function Stack:new()
    local instance = Object.new(self)
    instance._type = "Stack"
    instance.stack = {}
    return instance
end

function Object:getType()
    return "Stack"
end

return Stack;