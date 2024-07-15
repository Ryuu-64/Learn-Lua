local keyword = require "oop.constant.keyword"
local ClassMetadataTable = require "oop.lang.runtime.ClassMetadataTable"

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

---
---@param a Object
---@param b Object
function Object.__eq(a, b)
    if #a._name ~= #b._name then
        return false
    end

    if #a._type ~= #b._type then
        return false
    end

    if #a._interfaces ~= #b._interfaces then
        return false
    end

    for i = 1, #a._interfaces do
        if a._interfaces[i] ~= b._interfaces[i] then
            return false
        end
    end

    return true
end

ClassMetadataTable.Add(Object, Object._name)
ClassMetadataTable.AddBase(Object, getmetatable(Object))

---
---@return Object
function Object:new()
    ---@type Object
    local this = setmetatable({}, self)
    return this
end

return Object
