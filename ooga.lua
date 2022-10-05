local Magnitude = {}

local Strings = {}

Strings.RandomString = function(length)
	local characters = {
		'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 
		'1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
		'q',' w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm' 
	}
	
	local randomString = ''
	
	for o = 1,length do
		local nextChar = characters[math.random(1,#characters)]
		randomString = randomString..nextChar
	end
	
	if randomString ~= nil and randomString ~= '' then
		return randomString
	else
		return 'invalid string'
	end
end

local TweenService = game:GetService('TweenService')
local GuiColour

Magnitude.Window = function(params)
	local WindowName = params['Name'] or Strings.RandomString(20)
	local WindowSecondName = params['Version'] or '0.0.1'
	local WindowColour = params['Colour'] or Color3.fromRGB(0, 200, 90)
	
	GuiColour = WindowColour

	local UI = Instance.new('ScreenGui')
	local Main = Instance.new('Frame')
	local UICorner = Instance.new('UICorner')
	local Frames = Instance.new('Frame')
	local Side = Instance.new('Frame')
	local ButtonHolder = Instance.new('ScrollingFrame')
	local UIListLayout = Instance.new('UIListLayout')
	local LittleBar = Instance.new('Frame')
	local UICorner_2 = Instance.new('UICorner')
	local Title = Instance.new('TextLabel')
	local Name = Instance.new('TextLabel')

	UI.Name = Strings.RandomString(20)
	UI.Parent = game:GetService('CoreGui')
	UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = 'Main'
	Main.Parent = UI
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Main.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 500, 0, 300)

	UICorner.CornerRadius = UDim.new(0, 5)
	UICorner.Parent = Main

	Frames.Name = 'Frames'
    Frames.Parent = Main
    Frames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frames.BackgroundTransparency = 1.000
    Frames.BorderSizePixel = 0
    Frames.ClipsDescendants = true
    Frames.Position = UDim2.new(0.219999999, 0, 0, 0)
    Frames.Size = UDim2.new(0, 390, 0, 300)

	Side.Name = 'Side'
	Side.Parent = Main
	Side.BackgroundColor3 = WindowColour
	Side.BorderSizePixel = 0
	Side.ClipsDescendants = true
	Side.Size = UDim2.new(0, 110, 0, 300)

	ButtonHolder.Name = 'ButtonHolder'
	ButtonHolder.Parent = Side
	ButtonHolder.Active = true
	ButtonHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ButtonHolder.BackgroundTransparency = 1.000
	ButtonHolder.BorderSizePixel = 0
	ButtonHolder.ClipsDescendants = false
	ButtonHolder.Position = UDim2.new(0.5, 0, 0.610000014, 0)
	ButtonHolder.Size = UDim2.new(0, 110, 0, 220)
	ButtonHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
	ButtonHolder.ScrollBarThickness = 0

	UIListLayout.Parent = ButtonHolder
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.0299999993, 0)

	LittleBar.Name = 'LittleBar'
	LittleBar.Parent = Side
	LittleBar.BackgroundColor3 = WindowColour
	LittleBar.BorderSizePixel = 0
	LittleBar.Position = UDim2.new(0.927272737, 0, 0, 0)
	LittleBar.Size = UDim2.new(0, 18, 0, 300)

	UICorner_2.CornerRadius = UDim.new(0, 5)
	UICorner_2.Parent = Side

	Title.Name = 'Title'
	Title.Parent = Side
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0.0363636352, 0, 0.0199999996, 0)
	Title.Size = UDim2.new(0, 102, 0, 31)
	Title.Font = Enum.Font.SourceSans
	Title.Text = WindowName
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true

	Name.Name = 'Name'
	Name.Parent = Side
	Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Name.BackgroundTransparency = 1.000
	Name.BorderSizePixel = 0
	Name.Position = UDim2.new(0.075000003, 0, 0.122000001, 0)
	Name.Size = UDim2.new(0, 96, 0, 23)
	Name.Font = Enum.Font.SourceSans
	Name.Text = WindowSecondName
	Name.TextColor3 = Color3.fromRGB(218, 218, 218)
	Name.TextScaled = true
	Name.TextSize = 20.000
	Name.TextWrapped = true
	
	local tabs = {}
	
	tabs.Tab = function(params)
		local TabName = params['Name'] or Strings.RandomString(5)
		local TabIcon = params['Icon'] or 'rbxassetid://7072718840'
		
		local Tab = Instance.new('ScrollingFrame')
		local UIListLayout2 = Instance.new('UIListLayout')
		local TabButton = Instance.new('TextButton')
		local UICorner = Instance.new('UICorner')
		local TabIcon = Instance.new('ImageLabel')
		local TextLabel = Instance.new('TextLabel')

		Tab.Name = 'Tab'
		Tab.Parent = Frames
        Tab.Active = true
        Tab.AnchorPoint = Vector2.new(0.5, 0.5)
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.ClipsDescendants = false
        Tab.Position = UDim2.new(0.5, 0, 0.5, 0)
        Tab.Size = UDim2.new(0, 373, 0, 284)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 0

        UIListLayout2.Parent = Tab
        UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout2.Padding = UDim.new(0.0299999993, 0)

		TabButton.Name = 'Tab'
		TabButton.Parent = ButtonHolder
		TabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0, 80, 0, 80)
		TabButton.Font = Enum.Font.SourceSans
		TabButton.Text = ''
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextScaled = true
		TabButton.TextSize = 14.000
		TabButton.TextWrapped = true

		UICorner.CornerRadius = UDim.new(0, 5)
		UICorner.Parent = TabButton

		TabIcon.Name = 'TabIcon'
		TabIcon.Parent = TabButton
		TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabIcon.BackgroundTransparency = 1.000
		TabIcon.BorderSizePixel = 0
		TabIcon.Position = UDim2.new(0.1875, 0, 0.0874999985, 0)
		TabIcon.Size = UDim2.new(0, 50, 0, 50)
		TabIcon.Image = 'rbxassetid://7072718840'
		TabIcon.ImageColor3 = Color3.fromRGB(206, 206, 206)

		TextLabel.Parent = TabButton
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.0500000007, 0, 0.75, 0)
		TextLabel.Size = UDim2.new(0, 71, 0, 16)
		TextLabel.Font = Enum.Font.Gotham
		TextLabel.Text = TabName
		TextLabel.TextColor3 = Color3.fromRGB(206, 206, 206)
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14.000
		TextLabel.TextWrapped = true
		
		Tab.Visible = false
		
		TabButton.MouseButton1Click:Connect(function()
			for i,v in pairs(Frames:GetChildren()) do
				if v:IsA('ScrollingFrame') then
					v.Visible = false
				end
			end
			Tab.Visible = true
			for i,v in pairs(ButtonHolder:GetChildren()) do
				if v:IsA('TextButton') then
					TweenService:Create(
						v,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						v.TextLabel,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(206, 206, 206)}
					):Play()
					TweenService:Create(
						TabButton,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0.8}
					):Play()
					TweenService:Create(
						TextLabel,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)}
					):Play()
				end
			end
		end)
		
		local components = {}
		
		components.Button = function(params)
		    local ButtonName = params['Name'] or Strings.RandomString(5)
		    
		    local Button = Instance.new('TextButton')
            local ButtonCorner = Instance.new('UICorner')
            local LittleFrame = Instance.new('Frame')
            local FrameCorner = Instance.new('UICorner')
            local ButtonTitle = Instance.new('TextLabel')
            
            Button.Name = 'Button'
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
            Button.BorderSizePixel = 0
            Button.ClipsDescendants = true
            Button.Position = UDim2.new(-0.00938337762, 0, 0, 0)
            Button.Size = UDim2.new(0, 380, 0, 35)
            Button.Font = Enum.Font.Gotham
            Button.Text = ''
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextScaled = true
            Button.TextSize = 14.000
            Button.TextWrapped = true
            
            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Name = 'ButtonCorner'
            ButtonCorner.Parent = Button
            
            LittleFrame.Name = 'LittleFrame'
            LittleFrame.Parent = Button
            LittleFrame.BackgroundColor3 = GuiColour
            LittleFrame.BorderSizePixel = 0
            LittleFrame.ClipsDescendants = true
            LittleFrame.Position = UDim2.new(-0.0236842111, 0, 0, 0)
            LittleFrame.Size = UDim2.new(0, 4, 0, 35)
            
            FrameCorner.CornerRadius = UDim.new(0, 5)
            FrameCorner.Name = 'FrameCorner'
            FrameCorner.Parent = LittleFrame
            
            ButtonTitle.Name = 'ButtonTitle'
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.BorderSizePixel = 0
            ButtonTitle.Position = UDim2.new(0.0552631579, 0, 0.0857142881, 0)
            ButtonTitle.Size = UDim2.new(0, 200, 0, 29)
            ButtonTitle.Font = Enum.Font.SourceSans
            ButtonTitle.Text = ButtonName
            ButtonTitle.TextColor3 = Color3.fromRGB(182, 182, 182)
            ButtonTitle.TextSize = 20.000
            ButtonTitle.TextWrapped = true
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(
					LittleFrame,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 20, 0, 35)}
				):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(
					LittleFrame,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 4, 0, 35)}
				):Play()
            end)
		end
		
		return components
	end
	
	return tabs
end

return Magnitude
