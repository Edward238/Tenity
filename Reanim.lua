local Player = game:GetService('Players').LocalPlayer
local Character = Player.Character
local Humanoid = Character:FindFirstChildWhichIsA('Humanoid')
local Mouse = Player:GetMouse()

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

function Align(part, parent, p, r) 
    Instance.new("Attachment",part) 
    Instance.new("AlignPosition",part) 
    Instance.new("AlignOrientation",part) 
    Instance.new("Attachment",parent) 
    part.Attachment.Name = part.Name 
    parent.Attachment.Name = part.Name 
    part.AlignPosition.Attachment0 = part[part.Name] 
    part.AlignOrientation.Attachment0 = part[part.Name] 
    part.AlignPosition.Attachment1 = parent[part.Name] 
    part.AlignOrientation.Attachment1 = parent[part.Name] 
    parent[part.Name].Position = p or Vector3.new() 
    part[part.Name].Orientation = r or Vector3.new() 
    part.AlignPosition.MaxForce = math.huge 
    part.AlignPosition.MaxVelocity = math.huge
    part.AlignPosition.ReactionForceEnabled = false 
    part.AlignPosition.Responsiveness = math.huge
    part.AlignOrientation.Responsiveness = math.huge
    part.AlignPosition.RigidityEnabled = false 
    part.AlignOrientation.MaxTorque = math.huge
end

function Position(part, parent, p)
    Instance.new("Attachment",part)
    Instance.new("AlignPosition",part)
    Instance.new("Attachment",parent)
    part.Attachment.Name = part.Name
    parent.Attachment.Name = part.Name
    part.AlignPosition.Attachment0 = part[part.Name]
    --part.AlignOrientation.Attachment0 = part[part.Name]
    part.AlignPosition.Attachment1 = parent[part.Name]
    --part.AlignOrientation.Attachment1 = parent[part.Name]
    parent[part.Name].Position = p or Vector3.new()
    part.AlignPosition.MaxForce = math.huge
    part.AlignPosition.MaxVelocity = math.huge
    part.AlignPosition.ReactionForceEnabled = false
    part.AlignPosition.Responsiveness = math.huge
    --part.AlignOrientation.Responsiveness = math.huge
    --part.AlignPosition.RigidityEnabled = false
    --part.AlignOrientation.MaxTorque = 999999999
    part.Massless=true
end

function Flinger(part)
  FlingVelocity = Instance.new('BodyAngularVelocity', part)
  FlingVelocity.P = 9e9
  FlingVelocity.AngularVelocity = Vector3.new(9e9, 9e9, 9e9)
  FlingVelocity.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
end

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

local Http = game:GetService('HttpService')
local Step = game:GetService('RunService').Stepped
local Render = game:GetService('RunService').RenderStepped
local Heartbeat = game:GetService('RunService').Heartbeat
local Connections = {}

local Sin = math.sin
local Cos = math.cos
local Huge = math.huge
local Rad = math.rad

local CFrame = CFrame.new

local V3 = Vector3.new
local V2 = Vector2.new

local Instance = Instance.new

local FlingHat = Character:FindFirstChild('Robloxclassicred'):FindFirstChild('Handle')

local Netless = V3(-30, 0, 0)

local Done = false
local Holding = false

for _,Part in next, Character:GetDescendants() do
    if Part:IsA('BasePart') then
        Connections[#Connections + 1] = Heartbeat:Connect(function()
            Part.AssemblyLinearVelocity = Netless
            sethiddenproperty(Player, 'MaximumSimulationRadius', math.huge) 
            sethiddenproperty(Player, 'SimulationRadius', 9e9)
        end) 
    end
end

Character.Archivable = true

local CharacterClone = Character:Clone()

local CharacterCloneFolder = Instance('Folder', Character)
CharacterCloneFolder.Name = Http:GenerateGUID(true)

local PartsFolder = Instance('Folder', CharacterCloneFolder)
PartsFolder.Name = 'Parts'

