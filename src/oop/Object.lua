local MetadataTable = require "oop.lang.runtime.MetadataTable"
local keyword = require "oop.constant.keyword"

---
---**Overrides new() function to instantiate**
---
---Assume the class is MyClass, and it have field "foo" and "bar" in it
---function MyClass:new()
---    local myInstance = Object.new(self)
---    myInstance.foo = 42
---    myInstance.bar = 37
---    return myInstance
---end
---
---@class Object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local Object = setmetatable({}, nil)

Object.__index = Object
Object.__tostring = function()
    return "Object"
end

Object._name = "Object"
Object._type = keyword.class
Object._interfaces = {}

MetadataTable.AddType(Object, Object._name)
MetadataTable.AddParent(Object, getmetatable(Object))

function Object.__tostring(this)
    return this._name
end

---
---@param class Type
---@return Object
function Object.new(class)
    return setmetatable({}, class)
end

---
---Determines whether two object instances are equal.
---@param object Object
function Object:Equals(object)
    return self == object
end

return Object
