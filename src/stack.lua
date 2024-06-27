local Object = require("object")

local Stack = Object:new()

function Stack:new()
    local instance = Object.new(self)
    instance._type = "Stack"
    instance.stack = {}
    return instance
end

function Stack:push(item)
    table.insert(self.stack, item)
end

function Stack:pop()
    return table.remove(self.stack)
end

function Stack:peek()
    return self.stack[#self.stack]
end

function Stack:isEmpty()
    return #self.stack == 0
end

function Stack:size()
    return #self.stack
end

return Stack;