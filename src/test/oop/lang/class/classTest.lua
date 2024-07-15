local DeepToString = require "util.DeepToString"
local base = require "oop.class.base"
local class = require "oop.lang.class.class"

---@class Test: Object
local Test = class "Test"

function Test:new()
    local instance = base(Test)
    instance.foo = 37
    instance.bar = 42
    return instance
end

function Test.__tostring()
    return "Test(" ..
        "foo=" .. self.foo ..
        ", bar=" .. self.bar ..
        ")"
end

print(DeepToString.of(Test:new()))
