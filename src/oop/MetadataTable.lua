local MetadataTable = {}
MetadataTable.__index = MetadataTable
MetadataTable._classNameTable = {}
MetadataTable._nameClassTable = {}
MetadataTable._inheritTable = {}

function MetadataTable.AddInherit(derivedClass, baseClass)
    MetadataTable._inheritTable[derivedClass] = baseClass
end

function MetadataTable.AddClass(class, name)
    MetadataTable._classNameTable[class] = name
    MetadataTable._nameClassTable[name] = class
end

return MetadataTable
