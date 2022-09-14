local Step = {}

local Connections = {
    Stepped = {},
    RenderStepped = {},
    Heartbeat = {}
}

function Step:BindToStepped(ConnectionName, Callback)
    if not Connections.Stepped[ConnectionName] then
        Connections.Stepped[ConnectionName] = game:GetService('RunService').Stepped:Connect(function()
            pcall(Callback)
        end)
    else
        print('[TenityAPI]: Attempted to bind to an already bound connection\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindFromStepped(ConnectionName)
    if Connections.Stepped[ConnectionName] then
        Connections.Stepped[ConnectionName]:Disconnect()
        Connections.Stepped[ConnectionName] = nil
    else
        print('[TenityAPI]: Attempted to stop a connection that doesnt exist\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:BindToRenderStepped(ConnectionName, Callback)
    if not Connections.RenderStepped[ConnectionName] then
        Connections.RenderStepped[ConnectionName] = game:GetService('RunService').RenderStepped:Connect(function()
            pcall(Callback)
        end)
    else
        print('[TenityAPI]: Attempted to bind to an already bound connection\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindFromRenderStepped(ConnectionName)
    if Connections.RenderStepped[ConnectionName] then
        Connections.RenderStepped[ConnectionName]:Disconnect()
        Connections.RenderStepped[ConnectionName] = nil
    else
        print('[TenityAPI]: Attempted to stop a connection that doesnt exist\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:BindToHeartbeat(ConnectionName, Callback)
    if not Connections.Heartbeat[ConnectionName] then
        Connections.Heartbeat[ConnectionName] = game:GetService('RunService').Heartbeat:Connect(function()
            pcall(Callback)
        end)
    else
        print('[TenityAPI]: Attempted to bind to an already bound connection\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindFromHeartbeat(ConnectionName)
    if Connections.Heartbeat[ConnectionName] then
        Connections.Heartbeat[ConnectionName]:Disconnect()
        Connections.Heartbeat[ConnectionName] = nil
    else
        print('[TenityAPI]: Attempted to stop a connection that doesnt exist\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindAll()
    if #Connections.Stepped > 0 then
        for i = 1,#Connections.Stepped,1 do
            local SteppedConnection = Connections.Stepped[i]
            if SteppedConnection then
                SteppedConnection:Disconnect()
                SteppedConnection = nil
            end
        end
    end
    if #Connections.RenderStepped > 0 then
        for i = 1,#Connections.RenderStepped,1 do
            local RenderSteppedConnection = Connections.RenderStepped[i]
            if RenderSteppedConnection then
                RenderSteppedConnection:Disconnect()
                RenderSteppedConnection = nil
            end
        end
    end
    if #Connections.Heartbeat > 0 then
        for i = 1,#Connections.Heartbeat,1 do
            local HeartbeatConnection = Connections.Heartbeat[i]
            if HeartbeatConnection then
                HeartbeatConnection:Disconnect()
                HeartbeatConnection = nil
            end
        end
    end
end

return Step
