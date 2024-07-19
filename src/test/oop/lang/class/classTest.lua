local DeepToString = require "util.DeepToString"
local class = require "oop.lang.keyword.class"
local Object = require "oop.Object"

---@class Test: Object
local Test = class("Test")

function Test:new()
    local instance = Object.new(self)
    instance.foo = 37
    instance.bar = 42
    return instance
end

function Test:__tostring()
    return "Test(" ..
        "foo=" .. self.foo ..
        ", bar=" .. self.bar ..
        ")"
end

print(DeepToString.of(Test:new()))
