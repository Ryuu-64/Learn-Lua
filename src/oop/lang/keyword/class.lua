local keyword = require "oop.lang.keyword"
local ClassMetadataTable = require "oop.lang.runtime.ClassMetadataTable"
local ClassValidator = require "oop.lang.class.ClassValidator"
local Object = require "oop.Object"

local class = function(name, extend)
    --region create class
    if ClassMetadataTable.Has(name) then
        error("name already exist, name=" .. name)
    end

    local class = {}
    class.__index = class
    class._name = name
    class._type = keyword.class
    class._interfaces = {}
    ClassMetadataTable.Add(class, name)
    --endregion

    --region class extend
    if extend == nil then
        extend = Object
    end

    if not ClassValidator.Is(extend) then
        error("class name already exist, extend=" .. tostring(extend))
    end

    setmetatable(class, extend)
    if extend.__tostring ~= nil then
        class.__tostring = extend.__tostring
    end
    ClassMetadataTable.AddBase(class, extend)
    --endregion

    return class
end

return class
