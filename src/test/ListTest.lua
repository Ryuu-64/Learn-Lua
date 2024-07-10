local List         = require("oop.collection.List")
local Debugger     = require "debug.emmy.Debugger"
local DeepToString = require "util.DeepToString"

Debugger.Connect()
local list = List:new()

print(DeepToString.of(list))

list:Add("apple")
list:Add("banana")
list:Add("orange")
list:Add("watermelon")
list:Add("peach")
list:Add("strawberry")
list:Add("pineapple")

print(list:Get(2))  -- 输出：banana
list:RemoveAt(1)
print(list:Count()) -- 输出：2
print(list:Get(1))  -- 输出：banana
print(list:Get(2))  -- 输出：orange

print(DeepToString.of(list.items))
list:Reverse()
print(DeepToString.of(list.items))

for i, v in ipairs(list) do
    print(i)
    print(v)
end
