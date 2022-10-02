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
        print('big boy chungas')
        task.wait()
    end
end

ModuleInitiate('Button', 'Version', 'version of script', function()
    if FeatherApi['Version'] then
        print(FeatherApi['Version'])
    else print('unable to get version') end
end)

ModuleInitiate('Button', 'Auto Kill (Assassin)', 'auto kills for you', function()
    if Entity.Alive(LPlayer) then local OldCFrame = LPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame Entity.Reset()
        game:GetService("AdService"):ClearAllChildren()
	wait(1)

	    local Player = game.Players.LocalPlayer
	    local wS = game.Workspace
	    local cam = wS.CurrentCamera
	    local mouse = Player:GetMouse()
	    local ClosestPlr = function()
		local Closest = nil
		local Distance = 9e9;
		for i,v in pairs(game.Players:GetPlayers()) do
		    if v ~= Player then
			if wS[v.Name]:FindFirstChild("Humanoid") and wS[v.Name].Humanoid.Health ~= 0 then
			    local pos = cam:WorldToViewportPoint(wS[v.Name].HumanoidRootPart.Position)
			    local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude;
			    if magnitude < Distance then
				Closest = wS[v.Name]
				Distance = magnitude
			    end
			end
		    end
		end
		return Closest
	    end

	    game:GetService('RunService').RenderStepped:connect(function()
		for i,v in pairs(game.Workspace.KnifeHost:GetDescendants()) do
		    if v:IsA"Part" then
			if v.Archivable == true then
			    local plrpos  = ClosestPlr().baseHitbox.CFrame
			    v.CFrame = plrpos
			end
		    end
		end
	    end)
	    task.spawn(function()
	    game:GetService("RunService").Stepped:Connect(function()
		local function randompart()
		    local hits = {
			0,
			1,
			2,
			-1,
			-2,
		    }
		    return hits[math.random(1, #hits)]
		end
			if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") then
			    for i, v in pairs(game.Players:GetPlayers()) do
				if v.Name == game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text then
				    if v.Name ~= game.Players.LocalPlayer.Name then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(Game.Players.LocalPlayer.Backpack.Knife)
					wait(.3)
					local Target = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text
					local x = game.Workspace[Target].HumanoidRootPart.Position.X + randompart()
					local y = game.Workspace[Target].HumanoidRootPart.Position.Y + randompart()
					local z = game.Workspace[Target].HumanoidRootPart.Position.Z + randompart()
					local args = {
					    [1] = Vector3.new(x, y, z),
					    [2] = 0,
					    [3] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
					}
					game:GetService("ReplicatedStorage").Remotes.ThrowKnife:FireServer(unpack(args))
					wait(.1)
					game:GetService("Players").localPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools()
					wait(.6)
				    end
				end
			    end
			end
	    end)
	end)
	local ClosestPlayer = function()
	    local Closest = nil
	    local Distance = 9e9
	    for i, v in next, game:GetService("Players"):GetPlayers() do
		if v.Name ~= Player.Name then
		    if wS[v.Name] and wS[v.Name]:FindFirstChild("Humanoid") and wS[v.Name]:FindFirstChild("Humanoid").Health ~= 0 then
			local Magnitude = (Player.Character.Head.Position - wS[v.Name].Head.Position).Magnitude
			if Magnitude < Distance then
			    Closest = wS[v.Name]
			    Distance = Magnitude
			    end
			end
		    end
		end
	    return Closest
	end
	local cooldown = false

	task.spawn(function()
	    game:GetService("RunService").Heartbeat:connect(function()
		if Player.Character and not cooldown then
		    if Player:DistanceFromCharacter(ClosestPlayer().Head.Position) <= 7.5 then
			Player.PlayerScripts.localknifehandler.HitCheck:Fire(ClosestPlayer())
			coroutine.wrap(function()
			    cooldown = true
			    task.wait(1.7)
			    cooldown = false
			end)()
		    else
			task.wait()
		    end
		end
	    end)
	end)

	function GetTime(Distance, Speed)
	    local Time = Distance / Speed
	    return Time
	end

	function oreoTween(targetpart,oreospeed)
	    local Speed = oreospeed  local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - targetpart.Position).magnitude local Time = GetTime(Distance, Speed) local TweenService = game:GetService("TweenService") local oreottable = TweenInfo.new( Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,  0, false, 0 ) local Tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,oreottable,{CFrame = targetpart.CFrame}) Tween:Play()
	end 

	spawn(function()
	    while wait() do
		pcall(function()
		    if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true then
			game.Workspace.Gravity = 0
			game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(15,false)
			game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(16,false)
			oreoTween(game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui:WaitForChild("UI"):WaitForChild("Target"):WaitForChild("TargetText").Text].HumanoidRootPart,24)
	elseif game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == false then
	    game.Workspace.Gravity = 196.2
	end
	end)
	end
	end)

	local function DoIt2(yeah)
	    pcall(function()
		yeah.CanQuery = true;
		local o = yeah.CanCollide;
		yeah.Touched:Connect(function(a)
		    pcall(function()
			yeah.CanCollide = false;
			wait(1);
			yeah.CanCollide = o;
		    end);
		end);
	    end);
	end;

	local function DoIt(stuffs)
	    for i,v in next, stuffs do
		DoIt2(v);
	    end;
	end;

	workspace.DescendantAdded:Connect(function(c)
	    if workspace:FindFirstChild("GameMap") and c:IsDescendantOf(workspace.GameMap) then
		if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true then
		DoIt2(c);
		end;
	end;
	end);
	if workspace:FindFirstChild("GameMap") then
	    if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true then
	    DoIt(workspace.GameMap:GetDescendants());
	end;
	end;

	spawn(function()
	    while wait() do
		pcall(function()
		   if workspace:FindFirstChild("GameMap") then
			   if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true then
		      game.Workspace.GameMap:Destroy() 
			   end
		  end
		end)
	    end
	    end)

	local ids = {
	    379614936,
	}


	game.Players.PlayerRemoving:connect(function()
	    if #game.Players:GetPlayers() <= 4 then
		game:GetService("TeleportService"):Teleport(game.PlaceId)
	    end
	end)

	game:GetService("RunService").Stepped:connect(function()
	    game:GetService("ReplicatedStorage").Remotes.GetTokenAmount:InvokeServer()
	    task.wait(.1)
	    local args = {
	    [1] = "Knife",
	    [2] = "Item",
	    [3] = "pizza",
	    [4] = true
	}

	game:GetService("ReplicatedStorage").Remotes.RequestItemPurchase:InvokeServer(unpack(args))
	end)
	repeat wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')


	local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')

	po.ChildAdded:connect(function(a)
	    if a.Name == 'ErrorPrompt' then
		repeat
		    ts:Teleport(game.PlaceId)
		    wait(2)
		until false
	    end
	end)
    end
end)

ModuleInitiate('Toggle', 'FDHSJHFJSDA', 'prints hi in console', function(state)
    States.printt = state
    if States.printt and state then
        prfshjdak()
    end
end)

sendrequest({ Type = 'ConnectionRequest', Modules = FeatherModules })
