local Debugger = require "debug.emmy.Debugger"
local Dictionary = require "oop.collection.Dictionary"
local DeepToString = require "util.DeepToString"

Debugger.Connect()

local dictionary = Dictionary:new()

dictionary:Add("apple", 10)
dictionary:Add("banana", 5)
dictionary:Add(2, 5)

print(dictionary.data["apple"])         -- 输出：10
print(dictionary["apple"])              -- 输出：nil
print(dictionary:Get("apple"))          -- 输出：10
print(dictionary:ContainsKey("banana")) -- 输出：true
dictionary:Remove("banana")
print(dictionary:ContainsKey("banana")) -- 输出：false

table.insert(dictionary.data, "foo")
table.insert(dictionary.data, "bar")
table.insert(dictionary.data, 42)
print(dictionary:Get(1)) -- 输出：foo
print(DeepToString.of(dictionary.data))
