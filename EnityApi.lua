local EntityApi = {}

function EntityApi:GetPlayer(string)
	if not string then return end
	local Players = {}
	for i,v in ipairs(game:GetService('Players'):GetPlayers()) do
		if string.lower(v.Name):match(string.lower(string)) or string.lower(v.DisplayName):match(string.lower(string)) then
			table.insert(Players, v)
		end
	end
	if #Players > 0 then
		return Players[1]
	elseif #Players < 1 then
		return nil
	end
edsg

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

function EntityApi:RespawnPlayer(string)
    local Player = EntityApi:GetPlayer(string)
	if Player then
	    local Character = EntityApi:GetCharacter(Player.Name)
	    if Character then
	        if EntityApi:PlayerAlive(Player.Name) then
	            local Humanoid = EntityApi:GetHumanoid(Player.Name)
	            if Humanoid then
	                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
	            end
	            Character:ClearAllChildren()
    	    end 
	    end
	end
end

return EntityApi
