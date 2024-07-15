local InterfaceValidator = require "oop.lang.interface.InterfaceValidator"
local ClassValidator = require "oop.lang.class.ClassValidator"

---@class ClassImplements
local ClassImplements = {}

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

local function ValidateInterface(class, interface)
    if not ClassValidator.Is(class) then
        return false
    end

    if not InterfaceValidator.is(interface) then
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

local function FunctionInvalidReason(functionName, infoInClass, infoInInterface)
    local reason = ""
    if infoInClass == nil then
        reason = string.rep(" ", 4) .. "No such function.\n"
    else
        if infoInClass.isVarArg ~= infoInInterface.isVarArg then
            reason = reason .. string.rep(" ", 4) .. "Incorrect 'Variable Number of Arguments'. " ..
                "Expected " .. tostring(infoInInterface.isVarArg) .. "," ..
                " but " .. tostring(infoInClass.isVarArg) .. " was provided.\n"
        end
        if infoInClass.paramsCount ~= infoInInterface.paramsCount then
            reason = reason .. string.rep(" ", 4) .. "Incorrect number of arguments. " ..
                "Expected " .. infoInInterface.paramsCount .. " arguments," ..
                "but " .. infoInClass.paramsCount .. " was provided.\n"
        end
    end

    if reason == "" then
        return reason
    end

    return
        string.rep(" ", 2) .. "Function '" .. functionName .. "' is not implemented:\n" ..
        reason .. "\n"
end

local function InterfaceInvalidReason(class, interface)
    if not ClassValidator.Is(class) then
        return "not a class"
    end

    if not InterfaceValidator.is(interface) then
        return "not a interface"
    end

    local infoListInInterface = GetFunctionInfoTable(interface)
    local infoListInClass = GetFunctionInfoTable(class)
    local interfaceReason = "Can't implement interface '" .. interface._name .. "':\n"
    local functionReason = ""
    for name, infoInInterface in pairs(infoListInInterface) do
        local infoInClass = infoListInClass[name]
        local reason = FunctionInvalidReason(name, infoInClass, infoInInterface)
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
    local cur = {}
    for i = 1, #interfaces do
        table.insert(cur, interfaces[i])
    end

    repeat
        local interface = cur[1]
        for i = 1, #interface._interfaces do
            table.insert(cur, interface._interfaces[i])
        end
        table.insert(all, interface)
        table.remove(cur, 1)
    until #cur == 0

    return all
end

-- TODO exception
local function Validate(class, interfaces)
    local allInterfaces = GetAllInterfaces(interfaces)
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        if not ValidateInterface(class, interface) then
            return false
        end
    end

    return true
end

-- TODO exception
local function InvalidReason(class, interfaces)
    local allInterfaces = GetAllInterfaces(interfaces)
    local reasons = ""
    for i = 1, #allInterfaces do
        local interface = allInterfaces[i]
        reasons = reasons .. InterfaceInvalidReason(class, interface)
    end

    local interfaceNames = {}
    for i = 1, #interfaces do
        table.insert(interfaceNames, "'" .. interfaces[i]._name .. "'")
    end
    return "Error implementing interfaces " ..
        table.concat(interfaceNames, ", ") .. " for '" .. class._name .. "':\n" ..
        reasons
end

-- TODO exception see InterfaceImplements.implements(interface, interfaces)
function ClassImplements.implements(class, interfaces)
    if not Validate(class, interfaces) then
        error(tostring(InvalidReason(class, interfaces)))
    end

    class._interfaces = interfaces
end

return ClassImplements
