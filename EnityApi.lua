local EntityApi = {}

function EntityApi:GetPlayer(String)
	if not String then return end
	local Yes = {}
	for _, Player in ipairs(game.Players:GetPlayers()) do
		if string.lower(Player.Name):match(string.lower(String)) or string.lower(Player.DisplayName):match(string.lower(String)) then
			table.insert(Yes, Player)
		end
	end
	if #Yes > 0 then
		return Yes[1]
	elseif #Yes < 1 then
		return nil
	end
end

function EntityApi:GetLocalPlayer()
	local LocalPlayer = game:GetService('Players').LocalPlayer
	if game:GetService('Players'):FindFirstChild(LocalPlayer.Name) or game:GetService('Players'):FindFirstChild(LocalPlayer.DisplayName) then
		return LocalPlayer
	else
		return nil
	end
end

function EntityApi:GetCharacter(string)
	local Player = EntityApi:GetPlayer(string)
	if Player then
		local Character
		for i,v in pairs(game:GetDescendants()) do
			if v.Name == Player.Name or v.Name == Player.DisplayName then
				if v:IsA('Model') and v:FindFirstChildWhichIsA('Humanoid') then
					Character = Player.Character or v 
				end
			end
		end
		if not Character then
			Character = Player.Character or game:GetService('Workspace'):FindFirstChild(Player.Name)
		end
		if Character then
			return Character
		else
			return nil
		end
	else
		return nil
	end
end

function EntityApi:PlayerAlive(string)
	local Player = EntityApi:GetPlayer(string)
	if Player then
		local Character = EntityApi:GetCharacter(Player.Name)
		if Character then
			local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart')
			if HumanoidRootPart then
				local Humanoid = Character:FindFirstChildWhichIsA('Humanoid')
				if Humanoid and Humanoid.Health > 0 then
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function EntityApi:GetRootPart(string)
	local Player = EntityApi:GetPlayer(string)
	if Player then
		local Character = EntityApi:GetCharacter(Player.Name)
		if Character then
			if EntityApi:PlayerAlive(Player.Name) then
				local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart')
				if HumanoidRootPart then
					return HumanoidRootPart
				else
					return nil
				end
			else
				return nil
			end
		else
			return nil
		end
	else
		return nil
	end
end

function EntityApi:GetHumanoid(string)
	local Player = EntityApi:GetPlayer(string)
	if Player then
		local Character = EntityApi:GetCharacter(Player.Name)
		if Character then
			if EntityApi:PlayerAlive(Player.Name) then
				local Humanoid = Character:FindFirstChildWhichIsA('Humanoid')
				if Humanoid then
					return Humanoid
				else
					return nil
				end
			else
				return nil
			end
		else
			return nil
		end
	else
		return nil
	end
end

return EntityApi
