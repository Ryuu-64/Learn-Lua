local Type = require "oop.constant.Type"

---
--- @class DummyClass The root node of the inheritance chain, solely providing a user-visible base class for the Object class, with no other purpose.
local DummyClass = {
    _name = "DummyClass",
    _type = Type.CLASS,
    _interfaces = {}
}

return DummyClass
