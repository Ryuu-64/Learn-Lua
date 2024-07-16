local class  = require "oop.lang.class.class"
local Object = require "oop.Object"
local Assert = require "test.Assert"

local function equals()
    local a = Object:new()
    local b = Object:new()
    Assert.Equal(a, b)
end

local function overrideNew()
    ---
    ---@class ObjectOverrideNewTest: Object
    ---@field foo number
    ---@field bar number
    local ObjectOverrideNewTest = class("ObjectTest")

    function ObjectOverrideNewTest:new()
        ---@type ObjectOverrideNewTest
        local this = Object:new()
        this.foo = 37
        this.bar = 42
        return this
    end

    local objectOverrideNewTest = ObjectOverrideNewTest:new()
    Assert.Equal(37, objectOverrideNewTest.foo)
    Assert.Equal(42, objectOverrideNewTest.bar)
end

equals()
overrideNew()

--function ObjectTest:__tostring()
--    return self._name .. "(" ..
--        "foo=" .. self.foo ..
--        ", bar=" .. self.bar ..
--        ")"
--end
