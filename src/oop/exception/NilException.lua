local keyword = require "oop.constant.keyword"
local MetadataTable = require "oop.lang.runtime.MetadataTable"
local Exception = require "oop.exception.Exception"

---@class NilException:Exception
---@field message string
local NilException = setmetatable({}, Exception)
NilException.__index = NilException
NilException._name = "NilException"
NilException._type = keyword.class
NilException._interfaces = {}

MetadataTable.AddType(NilException, NilException._name)
MetadataTable.AddParent(NilException, Exception)

return NilException
