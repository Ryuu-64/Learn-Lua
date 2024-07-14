local Class = require "oop.Class"

---
---@class Dictionary:Object
local Dictionary = Class.class("Dictionary")

function Dictionary.new(class)
    local instance = setmetatable({}, class)
    instance.pairs = {}
    return instance
end

function Dictionary:Add(key, value)
    self.pairs[key] = value
end

function Dictionary:Get(key)
    return self.pairs[key]
end

function Dictionary:Remove(key)
    self.pairs[key] = nil
end

function Dictionary:ContainsKey(key)
    return self.pairs[key] ~= nil
end

return Dictionary