FlingHat:BreakJoints()
FlingHat:FindFirstChildWhichIsA('SpecialMesh'):Destroy()
FlingHat.Parent = Character
Character:FindFirstChild('Robloxclassicred'):Destroy()
FlingHat.Name = 'Left Leg'

CharacterClone:FindFirstChild('Animate').Disabled = true

Humanoid:ChangeState(16)

Character:FindFirstChild('Animate').Disabled = true

for _,Animation in next, Humanoid:GetPlayingAnimationTracks() do
    Animation:Stop() 
end

Character['Left Leg'].Name = 'FlingLeg'

Character:FindFirstChild('Animate'):Destroy()

Character.Torso["Left Shoulder"]:Destroy()
Character.Torso["Right Shoulder"]:Destroy()
Character.Torso["Left Hip"]:Destroy()
Character.Torso["Right Hip"]:Destroy()

--Character['FlingLeg']:BreakJoints()

Align(Character['Torso'], CharacterClone['Torso'])
Align(Character['Left Arm'], CharacterClone['Left Arm'])
Align(Character['Right Arm'], CharacterClone['Right Arm'])
Align(FlingHat, CharacterClone['Left Leg'], V3(), V3(90, 0, 0))
Align(Character['Right Leg'], CharacterClone['Right Leg'])

for _,Accessory in next, Character:GetChildren() do
    if Accessory:IsA('Accessory') and Accessory:FindFirstChild('Handle') then
        Accessory:FindFirstChild('Handle'):BreakJoints()
        Align(Accessory:FindFirstChild('Handle'), CharacterClone[Accessory.Name]:FindFirstChild('Handle'))
        Connections[#Connections + 1] = Heartbeat:Connect(function()
            Accessory:FindFirstChild('Handle').AssemblyLinearVelocity = Netless
        end) 
    end
end

for _,Object in next, CharacterClone:GetDescendants() do
    if Object:IsA('BasePart') or Object:IsA('Decal') then
        Object.Transparency = 1 
    end
end

Position(Character['FlingLeg'], CharacterClone['HumanoidRootPart'])
Flinger(Character['FlingLeg'])

Connections[#Connections + 1] = Heartbeat:Connect(function()
    if Done == true then
        if Holding == true then
            Character['FlingLeg'].Position = Mouse.Hit.Position
        else
            Character['FlingLeg'].Position = CharacterClone['HumanoidRootPart'].Position
        end
    end
end)

Connections[#Connections + 1] = Mouse.Button1Down:Connect(function()
    if Holding == false then
        Holding = true 
    end
end)

Connections[#Connections + 1] = Mouse.Button1Up:Connect(function()
    if Holding == true then
        Holding = false 
    end
end)

for _,Part in next, Character:GetDescendants() do
    if Part:IsA('BasePart') then
        Connections[#Connections + 1] = Step:Connect(function()
            Part.CanCollide = false
        end) 
        Connections[#Connections + 1] = Render:Connect(function()
            Part.CanCollide = false
        end) 
    end
end

for _,Part in next, CharacterClone:GetDescendants() do
    if Part:IsA('BasePart') then
        Connections[#Connections + 1] = Step:Connect(function()
            Part.CanCollide = false
        end) 
        Connections[#Connections + 1] = Render:Connect(function()
            Part.CanCollide = false
        end) 
    end
end

Player.Character = CharacterClone
CharacterClone.Parent = CharacterCloneFolder
game:GetService('Workspace').CurrentCamera.CameraSubject = CharacterClone:FindFirstChildWhichIsA('Humanoid')
Done = true

CharacterClone:FindFirstChildWhichIsA('Humanoid').Died:Connect(function()
    for _ = 1,#Connections do
        Connections[_]:Disconnect()
        Connections[_] = nil
    end
    Humanoid.Health = -9e9
    Player.Character = Character
    game:GetService('Workspace').CurrentCamera.CameraSubject = Humanoid
end)

return CharacterClone
