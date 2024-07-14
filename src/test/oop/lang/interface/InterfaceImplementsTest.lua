local class = require "oop.lang.class.class"
local interface = require "oop.lang.interface.interface"
local implements = require "oop.lang.implements"

local TestInterface1 = interface("TestInterface1")

function TestInterface1.TestFunction1()
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

local TestInterface2 = interface("TestInterface2")
implements(TestInterface2, { TestInterface1, TestInterface3 })

function TestInterface2.TestFunction2()
    return 37
end

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

implements(TestClass, { TestInterface2 })
