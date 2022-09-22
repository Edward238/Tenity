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

web.OnMessage:Connect(function(msg)
    print(msg) 
end)

local function sendrequest(tab)
    local newstr = game:GetService('HttpService'):JSONEncode(tab)
    if suc then
        web:Send(newstr)
    end
end

sendrequest({
    msg = "Inject"
})
