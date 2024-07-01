--- @class Object
local Object = {}
Object.__index = Object

function Object:new()
    local instance = {}
    instance._type = "Object"
    setmetatable(instance, self)
    return instance
end

function Object:getType()
    return self._type
end

return Object
