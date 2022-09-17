local Step = {}

local Connections = {
    Stepped = {},
    RenderStepped = {},
    Heartbeat = {}
}

function Step:BindToStepped(ConnectionId, Callback)
    if not Connections.Stepped[ConnectionId] then
        Connections.Stepped[ConnectionId] = game:GetService('RunService').Stepped:Connect(Callback)
    else
        print('[TenityAPI]: Attempted to bind to an already bound connection\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindFromStepped(ConnectionId)
    if Connections.Stepped[ConnectionId] then
        Connections.Stepped[ConnectionId]:Disconnect()
        Connections.Stepped[ConnectionId] = nil
    else
        print('[TenityAPI]: Attempted to stop a connection that doesnt exist\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:BindToRenderStepped(ConnectionId, Callback)
    if not Connections.RenderStepped[ConnectionId] then
        Connections.RenderStepped[ConnectionId] = game:GetService('RunService').RenderStepped:Connect(Callback)
    else
        print('[TenityAPI]: Attempted to bind to an already bound connection\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindFromRenderStepped(ConnectionId)
    if Connections.RenderStepped[ConnectionId] then
        Connections.RenderStepped[ConnectionId]:Disconnect()
        Connections.RenderStepped[ConnectionId] = nil
    else
        print('[TenityAPI]: Attempted to stop a connection that doesnt exist\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:BindToHeartbeat(ConnectionId, Callback)
    if not Connections.Heartbeat[ConnectionId] then
        Connections.Heartbeat[ConnectionId] = game:GetService('RunService').Heartbeat:Connect(Callback)
    else
        print('[TenityAPI]: Attempted to bind to an already bound connection\n[Connection]: '..ConnectionName..'\n')
    end
end

function Step:UnbindFromHeartbeat(ConnectionId)
    if Connections.Heartbeat[ConnectionId] then
        Connections.Heartbeat[ConnectionId]:Disconnect()
        Connections.Heartbeat[ConnectionId] = nil
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
