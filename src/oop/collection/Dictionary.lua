local Runtime = require "oop.Runtime"
local Object = require "oop.Object"

---
--- @class Dictionary:Object
local Dictionary = Runtime.inherit("Dictionary", Object)

function Dictionary:new()
    local dictionary = Object.new(self)
    dictionary.pairs = {}
    return dictionary
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
