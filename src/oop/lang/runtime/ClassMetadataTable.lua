---@class ClassMetadataTable
local ClassMetadataTable = {}
ClassMetadataTable.__index = ClassMetadataTable
function ClassMetadataTable:__tostring()
    return "ClassMetadataTable"
end

ClassMetadataTable.classNameTable = {}
ClassMetadataTable.nameClassTable = {}
ClassMetadataTable.classBaseClassTable = {}

---
---@param class Type
---@param baseClass Type
function ClassMetadataTable.AddBase(class, baseClass)
    ClassMetadataTable.classBaseClassTable[class] = baseClass
end

---
---@param class Type
---@param name string
function ClassMetadataTable.Add(class, name)
    ClassMetadataTable.classNameTable[class] = name
    ClassMetadataTable.nameClassTable[name] = class
end

---
---@param name string
function ClassMetadataTable.Has(name)
    return ClassMetadataTable.nameClassTable[name] ~= nil
end

---
---@param name string
---@return Type
function ClassMetadataTable.Get(name)
    return ClassMetadataTable.nameClassTable[name]
end

---
---@param name string
---@return Type
function ClassMetadataTable.GetBase(name)
    local class = ClassMetadataTable.Get(name)
    return ClassMetadataTable.classBaseClassTable[class]
end

return ClassMetadataTable
