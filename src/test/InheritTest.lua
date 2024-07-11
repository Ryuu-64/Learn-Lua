local Object = require("oop.Object")
local DeepToString = require("util.DeepToString")


--- @class Inherit:Object
local Inherit = setmetatable({}, Object)
Inherit.__index = Inherit
Inherit.field = 1
Inherit._className = "Inherit"

function Inherit:new()
    local instance = Object.new(self)
    instance.a = 2
    return instance
end

local inherit = Inherit:new()
print(DeepToString.of(inherit))
print(inherit:GetClassName())
