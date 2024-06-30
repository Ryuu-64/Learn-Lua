local Object = require("oop.object")

--- @class Time:Object
local Time = {}
Time.__index = Time
Time.staticFiled1 = 1

function Time:new()
    local instance = Object:new(self)
    instance.age = 14
    instance.height = 150
    instance._type = "Time"
    setmetatable(instance, self)
    return instance
end

return Time
