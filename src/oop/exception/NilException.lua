local keyword = require "oop.constant.keyword"
local MetadataTable = require "oop.lang.runtime.ClassMetadataTable"
local Exception = require "oop.exception.Exception"

---@class NilException:Exception
local NilException = setmetatable({}, Exception)
NilException.__index = NilException
NilException._name = "NilException"
NilException._type = keyword.class
NilException._interfaces = {}

MetadataTable.AddClass(NilException, NilException._name)
MetadataTable.AddBaseClass(NilException, Exception)

return NilException
