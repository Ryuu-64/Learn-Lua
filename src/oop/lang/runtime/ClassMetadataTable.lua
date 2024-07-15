---@class ClassMetadataTable
local ClassMetadataTable = {}
ClassMetadataTable.__index = ClassMetadataTable

local classNameTable = {}
local nameClassTable = {}
local classBaseClassTable = {}

---
---@param class Type
---@param baseClass Type
function ClassMetadataTable.AddBase(class, baseClass)
    classBaseClassTable[class] = baseClass
end

---
---@param class Type
---@param name string
function ClassMetadataTable.Add(class, name)
    classNameTable[class] = name
    nameClassTable[name] = class
end

---
---@param name string
function ClassMetadataTable.Has(name)
    return nameClassTable[name] ~= nil
end

---
---@param name string
---@return Type
function ClassMetadataTable.Get(name)
    return nameClassTable[name]
end

---
---@param name string
---@return Type
function ClassMetadataTable.GetBase(name)
    local class = ClassMetadataTable.Get(name)
    return classBaseClassTable[class]
end

return ClassMetadataTable
