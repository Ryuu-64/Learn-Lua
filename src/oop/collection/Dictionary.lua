local Object = require("oop.Object")

--- @class Dictionary:Object
local Dictionary = setmetatable({}, Object)
Dictionary.__index = Dictionary
Dictionary:SetClassName("Dictionary")

function Dictionary:new()
    local instance = Object.new(self)
    instance.data = {}
    return instance
end

function Dictionary:Add(key, value)
    self.data[key] = value
end

function Dictionary:Get(key)
    return self.data[key]
end

function Dictionary:Remove(key)
    self.data[key] = nil
end

function Dictionary:ContainsKey(key)
    return self.data[key] ~= nil
end

return Dictionary
