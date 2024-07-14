local DeepToString = require "util.DeepToString"
local instantiate = require "oop.lang.class.instantiate"
local class = require "oop.lang.class.class"

---@class ObjectTest: Object
local ObjectTest = class("ObjectTest")

function ObjectTest:new()
    local this = instantiate(self)
    this.foo = 37
    this.bar = 42
    return this
end

function ObjectTest:__tostring()
    return self._name .. "(" ..
        "foo=" .. self.foo ..
        ", bar=" .. self.bar ..
        ")"
end

print(DeepToString.of(ObjectTest:new()))
