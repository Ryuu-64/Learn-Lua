local ClassMetadataTable = require "oop.lang.runtime.ClassMetadataTable"
local keyword = require "oop.constant.keyword"

---
---@class Object Supports all classes in the class hierarchy and provides low-level services to derived classes. It is the root of the type hierarchy.
local Object = setmetatable({}, nil)
Object.__index = Object
Object._name = "Object"
Object._type = keyword.class
Object._interfaces = {}

function Object:__tostring()
    return self._name
end

ClassMetadataTable.AddClass(Object, Object._name)
ClassMetadataTable.AddBaseClass(Object, getmetatable(Object))

---
---@return Object
function Object:new()
    ---@type Object
    local this = setmetatable({}, self)
    return this
end

---
---Determines whether two object instances are equal.
---@param object Object
function Object:Equals(object)
    return self == object
end

return Object
