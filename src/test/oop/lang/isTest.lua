local is = require "oop.lang.is"
local class = require "oop.lang.class.class"
local interface = require "oop.lang.interface.interface"
local implements = require "oop.lang.implements"
local Assert = require "test.Assert"

local isSelfClassTest = function()
    local TestClass1 = class("TestClass1")
    local test = TestClass1:new()

    Assert.True(is(test, TestClass1))
end

local isParenClassTest = function()
    local TestClass2 = class("TestClass2")
    local TestClass3 = class("TestClass3", TestClass2)
    local test = TestClass3:new()

    Assert.True(is(test, TestClass2))
    Assert.True(is(test, TestClass3))
end

local isSelfInterfaceTest = function()
    ---@class TestClass4:Object
    local TestClass4 = class("TestClass4")
    local TestInterface = interface("TestInterface")
    implements(TestClass4, { TestInterface })
    local test = TestClass4:new()

    Assert.True(is(test, TestInterface))
end

isSelfClassTest()
isParenClassTest()
isSelfInterfaceTest()
