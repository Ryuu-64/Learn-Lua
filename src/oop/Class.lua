local Type = require "oop.constant.Type"
local DummyClass = require "oop.DummyClass"
local MetadataTable = require "oop.MetadataTable"
local Interface = require "oop.Interface"

local Class = {}

local function Is(class)
    if class._name == nil then
        return false
    end

    if class._type ~= Type.CLASS then
        return false
    end

    if type(class._interfaces) ~= "table" then
        return false
    end

    return true
end

local function CanExtend(name, baseClass)
    if not Is(baseClass) then
        --error("Invalid base class, parameter must be Class")
    end

    if name == "Object" and baseClass ~= DummyClass then
        --error("Invalid runtime inherit, Object parent must be DummyClass")
        return false
    end

    if name ~= "Object" and baseClass == DummyClass then
        --error("Invalid runtime inherit, Class parent can't be DummyClass")
        return false
    end

    if type(name) ~= "string" then
        --error("Invalid class name:" .. tostring(name))
        return false
    end

    if MetadataTable.HasClassForName(name) then
        --error("Class already exist, class name:" .. name)
        return false
    end

    return true
end

function Class.extend(name, baseClass)
    if not CanExtend(name, baseClass) then
        error("extend error")
        return
    end

    local class = setmetatable({}, baseClass)
    class.__index = class
    class._name = name
    class._type = Type.CLASS
    class._interfaces = {}

    MetadataTable.AddClass(class, name)
    MetadataTable.AddExtend(class, baseClass)
    return class
end

local function GetFunctionInfoTable(classOrInterface)
    local functionInfoTable = {}
    for name, value in pairs(classOrInterface) do
        if type(value) == "function" then
            local info = debug.getinfo(value, "u")
            functionInfoTable[name] = {
                isVarArg = info.isvararg,
                paramsCount = info.nparams
            }
        end
    end

    return functionInfoTable
end

local function CanImplement(class, interface)
    if not Is(class) then
        return false
    end

    if not Interface.is(interface) then
        return false
    end

    local interfaceTable = GetFunctionInfoTable(interface)
    local classTable = GetFunctionInfoTable(class)

    for name, info in pairs(interfaceTable) do
        local infoInClass = classTable[name]
        if infoInClass == nil then
            return false
        elseif infoInClass.isVarArg ~= info.isVarArg then
            return false
        elseif infoInClass.paramsCount ~= info.paramsCount then
            return false
        end
    end

    return true
end

local function CantImplementFunctionReason(functionName, infoInClass, infoInInterface)
    local reason = ""
    if infoInClass == nil then
        reason = "No such function."
    elseif infoInClass.isVarArg ~= infoInInterface.isVarArg then
        reason = "Incorrect 'Variable Number of Arguments'. " ..
            "Expected " .. tostring(infoInInterface.isVarArg) .. "," ..
            " but " .. tostring(infoInClass.isVarArg) .. " was provided."
    elseif infoInClass.paramsCount ~= infoInInterface.paramsCount then
        reason = "Incorrect number of arguments. " ..
            "Expected " .. infoInInterface.paramsCount .. " arguments," ..
            "but " .. infoInClass.paramsCount .. " was provided."
    end

    if reason == "" then
        return reason
    end

    return
        "Function '" .. functionName .. "' is not implemented. " .. reason .. "\n"
end

local function CantImplementInterfaceReason(class, interface)
    if not Is(class) then
        return "not a class"
    end

    if not Interface.is(interface) then
        return "not a interface"
    end

    local infoListInInterface = GetFunctionInfoTable(interface)
    local infoListInClass = GetFunctionInfoTable(class)
    local interfaceReason = "Can't implement interface " .. interface._name .. ".\n"
    local functionReason = ""
    for name, infoInInterface in pairs(infoListInInterface) do
        local infoInClass = infoListInClass[name]
        local reason = CantImplementFunctionReason(name, infoInClass, infoInInterface)
        if reason ~= "" then
            functionReason = functionReason .. reason
        end
    end

    if functionReason == "" then
        return ""
    end

    return interfaceReason .. functionReason
end

local function GetAllInterfaces(interfaces)
    local all = {}
    local currentAll = {}
    for i = 1, #interfaces do
        table.insert(currentAll, interfaces[i])
    end

    repeat
        local interface = currentAll[1]
        for i = 1, #interface._interfaces do
            table.insert(currentAll, interface._interfaces[i])
        end
        table.insert(all, interface)
        table.remove(currentAll, 1)
    until #currentAll == 0

    return all
end

local function CantImplementInterfaceReasons(class, interfaces)
    local allInterfaces = GetAllInterfaces(interfaces)
    local reasons = ""
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        reasons = reasons .. CantImplementInterfaceReason(class, interface)
    end
    return reasons
end

local function CanImplements(class, interfaces)
    local allInterfaces = GetAllInterfaces(interfaces)
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        if not CanImplement(class, interface) then
            return false
        end
    end

    return true
end

function Class.implements(class, interfaces)
    if not CanImplements(class, interfaces) then
        error(CantImplementInterfaceReasons(class, interfaces))
        return
    end

    class._interfaces = interfaces
end

return Class
