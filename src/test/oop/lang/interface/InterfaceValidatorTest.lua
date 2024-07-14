local keyword = require "oop.constant.keyword"
local InterfaceValidator = require "oop.lang.interface.InterfaceValidator"
local Debugger = require "debug.emmy.Debugger"

Debugger.Connect()

local function EmptyTableInvalid()
    if InterfaceValidator.is({}) then
        error()
    end
end

local function EmptyInterfacesValid()
    if not InterfaceValidator.is({
            _name = "test",
            _type = keyword.interface,
            _interfaces = {}
        })
    then
        error()
    end
end

local function TypeKeywordInvalid()
    local interface = {
        _name = "test",
        _type = keyword.class,
        _interfaces = {}
    }

    if InterfaceValidator.is(interface)
    then
        error()
    end

    local exception = InterfaceValidator.reason(interface)
    print(tostring(exception))
end

local function InterfacesInvalid()
    local interface = {
        _name = "InterfaceInnerTest",
        _type = keyword.interface,
        _interfaces = {
            {
                _name = "InterfaceInnerTestInner",
                _type = keyword.interface
            }
        }
    }
    if InterfaceValidator.is(interface)
    then
        error()
    end
end

EmptyTableInvalid()
EmptyInterfacesValid()
TypeKeywordInvalid()
InterfacesInvalid()
