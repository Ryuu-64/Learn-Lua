local MetadataTable = {}
MetadataTable.__index = MetadataTable
MetadataTable._classNameTable = {}
MetadataTable._nameClassTable = {}
MetadataTable._extendTable = {}

function MetadataTable.AddExtend(class, baseClass)
    MetadataTable._extendTable[class] = baseClass
end

function MetadataTable.AddClass(class, name)
    MetadataTable._classNameTable[class] = name
    MetadataTable._nameClassTable[name] = class
end

function MetadataTable.HasClassForName(name)
    return MetadataTable._nameClassTable[name] ~= nil
end

function MetadataTable.GetClass(name)
    return MetadataTable._nameClassTable[name]
end

function MetadataTable.GetParent(class)
    return MetadataTable._extendTable[class];
end

function MetadataTable.GetParentByName(name)
    local class = MetadataTable.GetClass(name)
    return MetadataTable.GetParent(class)
end

return MetadataTable
