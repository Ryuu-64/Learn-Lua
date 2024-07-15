local keyword = require "oop.constant.keyword"
local ClassMetadataTable = require "oop.lang.runtime.ClassMetadataTable"
local ArgumentException = require "oop.exception.ArgumentException"

---@class ArgumentNilException:Exception
local ArgumentNilException = setmetatable({}, ArgumentException)
ArgumentNilException.__index = ArgumentNilException
ArgumentNilException._name = "ArgumentNilException"
ArgumentNilException._type = keyword.class
ArgumentNilException._interfaces = {}

ClassMetadataTable.AddClass(ArgumentNilException, ArgumentNilException._name)
ClassMetadataTable.AddBaseClass(ArgumentNilException, ArgumentException)

return ArgumentNilException
