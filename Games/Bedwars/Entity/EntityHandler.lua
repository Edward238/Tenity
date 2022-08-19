local Entity = {
    EntityList = {};
    EntityConnections = {};
    EntityAlive = false;
    EntityCharacter = {
      EntityHead = {};
      EntityHumanoid = {};
      EntityHumanoidRootPart = {};
    };
}
local Players = game:GetService('Players')
local LPlayer = Players.LocalPlayer
local EntityAdded = Instance.new('BindableEvent')
local EntityRemoved = Instance.new('BindableEvent')
local EntityUpdated = Instance.new('BindableEvent')

do
    Entity.EntityAddedEvent = {
        Connect = function(Self, Function)
            return EntityAdded.Event:Connect(Function) 
        end;
        connect = function(Self, Function)
            return EntityAdded.Event:Connect(Function) 
        end;
        Fire = function(Self, ...)
            EntityAdded:Fire(...)
        end;
    } 
    Entity.EntityRemovedEvent = {
        Connect = function(Self, Function)
            return EntityRemoved.Event:Connect(Function) 
        end;
        connect = function(Self, Function)
            return EntityRemoved.Event:Connect(Function) 
        end;
        Fire = function(Self, ...)
            EntityRemoved:Fire(...)
        end;
    }
    Entity.EntityUpdatedEvent = {
        Connect = function(Self, Function)
            return EntityUpdated.Event:Connect(Function) 
        end;
        connect = function(Self, Function)
            return EntityUpdated.Event:Connect(Function) 
        end;
        Fire = function(Self, ...)
            EntityUpdated:Fire(...)
        end;
    }
    Entity.Targetable = function(Player)
        if (not LPlayer.Team) then return true end
        if Player.Team ~= LPlayer.Team then return end
        return Player.Team and #Player.Team:GetPlayers() == #Players:GetPlayers()
    end
    Entity.GetEntityFromPlayer = function(Character)
        for i,v in next, Entity.EntityList do
            if v.Player == Character then
                return i, v
            end
        end
    end
    Entity.RemoveEntity = function(obj)
        local Index, Ent = Entity.GetEntityFromPlayer(obj)
        if Index then
            Entity.EntityRemovedEvent:Fire(obj)
            for i,v in next, (Ent.Connections or {}) do
                if v.Disconnect then
                    v:Disconnect()
                end
            end
            table.remove(Entity.EntityList, Index)
        end
    end
    Entity.RefreshEntity = function(Player, Check)
        Entity.RemoveEntity(Player)
        Entity.CharacterAdded(Player, Player.Character, Check, true)
    end
    Entity.CharacterAdded = function(Player, Character, Check, Refresh)
        if Character then
            task.spawn(function()
                local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart', 10)
                local Head = Character:WaitForChild('Head', 10) or HumanoidRootPart and {Position = HumanoidRootPart.Position + Vector3.new(0, 3, 0), Name = 'Head', Size = Vector3.new(1, 1, 1), CFrame = HumanoidRootPart.CFrame + Vector3.new(0, 3, 0), Parent = Character}
                local Humanoid = Character:WaitForChild('Humanoid', 10) or Character:FindFirstChildWhichIsA('Humanoid')
                if HumanoidRootPart and Humanoid and Head then
                    if Check then
                        Entity.EntityAlive = true
                        Entity.Character.Head = Head
                        Entity.Character.Humanoid = Humanoid
                        Entity.Character.HumanoidRootPart = HumanoidRootPart
                    else
                        local NewEnt = {
                            Player = Player;
                            Character = Character;
                            HumanoidRootPart = HumanoidRootPart;
                            RootPart = HumanoidRootPart;
                            Head = Head;
                            Humanoid = Humanoid;
                            Targetable = Entity.Targetable(Player);
                            Team = Player.Team;
                            Connections = {};
                        }
                        table.insert(NewEnt.Connections, Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
                            Entity.EntityUpdatedEvent:Fire(NewEnt)
                        end))
                        table.insert(NewEnt.Connections, Humanoid:GetPropertyChangedSignal('MaxHealth'):Connect(function()
                            Entity.EntityUpdatedEvent:Fire(NewEnt)
                        end))
                        table.insert(Entity.EntityList, NewEnt)
                        Entity.EntityAddedEvent:Fire(NewEnt)
                    end
                    table.insert(Entity.EntityConnections, Character.ChildRemoved:Connect(function(Part)
                        if Part.Name == 'HumanoidRootPart' or Part.name == 'Head' or Part.Name == 'Humanoid' then
                            if Check then
                                Entity.EntityAlive = false
                            else
                                Entity.RemoveEntity(Player)
                            end
                        end
                    end))
                end
            end) 
        end
    end
    Entity.EntityAdded = function(Player, Check, Custom)
        table.insert(Entity.EntityConnections, Player.CharacterAdded:Connect(function(Character)
            Entity.RefreshEntity(Player, Check) 
        end)) 
        table.insert(Entity.EntityConnections, Player.CharacterRemoving:Connect(function(Character)
            if Check then
                Entity.EntityAlive = false
            else
                Entity.RemoveEntity(Player)
            end
        end))
        table.insert(Entity.EntityConnections, Player:GetPropertyChangedSignal('Team'):Connect(function()
            for i,v in next, Entity.EntityList do
                local Target = Entity.Targetable(v.Player)
                if v.Targetable ~= Target then
                    Entity.RefreshEntity(Player, Check) 
                end
            end
            if Check then
                Entity.FullEntityRefresh()
            else
                Entity.RefreshEntity(Player, Check)
            end
        end))
        task.spawn(function()
            if not Player.Character then
                for i = 1,10 do
                    task.wait(0.1)
                    if Player.Character then break end
                end
            end
            if Player.Character then
                Entity.RefreshEntity(Player, Check) 
            end
        end)
    end
    Entity.FullEntityRefresh = function()
        Entity.SelfDestruct()
        for i,v in pairs(Players:GetPlayers()) do
            Entity.EntityAdded(v, v == LPlayer) 
        end
        table.insert(Entity.EntityConnections, Players.PlayerAdded:Connect(function(v)
            Entity.EntityAdded(v, v == LPlayer) 
        end))
        table.insert(Entity.EntityConnections, Players.PlayerRemoving:Connect(function(v)
            Entity.RemoveEntity(v) 
        end))
    end
    Entity.SelfDestruct = function()
        for i,v in pairs(Entity.EntityConnections) do
            if v.Disconnect then
                v:Disconnect() 
            end
        end
        for i,v in pairs(Entity.EntityList) do
            Entity.RemoveEntity(v.Player)
        end
    end
end

return Entity
