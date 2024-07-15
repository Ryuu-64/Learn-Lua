local keyword = require "oop.constant.keyword"
local ClassMetadataTable = require "oop.lang.runtime.ClassMetadataTable"
local Exception = require "oop.exception.Exception"

---@class InterfaceException:Exception
local InterfaceException = setmetatable({}, Exception)
InterfaceException.__index = InterfaceException
InterfaceException._name = "InterfaceException"
InterfaceException._type = keyword.class
InterfaceException._interfaces = {}

ClassMetadataTable.Add(InterfaceException, InterfaceException._name)
ClassMetadataTable.AddBase(InterfaceException, Exception)

return InterfaceException
