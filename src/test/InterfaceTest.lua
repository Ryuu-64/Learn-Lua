local Class = require "oop.Class"
local Object = require "oop.Object"
local Interface = require "oop.Interface"
local DummyInterface = require "oop.DummyInterface"
local Debugger = require "debug.emmy.Debugger"

Debugger.Connect()

local TestInterface1 = Interface.implements("TestInterface1", { DummyInterface })

function TestInterface1.TestFunction1()
    return 37
end

local TestInterface3 = Interface.implements("TestInterface3", { DummyInterface })

function TestInterface3.TestFunction3()
    return 37
end

function TestInterface3.TestFunction4()
    return 37
end

function TestInterface3.TestFunction5()
    return 37
end

local TestInterface2 = Interface.implements("TestInterface2", { TestInterface1, TestInterface3 })

function TestInterface2.TestFunction2()
    return 37
end

local TestClass = Class.extend("TestClass", Object)

function TestClass.TestFunction1()
    return 37
end

--function TestClass.TestFunction2()
--    return 37
--end

--function TestClass.TestFunction3()
--    return 37
--end

Class.implements(TestClass, { TestInterface2 })
