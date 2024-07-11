local Object = require "oop.Object"
local Runtime = require "oop.Runtime"

---
--- @class List:Object Represents a list of objects that can be accessed by index. Provides methods to search, sort, and manipulate lists.
local List = Runtime.inherit(Object, "List")

function List:new()
    local instance = Object.new(self)
    instance.items = {}
    return instance
end

---
--- Adds an object to the end of the List
function List:Add(item)
    table.insert(self.items, item)
end

---
--- Add all objects to the end of the List
--- @param list List
function List:AddAll(list)
    for i = 1, list.items do
        table.insert(self.items, list.items[i])
    end
end

---
--- Removes all elements from the List
function List:Clear()
    self.items = {}
end

---
--- Gets the element at the specified index.
function List:Get(index)
    return self.items[index]
end

---
--- Determines whether an element is in the List
function List:Contains(item)
    for _, currItem in ipairs(self.items) do
        if currItem == item then
            return true
        end
    end
    return false
end

---
--- The zero-based index of the first occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
--- @return boolean Returns the zero-based index of the first occurrence of a value in the List
function List:FirstIndexOf(item)
    for i, v in ipairs(self.items) do
        if v == item then
            return i
        end
    end
    return -1
end

---
--- The zero-based index of the last occurrence of an element that matches the conditions defined by match, if found; otherwise, -1.
--- @return boolean Returns the zero-based index of the last occurrence of a value in the List
function List:LastIndexOf(item)
    for i = #self.items, 1, -1 do
        if self.items[i] == item then
            return i
        end
    end
    return -1
end

---
--- Sorts the elements in the List using the specified provided comparator function to compare list elements.
--- @param comparator fun(a:any,b:any) The comparator to use when comparing elements.
function List:Sort(comparator)
    if comparator then
        table.sort(self.items, comparator)
    else
        table.sort(self.items)
    end
end

---
--- Removes the first occurrence of a specific object from the List
--- @param item any The item to remove from the List
--- @return boolean true if item is successfully removed; otherwise, false. This method also returns false if item was not found in the List
function List:RemoveFirst(item)
    local index = self:FirstIndexOf(item)
    if index ~= -1 then
        table.remove(self.items, index)
        return true
    end

    return false
end

---
--- Removes the last occurrence of a specific object from the List
--- @param item any The item to remove from the List
--- @return boolean true if item is successfully removed; otherwise, false. This method also returns false if item was not found in the List
function List:RemoveLast(item)
    local index = self:LastIndexOf(item)
    if index ~= -1 then
        table.remove(self.items, index)
        return true
    end

    return false
end

---
--- Removes the element at the specified index of the List
function List:RemoveAt(index)
    table.remove(self.items, index)
end

---
--- Removes all the elements that match the conditions defined by the specified predicate.
---@param predicate fun(item:any):boolean function that defines the conditions of the elements to remove.
function List:RemoveAll(predicate)
    local removeCount = 0
    local i = 1
    while i <= #self.items do
        if predicate(self.items[i]) then
            table.remove(self.items, i)
            removeCount = removeCount + 1
        else
            i = i + 1
        end
    end

    return removeCount
end

---
--- Reverses the order of the items in the List
function List:Reverse()
    local left = 1
    local right = #self.items

    while left < right do
        self.items[left], self.items[right] = self.items[right], self.items[left]
        left = left + 1
        right = right - 1
    end
end

---
--- Gets the number of elements contained in the List
function List:Count()
    return #self.items
end

return List
