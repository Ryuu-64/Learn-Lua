--local Bag = {}
--
--local metatable = {
--    __index = {
--        put = function(bag, item)
--            table.insert(bag.items, item)
--        end,
--        list = function(bag)
--            return table.concat(bag.items)
--        end
--    }
--}
--
--function Bag:new()
--    local bag = {
--        items = {  },
--        print1 = function(bag)
--            print(table.concat(bag.items))
--        end,
--    }
--    setmetatable(bag, metatable)
--
--    return bag;
--end

local Bag = {}
Bag.__index = Bag

-- 创建新 Bag 对象
function Bag:new()
    local instance = {
        items = {}
    }
    setmetatable(instance, Bag)
    return instance
end

-- 添加项目
function Bag:put(item)
    table.insert(self.items, item)
end

-- 返回项目的连接字符串
function Bag:list()
    return table.concat(self.items, "")
end

-- 打印项目
function Bag:print1()
    print(table.concat(self.items, ""))
end