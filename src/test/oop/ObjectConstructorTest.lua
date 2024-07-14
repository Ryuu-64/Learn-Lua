local ClassImplements = require "oop.ClassImplements"
local Interface = require "oop.Interface"
local DeepToString = require "util.DeepToString"
local class = require "oop.lang.class.class"

local Constructor = Interface.interface("Constructor")

---
---@class ConstructorTestClass:Object
local ConstructorTestClass = class("ConstructorTestClass")

function ConstructorTestClass._constructor(this, a, b, c)
    this.a = a
    this.b = b
    this.c = c
end

ClassImplements.implements(ConstructorTestClass, { Constructor })

local test = ConstructorTestClass:new(1, 2, 3)

--print(DeepToString.of(ConstructorTestClass))
print(DeepToString.of(test))
