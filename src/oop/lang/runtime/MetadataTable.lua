---@class MetadataTable
local MetadataTable = {}
MetadataTable.__index = MetadataTable
local typeNameTable = {}
local nameTypeTable = {}
local parentTable = {}

---
---@param class Type
---@param baseClass Type
function MetadataTable.AddParent(class, baseClass)
    parentTable[class] = baseClass
end

---
---@param type Type
---@param name string
function MetadataTable.AddType(type, name)
    typeNameTable[type] = name
    nameTypeTable[name] = type
end

---
---@param name string
function MetadataTable.HasTypeForName(name)
    return nameTypeTable[name] ~= nil
end

---
---@param name string
---@return Type
function MetadataTable.GetType(name)
    return nameTypeTable[name]
end

---
---@param type Type
---@return Type
function MetadataTable.GetParent(type)
    return parentTable[type];
end

---
---@param name string
---@return Type
function MetadataTable.GetParentByName(name)
    local type = MetadataTable.GetType(name)
    return MetadataTable.GetParent(type)
end

return MetadataTable
