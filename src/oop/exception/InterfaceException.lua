local keyword = require "oop.constant.keyword"
local MetadataTable = require "oop.lang.runtime.MetadataTable"
local Exception = require "oop.exception.Exception"

---@class InterfaceException:Exception
---@field message string
local InterfaceException = setmetatable({}, Exception)
InterfaceException.__index = InterfaceException
InterfaceException._name = "InterfaceException"
InterfaceException._type = keyword.class
InterfaceException._interfaces = {}

MetadataTable.AddType(InterfaceException, InterfaceException._name)
MetadataTable.AddParent(InterfaceException, Exception)

return InterfaceException
