local Class = require "oop.Class"
local DummyClass = require "oop.DummyClass"

---
---
---
--- **Overrides new() function to instantiate**
---
--- Assume the class is MyClass, and it have field "foo" and "bar" in it
--- function MyClass:new()
---     local myInstance = Object.new(self)
---     myInstance.foo = 42
---     myInstance.bar = 37
---     return myInstance
--- end
---
--- @class Object:DummyClass Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local Object = Class.extend("Object", DummyClass)

function Object:new()
    return setmetatable({}, self)
end

---
--- Determines whether two object instances are equal.
--- @param object Object
function Object:Equals(object)
    return self == object
end

return Object
