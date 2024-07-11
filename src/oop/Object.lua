local Runtime = require "oop.Runtime"

---
--- @class Object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local DummyClass
local Object = Runtime.inherit(Object, "List")
Object.__index = Object
Object._className = "Object"

function Object:new()
    return setmetatable({}, self)
end

---
--- Determines whether two object instances are equal.
--- @param object Object
function Object:Equals(object)
    return self == object
end

function Object:SetClassName(className)
    self._className = className
end

function Object:GetClassName()
    return self._className
end

return Object
