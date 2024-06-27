local Object = {}

function Object:new()
    local instance = {}
    instance._type = "Object"
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Object:getType()
    return self._type
end

return Object
