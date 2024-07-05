--- @class Object
local Object = {}
Object.__index = Object
Object._type = "Object"

function Object:new()
    return setmetatable({}, self)
end

function Object:GetType()
    return getmetatable(self)._type
end

return Object
