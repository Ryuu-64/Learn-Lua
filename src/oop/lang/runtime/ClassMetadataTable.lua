---@class ClassMetadataTable
local ClassMetadataTable = {}
ClassMetadataTable.__index = ClassMetadataTable

local classNameTable = {}
local nameClassTable = {}
local classBaseClassTable = {}

---
---@param class Type
---@param baseClass Type
function ClassMetadataTable.AddBaseClass(class, baseClass)
    classBaseClassTable[class] = baseClass
end

---
---@param class Type
---@param name string
function ClassMetadataTable.AddClass(class, name)
    classNameTable[class] = name
    nameClassTable[name] = class
end

---
---@param name string
function ClassMetadataTable.HasClass(name)
    return nameClassTable[name] ~= nil
end

---
---@param name string
---@return Type
function ClassMetadataTable.GetClass(name)
    return nameClassTable[name]
end

---
---@param name string
---@return Type
function ClassMetadataTable.GetBaseClass(name)
    local class = ClassMetadataTable.GetClass(name)
    return classBaseClassTable[class]
end

return ClassMetadataTable
