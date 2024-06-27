local Stack = require("stack")
local Object = require("object")
local Tables = require("misc")

local containsTestTable = { 'foo', 'bar' }

local isContains = Tables:contains(containsTestTable, 'foo')
print(isContains)

local object = Object:new()
print(Tables:recursivePrint(object.__index))

local stack = Stack:new()
print(Tables:recursivePrint(stack.__index))
