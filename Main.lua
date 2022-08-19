--[[

Credits:
Teddy#1431 - Ui - Scripts
engo#0320 - Base bedwars script

]]

if not game:IsLoaded() then game.Loaded:Wait() end

local sTick = tick()

local request = (syn and syn.request) or request or http_request or (http and http.request)
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local setthreadidentityfunc = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity
local getthreadidentityfunc = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity
local UserInput = game:GetService('UserInputService')
local TweenSrv = game:GetService('TweenService')
local Players = game:GetService('Players')
local LPlayer = Players.LocalPlayer
local Entity,TenityLibrary = nil,loadstring(game:HttpGet('https://raw.githubusercontent.com/Edward238/Tenity/main/GuiLibrary1.lua'))()

local Runners = {Stepped = {}, RenderStepped = {}, Heartbeat = {}}
local Functions = {}; do
    
    function Functions:RunLoadString(Code)
        local Function, Error = loadstring(Code)
        if not typeof(Function) == 'function' then
            return warn('[Tenity][Warning]: Failed to run code, error:'..tostring(Error)) 
        end
        return Function()
    end
    
    function Functions:BindToStepped(ModuleId, Callback)
        if not Runners.Stepped[ModuleId] then
            Runners.Stepped[ModuleId] = game:GetService('RunService').Stepped:Connect(Callback) 
        else
            warn('[Tenity][Warning]: Attempted to BindToStepped to an already in use moduleid: '..tostring(ModuleId))
        end
    end
    
    function Functions:UnBindFromStepped(ModuleId)
        if Runners.Stepped[ModuleId] then
            Runners.Stepped[ModuleId]:Disconnect()
            Runners.Stepped[ModuleId] = nil
        end
    end
    
    function Functions:BindToRenderStepped(ModuleId, Callback)
        if not Runners.RenderStepped[ModuleId] then
            Runners.RenderStepped[ModuleId] = game:GetService('RunService').Stepped:Connect(Callback) 
        else
            warn('[Tenity][Warning]: Attempted to BindToRenderStepped to an already in use moduleid: '..tostring(ModuleId))
        end
    end
    
    function Functions:UnBindFromRenderStepped(ModuleId)
        if Runners.RenderStepped[ModuleId] then
            Runners.RenderStepped[ModuleId]:Disconnect()
            Runners.RenderStepped[ModuleId] = nil
        end
    end
    
    function Functions:BindToHeartbeat(ModuleId, Callback)
        if not Runners.Heartbeat[ModuleId] then
            Runners.Heartbeat[ModuleId] = game:GetService('RunService').Stepped:Connect(Callback) 
        else
            warn('[Tenity][Warning]: Attempted to BindToHeartbeat to an already in use moduleid: '..tostring(ModuleId))
        end
    end
    
    function Functions:UnBindFromHeartbeat(ModuleId)
        if Runners.Heartbeat[ModuleId] then
            Runners.Heartbeat[ModuleId]:Disconnect()
            Runners.Heartbeat[ModuleId] = nil
        end
    end
    
    function Functions:EntityAlive(Entity, StateCheck)
        if not Entity then
            return Entity.EntityAlive
        end
        
        local _, Ent = Entity.GetEntityFromPlayer(Entity)
        return ((not StateCheck) or Ent and Ent.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead) and Ent
    end
    
    function Functions:EntityTargetable(Player)
        return Functions:EntityAlive(Player, true) and (Player.Character) and (not Player.Character:FindFirstChildOfClass('ForceField')) 
    end

end

if not getgenv or (identifyexecutor and identifyexecutor():find("Arceus")) then
    return warn("[Tenity][Error]: Unsupported executor")
end

if Tenity then
    warn('[Tenity][Warning]: Already loaded')
    return
end

Entity = loadstring(game:HttpGet('https://raw.githubusercontent.com/Edward238/Tenity/main/Games/Bedwars/Entity/EntityHandler1.lua'))()
Entity.FullEntityRefresh()
TenityWindow = TenityLibrary.CreateWindow(Enum.KeyCode.RightShift)

getgenv().Tenity = {}
Tenity.UninjectEvent = Instance.new('BindableEvent')
Tenity.Entity = Entity
Tenity.GuiLibrary = TenityLibrary
Tenity.Functions = Functions
makefolder('Tenity')
makefolder('Tenity/Configs')

local TabColors = {
    Combat = Color3.fromRGB(255, 39, 39);
    Other = Color3.fromRGB(156, 156, 156);
}

local ClickGuiTabs = {
    Combat = TenityWindow.CreateTab('Combat', 7072724538, TabColors.Combat);
    Other = TenityWindow.CreateTab('Other', 7072719490, TabColors.Other);
}

local UninjectButton = ClickGuiTabs.Other.CreateButton(
    'Uninject',
    'Uninjects the client',
    TabColors.Other,
    function()
        Tenity.UninjectEvent:Fire()
    end
)
