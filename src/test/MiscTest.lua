local Object = require("oop.object")

local function new(isSealedClass)
    if isSealedClass then
        return function(self)
            local instance = Object.new(self)
            return instance
        end
    end
end
