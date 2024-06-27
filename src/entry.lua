-- 动物基类
local Animal = {}
Animal.__index = Animal

function Animal:new(name)
    local instance = setmetatable({}, self)
    instance.name = name
    return instance
end

function Animal:speak()
    return "...! My name is " .. self.name
end

-- 狗类
local Dog = setmetatable({}, Animal)
Dog.__index = Dog

function Dog:new(name)
    local instance = Animal.new(self, name)
    return instance
end

function Dog:speak()
    return "Woof! My name is " .. self.name
end

-- 猫类
local Cat = setmetatable({}, Animal)
Cat.__index = Cat

function Cat:new(name)
    local instance = Animal.new(self, name)
    return instance
end

function Cat:speak()
    return "Meow! My name is " .. self.name
end

-- 测试多态
local animals = {
    Dog:new("Buddy"),
    Cat:new("Whiskers"),
    Animal:new("Some Animal")
}

for _, animal in ipairs(animals) do
    print(animal:speak())
end
