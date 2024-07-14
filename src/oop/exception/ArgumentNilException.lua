local keyword = require "oop.constant.keyword"
local MetadataTable = require "oop.lang.runtime.MetadataTable"
local ArgumentException = require "oop.exception.ArgumentException"
  
---@class  :Exception
---@field message string
local ArgumentNilException = setmetatable({}, ArgumentException)
ArgumentNilException.__index = ArgumentNilException
ArgumentNilException._name = "ArgumentNilException"
ArgumentNilException._type = keyword.class
ArgumentNilException._interfaces = {}

MetadataTable.AddType(ArgumentNilException, ArgumentNilException._name)
MetadataTable.AddParent(ArgumentNilException, ArgumentException)

return ArgumentNilException
