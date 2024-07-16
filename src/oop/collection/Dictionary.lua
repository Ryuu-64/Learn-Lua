local class = require "oop.lang.class.class"
local Object = require "oop.Object"

---
---@class Dictionary:Object
local Dictionary = class("Dictionary")

function Dictionary:new()
    ---@type Dictionary
    local this = Object.new(self)
    this.pairs = {}
    return this
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
