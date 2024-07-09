local Debugger = {}

function Debugger.Connect()
    package.cpath = package.cpath ..
        ';C:/Users/xinle/AppData/Roaming/JetBrains/Rider2024.1/plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
    local dbg = require('emmy_core')
    local status, _ = pcall(dbg.tcpConnect, 'localhost', 9966)
    if status then
        return
    end

    print("Warning: tcp connect failed")
end

return Debugger
