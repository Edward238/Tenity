local websocketfunc = syn and syn.websocket and syn.websocket.connect or Krnl and Krnl.WebSocket.connect or WebSocket and WebSocket.connect or websocket and websocket.connect
local suc, web = pcall(function() return websocketfunc("ws://127.0.0.1:6892/") end)
if syn and syn.toast_notification then 
    suc, web = pcall(function() 
        local socket = WebsocketClient.new("ws://127.0.0.1:6892/")
        socket:Connect()
        return socket 
    end)
end
repeat 
    task.wait(1)
    if not suc or suc and type(web) == "boolean" then
        suc, web = pcall(function() return websocketfunc("ws://127.0.0.1:6892/") end)
        if not suc or suc and type(web) == "boolean" then
            print("websocket error:", web)
        end
    end
until suc and type(web) ~= "boolean"

local FeatherApi = {
    Modules = {},
    ModuleFunctions = {}
}

local function ModuleInitiate(name, description, func)
    local tab = {
        Title = name,
        Description = description
    }
    table.insert(FeatherApi['Modules'], tab)
    FeatherApi['ModuleFunctions'][name] = func
end

local function sendrequest(tab)
    local newstr = game:GetService('HttpService'):JSONEncode(tab)
    if suc then
        web:Send(newstr)
    end
end

web.OnMessage:Connect(function(msg)
    msg = game:GetService('HttpService'):JSONDecode(msg)
    if (msg['Type'] == 'Message') then
        print(msg['Content'])
    elseif (msg['Type'] == 'Button') then
        if (FeatherApi['ModuleFunctions']:FindFirstChild(msg['Content'])) then
            FeatherApi['ModuleFunctions']:FindFirstChild(msg['Content'])()
        end
    end
end)

ModuleInitiate('reset', 'resets character', function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0 
end)

ModuleInitiate('kill', 'kill player', function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0 
end)

sendrequest({
    Type = 'ConnectionRequest',
    Modules = FeatherApi['Modules']
})
