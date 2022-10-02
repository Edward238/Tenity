local websocketfunc = syn and syn.websocket and syn.websocket.connect or Krnl and Krnl.WebSocket.connect or WebSocket and WebSocket.connect or websocket and websocket.connect ; local suc, web = pcall(function() return websocketfunc("ws://127.0.0.1:6892/") end)

if syn and syn.toast_notification then suc, web = pcall(function() 
    local socket = WebsocketClient.new("ws://127.0.0.1:6892/") ; socket:Connect()
    return socket 
end) end

repeat task.wait(1) if not suc or suc and type(web) == "boolean" then
    suc, web = pcall(function() return websocketfunc("ws://127.0.0.1:6892/") end)
    if not suc or suc and type(web) == "boolean" then print("websocket error:", web) end
end until suc and type(web) ~= "boolean"

local Entity = {}
local Players = game:GetService('Players')
local LPlayer = Players.LocalPlayer

Entity.FindPlayer = function(Name)
	for _,Player in ipairs(Players:GetPlayers()) do
		if string.lower(Player.Name):match(string.lower(Name)) or string.lower(Player.DisplayName):match(string.lower(Name)) then
			return Player
		end
	end
end

Entity.Targetable = function(Player)
	if Players[Player.Name] then
		if Players[Player.Name].Team ~= LPlayer.Team then
			return true
		else return false end
	end
end

Entity.Alive = function(Player)
	if Players[Player.Name] then
		if Players[Player.Name].Character and Players[Player.Name].Character.Parent ~= nil and Players[Player.Name].Character:FindFirstChildWhichIsA('Humanoid') and Players[Player.Name].Character:FindFirstChildWhichIsA('Humanoid').Health > 0 then
			return true
		else return false end
	end
end

Entity.Reset = function()
    if Entity.Alive(LPlayer) then
        LPlayer.Character:FindFirstChildWhichIsA('Humanoid').Health = 0 ; LPlayer.Character:ClearAllChildren()
    end
end

FeatherApi = { Version = '0.1.3 lisa rinna' } States = {} FeatherModules = {} FeatherModuleFunctions = {}

local function ModuleInitiate(typee, name, desc, func)
    local tab = {
        ModuleType = typee,
        Title = name,
        Description = desc
    }
    table.insert(FeatherModules, tab) ; FeatherModuleFunctions[name] = func
end

local function sendrequest(tab)
    local newstr = game:GetService('HttpService'):JSONEncode(tab) ; if suc then
        web:Send(newstr)
    end
end

web.OnMessage:Connect(function(msg) msg = game:GetService('HttpService'):JSONDecode(msg)
    if (msg['Type'] == 'Message') then print(msg['Content']) elseif (msg['Type'] == 'Button') then
        if (FeatherModuleFunctions[msg['Content']] ~= nil) then
            pcall(FeatherModuleFunctions[msg['Content']])
        end
    elseif (msg['Type'] == 'Toggle') then
        if (FeatherModuleFunctions[msg['Content']] ~= nil) then
            FeatherModuleFunctions[msg['Content']](msg['State'] or false)
        end
    end
end)

function prfshjdak()
    while States.printt == true do
        print('hi')
        task.wait()
    end
end

ModuleInitiate('Button', 'Version', 'version of script', function()
    if FeatherApi['Version'] then
        print(FeatherApi['Version'])
    else print('unable to get version') end
end)

ModuleInitiate('Button', 'Respawn', 'respawns local character', function()
    if Entity.Alive(LPlayer) then local OldCFrame = LPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame Entity.Reset()
        task.spawn(function()
            LPlayer.CharacterAdded:Wait():WaitForChild('HumanoidRootPart').CFrame = OldCFrame
        end)
    end
end)

ModuleInitiate('Toggle', 'print hi', 'prints hi in console', function(state)
    States.printt = state
    if States.printt and state then
        prfshjdak()
    end
end)

sendrequest({ Type = 'ConnectionRequest', Modules = FeatherModules })
