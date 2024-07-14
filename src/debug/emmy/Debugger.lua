local Debugger = {}

function Debugger.Connect()
    package.cpath = package.cpath .. ';C:/Users/Ryuu/AppData/Roaming/JetBrains/Rider2023.3/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
    local dbg = require('emmy_core')
    dbg.tcpListen('localhost', 9966)
end

return Debugger
