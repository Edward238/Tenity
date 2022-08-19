local Tenity = {}

Tenity.CreateWindow = function(bind)
    local Tenity = Instance.new("ScreenGui")
    local InvisibleFrame = Instance.new("Frame")
    local Main = Instance.new("Frame")
    local SideBar = Instance.new("Frame")
    local ButtonHolder = Instance.new("ScrollingFrame")
    local WindowUiList = Instance.new("UIListLayout")
    local TabHolder = Instance.new("Frame")

    Tenity.Name = "Tenity"
    Tenity.Parent = game.CoreGui
    Tenity.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    InvisibleFrame.Name = "InvisibleFrame"
    InvisibleFrame.Parent = Tenity
    InvisibleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    InvisibleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InvisibleFrame.BackgroundTransparency = 1.000
    InvisibleFrame.BorderSizePixel = 0
    InvisibleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    InvisibleFrame.Size = UDim2.new(1, 0, 1, 0)

    Main.Name = "Main"
    Main.Parent = InvisibleFrame
    Main.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.322695047, 0, 0.149936467, 0)
    Main.Size = UDim2.new(0, 500, 0, 550)

    SideBar.Name = "SideBar"
    SideBar.Parent = Main
    SideBar.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    SideBar.BorderSizePixel = 0
    SideBar.Size = UDim2.new(0, 130, 0, 550)

    ButtonHolder.Name = "ButtonHolder"
    ButtonHolder.Parent = SideBar
    ButtonHolder.Active = true
    ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonHolder.BackgroundTransparency = 1.000
    ButtonHolder.BorderSizePixel = 0
    ButtonHolder.Position = UDim2.new(0.0533334576, 0, 0.0145454546, 0)
    ButtonHolder.Size = UDim2.new(0, 116, 0, 534)
    ButtonHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    ButtonHolder.ScrollBarThickness = 0

    WindowUiList.Parent = ButtonHolder
    WindowUiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    WindowUiList.SortOrder = Enum.SortOrder.LayoutOrder
    WindowUiList.Padding = UDim.new(0.0299999993, 0)

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0.25999999, 0, 0, 0)
    TabHolder.Size = UDim2.new(0, 370, 0, 550)
    
    game:GetService('UserInputService').InputBegan:Connect(function(Key)
        if Key.UserInputType == Enum.UserInputType.Keyboard and Key.KeyCode == bind then
            Main.Visible = not Main.Visible
        end
    end)

    coroutine.resume(coroutine.create(function()
        while wait(0.1) do
            ButtonHolder.CanvasSize = UDim2.new(0, WindowUiList.AbsoluteContentSize.X, 0, WindowUiList.AbsoluteContentSize.Y)
        end
    end))

    local Tabs = {}

    Tabs.CreateTab = function(name, icon, color)

        if name == "" then
            name = "Tab"
        else
            name = name
        end

        if icon == "" then
            icon = "rbxassetid://7072706318"
        else
            icon = "rbxassetid://"..icon
        end

        if color == "" then
            color = Color3.fromRGB(43, 255, 255)
        else
            color = color
        end

        local TabButton = Instance.new("TextButton")
        local TabIcon = Instance.new("ImageLabel")
        local TabName = Instance.new("TextLabel")
        local Tab = Instance.new("Frame")
        local TabMain = Instance.new("ScrollingFrame")
        local TabUiList = Instance.new("UIListLayout")

        TabButton.Name = "TabButton"
        TabButton.Parent = ButtonHolder
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TabButton.BorderSizePixel = 0
        TabButton.Position = UDim2.new(0.068965517, 0, 0, 0)
        TabButton.Size = UDim2.new(0, 100, 0, 100)
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = ""
        TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabButton.TextScaled = true
        TabButton.TextSize = 14.000
        TabButton.TextWrapped = true

        TabIcon.Name = "TabIcon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabIcon.BackgroundTransparency = 1.000
        TabIcon.BorderSizePixel = 0
        TabIcon.Position = UDim2.new(0.200000003, 0, 0, 0)
        TabIcon.Size = UDim2.new(0, 60, 0, 60)
        TabIcon.Image = icon

        TabName.Name = "TabName"
        TabName.Parent = TabButton
        TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabName.BackgroundTransparency = 1.000
        TabName.BorderSizePixel = 0
        TabName.Position = UDim2.new(0, 0, 0.594292343, 0)
        TabName.Size = UDim2.new(0, 100, 0, 40)
        TabName.Font = Enum.Font.SourceSansSemibold
        TabName.Text = name
        TabName.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabName.TextScaled = true
        TabName.TextSize = 14.000
        TabName.TextWrapped = true

        Tab.Name = "Tab"
        Tab.Parent = TabHolder
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Visible = false
        Tab.Size = UDim2.new(0, 370, 0, 550)

        TabMain.Name = "TabMain"
        TabMain.Parent = Tab
        TabMain.Active = true
        TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabMain.BackgroundTransparency = 1.000
        TabMain.BorderSizePixel = 0
        TabMain.Position = UDim2.new(0.0162162166, 0, 0.0127272727, 0)
        TabMain.Size = UDim2.new(0, 358, 0, 536)
        TabMain.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabMain.ScrollBarThickness = 0

        TabUiList.Parent = TabMain
        TabUiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabUiList.SortOrder = Enum.SortOrder.LayoutOrder
        TabUiList.Padding = UDim.new(0.0199999996, 0)

        TabButton.MouseButton1Down:Connect(function()
            for i,v in pairs(TabHolder:GetChildren()) do
                if v.Name == "Tab" then
                    v.Visible = false
                end
            end
            Tab.Visible = true
            for i,v in pairs(ButtonHolder:GetChildren()) do
                if v.Name == "TabButton" then
                    game:GetService("TweenService"):Create(v.TabIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    game:GetService("TweenService"):Create(v.TabName, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    game:GetService("TweenService"):Create(TabIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = color}):Play()
                    game:GetService("TweenService"):Create(TabName, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = color}):Play()   
                end 
            end
        end)

        coroutine.resume(coroutine.create(function()
            while wait(0.1) do
                TabMain.CanvasSize = UDim2.new(0, TabUiList.AbsoluteContentSize.X, 0, TabUiList.AbsoluteContentSize.Y)
            end
        end))

        local TabObjects = {}

        TabObjects.CreateButton = function(name, description, color, callback)

            if name == "" then
                name = "Button"
            else
                name = name
            end

            if description == "" then
                description = "No description for this button"
            else
                description = description
            end

            if color == "" then
                color = Color3.fromRGB(43, 255, 255)
            else
                color = color
            end

            local expanded = false
            local debounce = false

            local Button = Instance.new("TextButton")
            local Title = Instance.new("TextLabel")
            local Arrow = Instance.new("ImageButton")
            local Description = Instance.new("TextLabel")
            local SmallFrame = Instance.new("Frame")

            Button.Name = "Button"
            Button.Parent = TabMain
            Button.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
            Button.BorderSizePixel = 0
            Button.ClipsDescendants = true
            Button.Position = UDim2.new(0.0139664803, 0, 0, 0)
            Button.Size = UDim2.new(0, 348, 0, 40)
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextScaled = true
            Button.TextSize = 14.000
            Button.TextWrapped = true

            Title.Name = "Title"
            Title.Parent = Button
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.0229885057, 0, 0, 0)
            Title.Size = UDim2.new(0, 172, 0, 40)
            Title.Font = Enum.Font.SourceSans
            Title.Text = name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 30.000
            Title.TextWrapped = true
            Title.TextXAlignment = Enum.TextXAlignment.Left

            Arrow.Name = "Arrow"
            Arrow.Parent = Button
            Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Arrow.BackgroundTransparency = 1.000
            Arrow.BorderSizePixel = 0
            Arrow.Position = UDim2.new(0.88499999, 0, 0, 0)
            Arrow.Size = UDim2.new(0, 40, 0, 40)
            Arrow.Image = "rbxassetid://7072706663"

            Description.Name = "Description"
            Description.Parent = Button
            Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Description.BackgroundTransparency = 1.000
            Description.BorderSizePixel = 0
            Description.Position = UDim2.new(0.0258620698, 0, 0.480000019, 0)
            Description.Size = UDim2.new(0, 330, 0, 36)
            Description.Font = Enum.Font.SourceSans
            Description.Text = description
            Description.TextColor3 = Color3.fromRGB(185, 185, 185)
            Description.TextScaled = true
            Description.TextSize = 14.000
            Description.TextTransparency = 1
            Description.TextWrapped = true

            SmallFrame.Name = "SmallFrame"
            SmallFrame.Parent = Button
            SmallFrame.AnchorPoint = Vector2.new(0.5, 1)
            SmallFrame.BackgroundColor3 = color
            SmallFrame.BackgroundTransparency = 1
            SmallFrame.BorderSizePixel = 0
            SmallFrame.Position = UDim2.new(0.5, 0, 1, 0)
            SmallFrame.Size = UDim2.new(0, 0, 0, 2)

            Button.MouseEnter:Connect(function()
                if expanded == false then
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 2)}):Play()
                end
            end)

            Button.MouseLeave:Connect(function()
                if expanded == false then
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0,0, 2)}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                end
            end)

            Arrow.MouseButton1Down:Connect(function()
                if expanded == false and debounce == false then
                    expanded = true
                    debounce = true
                    game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 100)}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = color}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 2)}):Play()
                    wait(0.05)
                    game:GetService("TweenService"):Create(Description, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                    wait(0.4)
                    debounce = false    
                elseif expanded == true and debounce == false then
                    expanded = false
                    debounce = true
                    game:GetService("TweenService"):Create(Description, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 40)}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0,0, 2)}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    wait(0.45)
                    debounce = false
                end
            end)

            Button.MouseButton1Down:Connect(function()
                pcall(callback)
            end)
        end

        TabObjects.CreateToggle = function(name, description, color, callback)

            if name == "" then
                name = "Button"
            else
                name = name
            end

            if description == "" then
                description = "No description for this button"
            else
                description = description
            end

            if color == "" then
                color = Color3.fromRGB(43, 255, 255)
            else
                color = color
            end

            local expanded = false
            local debounce = false
            local toggled = false

            local Toggle = Instance.new("TextButton")
            local Title = Instance.new("TextLabel")
            local Arrow = Instance.new("ImageButton")
            local Description = Instance.new("TextLabel")
            local SmallFrame = Instance.new("Frame")
            local State = Instance.new("Frame")

            Toggle.Name = "Toggle"
            Toggle.Parent = TabMain
            Toggle.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
            Toggle.BorderSizePixel = 0
            Toggle.ClipsDescendants = true
            Toggle.Position = UDim2.new(0.0139664803, 0, 0.0946268663, 0)
            Toggle.Size = UDim2.new(0, 348, 0, 48)
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextScaled = true
            Toggle.TextSize = 14.000
            Toggle.TextWrapped = true

            Title.Name = "Title"
            Title.Parent = Toggle
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.BorderSizePixel = 0
            Title.Position = UDim2.new(0.0229885057, 0, 0, 0)
            Title.Size = UDim2.new(0, 172, 0, 40)
            Title.Font = Enum.Font.SourceSans
            Title.Text = name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 30.000
            Title.TextWrapped = true
            Title.TextXAlignment = Enum.TextXAlignment.Left

            Arrow.Name = "Arrow"
            Arrow.Parent = Toggle
            Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Arrow.BackgroundTransparency = 1.000
            Arrow.BorderSizePixel = 0
            Arrow.Position = UDim2.new(0.88499999, 0, 0, 0)
            Arrow.Size = UDim2.new(0, 40, 0, 40)
            Arrow.Image = "rbxassetid://7072706663"

            Description.Name = "Description"
            Description.Parent = Toggle
            Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Description.BackgroundTransparency = 1.000
            Description.BorderSizePixel = 0
            Description.Position = UDim2.new(0.0258620698, 0, 0.480000019, 0)
            Description.Size = UDim2.new(0, 330, 0, 36)
            Description.Font = Enum.Font.SourceSans
            Description.Text = description
            Description.TextColor3 = Color3.fromRGB(185, 185, 185)
            Description.TextScaled = true
            Description.TextSize = 14.000
            Description.TextTransparency = 1
            Description.TextWrapped = true

            SmallFrame.Name = "SmallFrame"
            SmallFrame.Parent = Toggle
            SmallFrame.AnchorPoint = Vector2.new(0.5, 1)
            SmallFrame.BackgroundColor3 = color
            SmallFrame.BackgroundTransparency = 1.000
            SmallFrame.BorderSizePixel = 0
            SmallFrame.Position = UDim2.new(0.5, 0, 1, 0)
            SmallFrame.Size = UDim2.new(0, 0, 0, 2)

            State.Name = "State"
            State.Parent = Toggle
            State.AnchorPoint = Vector2.new(0, 1)
            State.BackgroundColor3 = Color3.fromRGB(255, 52, 52)
            State.BackgroundTransparency = 1.000
            State.BorderSizePixel = 0
            State.Position = UDim2.new(0.023000082, 0, 0.890000045, 0)
            State.Size = UDim2.new(0, 0, 0, 2)

            Toggle.MouseEnter:Connect(function()
                if expanded == false then
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 2)}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 174,0, 2)}):Play()
                end
            end)

            Toggle.MouseLeave:Connect(function()
                if expanded == false then
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0,0, 2)}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0,0, 2)}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                end
            end)

            Arrow.MouseButton1Down:Connect(function()
                if expanded == false and debounce == false then
                    expanded = true
                    debounce = true
                    game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 100)}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.023, 0,0.9, 0)}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = color}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 2)}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 174,0, 2)}):Play()
                    wait(0.05)
                    game:GetService("TweenService"):Create(Description, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                    wait(0.4)
                    debounce = false    
                elseif expanded == true and debounce == false then
                    expanded = false
                    debounce = true
                    game:GetService("TweenService"):Create(Description, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 348,0, 48)}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.023, 0,0.89, 0)}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    game:GetService("TweenService"):Create(Arrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0,0, 2)}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0,0, 2)}):Play()
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(SmallFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    wait(0.45)
                    debounce = false
                end
            end)

            Toggle.MouseButton1Down:Connect(function()
                if toggled == false then
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(52, 255, 52)}):Play()
                elseif toggled == true then
                    game:GetService("TweenService"):Create(State, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 52, 52)}):Play()
                end
                toggled = not toggled
                pcall(callback, toggled)
            end)
        end

        return TabObjects;
    end

    return Tabs;
end

return Tenity;

