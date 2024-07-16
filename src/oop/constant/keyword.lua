---@class keyword
---@field interface string reference type keyword
---@field class string reference type keyword
---@field this string access keyword
local keyword = {}

--region reference type keyword
keyword.interface = "interface"
keyword.class = "class"
--endregion

--region access keyword
keyword.this = "this"
--endregion

--region operator keyword
keyword.is = "is"
--endregion

return keyword
