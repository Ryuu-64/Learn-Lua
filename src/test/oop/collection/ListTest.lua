local List     = require "oop.collection.List"
local Debugger = require "debug.emmy.Debugger"
local Assert   = require "test.Assert"

Debugger.Connect()
local list = List:new()

list:Add("apple")
list:Add("banana")
list:Add("orange")
list:Add("watermelon")
list:Add("peach")
list:Add("strawberry")
list:Add("pineapple")

Assert.Equals("[apple, banana, orange, watermelon, peach, strawberry, pineapple]", tostring(list))

Assert.Equals("banana", list:Get(2))

list:RemoveAt(1)

Assert.Equals(6, list:Count())

Assert.Equals("banana", list:Get(1))
Assert.Equals("orange", list:Get(2))
Assert.Equals("pineapple", list:Get(6))

list:Reverse()

Assert.Equals("[pineapple, strawberry, peach, watermelon, orange, banana]", tostring(list))

local expected = List:new({ "pineapple", "strawberry", "peach", "watermelon", "orange", "banana" })

Assert.Equals(expected, list)
