local keyword    = require "oop.constant.keyword"
local class      = require "oop.lang.class.class"
local interface  = require "oop.lang.interface.interface"
local implements = require "oop.lang.keyword.implements"
local Assert     = require "test.Assert"
local Debugger   = require "debug.emmy.Debugger"

Debugger.Connect()

local TestInterface1 = interface("TestInterface1")

function TestInterface1.TestFunction1()
    return 37
end

local TestInterface2 = interface("TestInterface2")

function TestInterface2.TestFunction2()
    return 37
end

local TestInterface3 = interface("TestInterface3")

function TestInterface3.TestFunction3()
    return 37
end

function TestInterface3.TestFunction4()
    return 37
end

function TestInterface3.TestFunction5()
    return 37
end

implements(TestInterface2, { TestInterface1, TestInterface3 })

local function InvalidInnerInterfaceTest()
    local TestInterface4 = interface("TestInterface4")

    local status, resultOrError = pcall(
        implements,
        TestInterface4,
        {
            {
                _name = "TestInterface5",
                _type = keyword.interface,
                _interfaces = {
                    {
                        _name = "TestInterface6",
                        _type = keyword.interface
                    }
                }
            }
        }
    )
    Assert.Equal(false, status)
    print(resultOrError)
end

local function InvalidClassImplements()
    local TestClass = class("TestClass")

    function TestClass.TestFunction1()
        return 37
    end

    function TestClass.TestFunction2(foo, bar)
        return foo + bar
    end

    function TestClass.TestFunction3(...)
        return 37
    end

    function TestClass.TestFunction4(foo, bar, ...)
        return 37
    end

    local status, resultOrError = pcall(
        implements,
        TestClass,
        { TestInterface2 }
    )

    Assert.Equal(false, status)
end

InvalidInnerInterfaceTest()
InvalidClassImplements()
