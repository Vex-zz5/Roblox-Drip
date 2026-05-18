local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

local VexoDrip = {}
VexoDrip.Active = true
VexoDrip.UI = {}
VexoDrip.Modules = {}
VexoDrip.Settings = {
    Movement = {
        Speed = 16,
        FlySpeed = 50,
        Noclip = false,
        Fly = false,
        OrbitEnabled = false,
        OrbitTarget = nil,
        OrbitRadius = 10,
        OrbitSpeed = 2,
        BunnyHop = false,
        AutoStrafe = false,
        Slide = false,
        WallClimb = false,
        SuperJump = false,
        SuperJumpPower = 100,
        MoonGravity = false,
        GravityMultiplier = 1,
        AntiFall = false
    },
    Player = {
        FlingEnabled = false,
        FlingForce = 10000,
        BringAll = false,
        BringPosition = Vector3.new(0, 50, 0),
        RagdollAll = false,
        FreezeAll = false,
        UnfreezeAll = false,
        Invisibility = false,
        GodMode = false,
        NoCollide = false,
        ForceField = false,
        Scale = 1,
        HeadSize = 1,
        LegLength = 1,
        ArmLength = 1,
        BodyColor = Color3.new(1, 1, 1),
        HeadColor = Color3.new(1, 0, 0),
        LimbsColor = Color3.new(0, 1, 0)
    },
    Visuals = {
        ESPEnabled = true,
        ESPColor = Color3.new(1, 0.2, 0.2),
        BoxESP = true,
        NameESP = true,
        DistanceESP = true,
        HealthESP = true,
        TracerESP = true,
        TracerColor = Color3.new(0.2, 1, 0.2),
        GlitchEffect = true,
        GlitchIntensity = 5,
        ScreenShake = false,
        ShakeIntensity = 2,
        NightVision = false,
        Brightness = 2,
        ColorCorrection = true,
        Contrast = 1.5,
        Saturation = 2,
        Bloom = true,
        BloomIntensity = 3,
        MotionBlur = false,
        BlurSize = 5,
        Crosshair = true,
        CrosshairColor = Color3.new(1, 1, 1),
        CrosshairSize = 5,
        CrosshairThickness = 2,
        ParticleEffects = true,
        ParticleColor = Color3.new(0.5, 0.2, 1),
        ParticleRate = 50,
        TrailEnabled = true,
        TrailColor = Color3.new(1, 0.5, 0),
        TrailLength = 10
    },
    World = {
        DestroyAll = false,
        DeleteAnchored = false,
        UnanchorAll = false,
        AnchorAll = false,
        Gravity = 196.2,
        TimeOfDay = 12,
        FogEnabled = false,
        FogDensity = 0.1,
        FogColor = Color3.new(0.5, 0.5, 0.5),
        Skybox = "rbxassetid://123456789",
        SpawnParts = false,
        SpawnRate = 10,
        PartSize = Vector3.new(5, 5, 5),
        PartColor = Color3.new(1, 1, 0),
        ExplodeAll = false,
        ExplosionRadius = 50,
        ExplosionDamage = 100
    },
    Combat = {
        KillAll = false,
        DamageAll = false,
        DamageAmount = 50,
        AutoClick = false,
        ClickRate = 10,
        AutoAttack = false,
        AttackRange = 20,
        AutoReload = false,
        InfiniteAmmo = false,
        NoRecoil = false,
        Spread = 0,
        OneShotKill = false,
        Triggerbot = false,
        TriggerKey = Enum.KeyCode.LeftControl,
        FOV = 15
    },
    Keybinds = {
        ToggleUI = Enum.KeyCode.RightShift,
        SpeedUp = Enum.KeyCode.Equals,
        SpeedDown = Enum.KeyCode.Minus,
        ToggleFly = Enum.KeyCode.F,
        ToggleNoclip = Enum.KeyCode.N,
        ToggleESP = Enum.KeyCode.E,
        ToggleGlitch = Enum.KeyCode.G,
        ToggleGodMode = Enum.KeyCode.H,
        ToggleFling = Enum.KeyCode.R,
        BringAll = Enum.KeyCode.B,
        RagdollAll = Enum.KeyCode.T,
        ToggleNightVision = Enum.KeyCode.V,
        ToggleBunnyHop = Enum.KeyCode.Space,
        SuperJump = Enum.KeyCode.LeftAlt
    },
    UI = {
        Theme = {
            Primary = Color3.new(0.1, 0.1, 0.1),
            Secondary = Color3.new(0.2, 0.05, 0.3),
            Accent = Color3.new(0.8, 0.2, 1),
            Text = Color3.new(1, 1, 1),
            Highlight = Color3.new(1, 0.5, 0)
        },
        Open = true,
        Transparency = 0.1,
        GlitchSpeed = 0.05,
        AnimationSpeed = 0.2,
        WindowSize = Vector2.new(700, 500),
        WindowPosition = Vector2.new(100, 100),
        TabSize = Vector2.new(120, 40),
        ButtonSize = Vector2.new(100, 30),
        SliderSize = Vector2.new(200, 20),
        ToggleSize = Vector2.new(40, 20)
    }
}

VexoDrip.UI.ScreenGui = Instance.new("ScreenGui")
VexoDrip.UI.ScreenGui.Name = "VexoDripHub"
VexoDrip.UI.ScreenGui.Parent = LocalPlayer.PlayerGui
VexoDrip.UI.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

VexoDrip.UI.MainFrame = Instance.new("Frame")
VexoDrip.UI.MainFrame.Name = "MainFrame"
VexoDrip.UI.MainFrame.Size = UDim2.new(0, VexoDrip.Settings.UI.WindowSize.X, 0, VexoDrip.Settings.UI.WindowSize.Y)
VexoDrip.UI.MainFrame.Position = UDim2.new(0, VexoDrip.Settings.UI.WindowPosition.X, 0, VexoDrip.Settings.UI.WindowPosition.Y)
VexoDrip.UI.MainFrame.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Primary
VexoDrip.UI.MainFrame.BackgroundTransparency = VexoDrip.Settings.UI.Transparency
VexoDrip.UI.MainFrame.BorderSizePixel = 0
VexoDrip.UI.MainFrame.ClipsDescendants = true
VexoDrip.UI.MainFrame.Parent = VexoDrip.UI.ScreenGui

VexoDrip.UI.TitleBar = Instance.new("Frame")
VexoDrip.UI.TitleBar.Name = "TitleBar"
VexoDrip.UI.TitleBar.Size = UDim2.new(1, 0, 0, 40)
VexoDrip.UI.TitleBar.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary
VexoDrip.UI.TitleBar.BorderSizePixel = 0
VexoDrip.UI.TitleBar.Parent = VexoDrip.UI.MainFrame

VexoDrip.UI.TitleText = Instance.new("TextLabel")
VexoDrip.UI.TitleText.Name = "TitleText"
VexoDrip.UI.TitleText.Size = UDim2.new(1, 0, 1, 0)
VexoDrip.UI.TitleText.Position = UDim2.new(0, 10, 0, 0)
VexoDrip.UI.TitleText.BackgroundTransparency = 1
VexoDrip.UI.TitleText.Text = "VexoDrip"
VexoDrip.UI.TitleText.TextColor3 = VexoDrip.Settings.UI.Theme.Accent
VexoDrip.UI.TitleText.TextScaled = true
VexoDrip.UI.TitleText.Font = Enum.Font.RobotoMono
VexoDrip.UI.TitleText.TextXAlignment = Enum.TextXAlignment.Left
VexoDrip.UI.TitleText.Parent = VexoDrip.UI.TitleBar

VexoDrip.UI.CloseButton = Instance.new("TextButton")
VexoDrip.UI.CloseButton.Name = "CloseButton"
VexoDrip.UI.CloseButton.Size = UDim2.new(0, 40, 0, 40)
VexoDrip.UI.CloseButton.Position = UDim2.new(1, -40, 0, 0)
VexoDrip.UI.CloseButton.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent
VexoDrip.UI.CloseButton.Text = "X"
VexoDrip.UI.CloseButton.TextColor3 = VexoDrip.Settings.UI.Theme.Text
VexoDrip.UI.CloseButton.TextScaled = true
VexoDrip.UI.CloseButton.Font = Enum.Font.RobotoMono
VexoDrip.UI.CloseButton.Parent = VexoDrip.UI.TitleBar

VexoDrip.UI.TabContainer = Instance.new("Frame")
VexoDrip.UI.TabContainer.Name = "TabContainer"
VexoDrip.UI.TabContainer.Size = UDim2.new(0, VexoDrip.Settings.UI.TabSize.X, 1, -40)
VexoDrip.UI.TabContainer.Position = UDim2.new(0, 0, 0, 40)
VexoDrip.UI.TabContainer.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary
VexoDrip.UI.TabContainer.BorderSizePixel = 0
VexoDrip.UI.TabContainer.ClipsDescendants = true
VexoDrip.UI.TabContainer.Parent = VexoDrip.UI.MainFrame

VexoDrip.UI.ContentContainer = Instance.new("Frame")
VexoDrip.UI.ContentContainer.Name = "ContentContainer"
VexoDrip.UI.ContentContainer.Size = UDim2.new(1, -VexoDrip.Settings.UI.TabSize.X, 1, -40)
VexoDrip.UI.ContentContainer.Position = UDim2.new(0, VexoDrip.Settings.UI.TabSize.X, 0, 40)
VexoDrip.UI.ContentContainer.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Primary
VexoDrip.UI.ContentContainer.BorderSizePixel = 0
VexoDrip.UI.ContentContainer.ClipsDescendants = true
VexoDrip.UI.ContentContainer.Parent = VexoDrip.UI.MainFrame

VexoDrip.UI.Tabs = {}
VexoDrip.UI.TabContents = {}

local function CreateTab(name)
    local Tab = Instance.new("TextButton")
    Tab.Name = name .. "Tab"
    Tab.Size = UDim2.new(1, 0, 0, VexoDrip.Settings.UI.TabSize.Y)
    Tab.Position = UDim2.new(0, 0, 0, #VexoDrip.UI.Tabs * VexoDrip.Settings.UI.TabSize.Y)
    Tab.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary
    Tab.Text = name
    Tab.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    Tab.TextScaled = true
    Tab.Font = Enum.Font.RobotoMono
    Tab.BorderSizePixel = 0
    Tab.Parent = VexoDrip.UI.TabContainer

    local Content = Instance.new("ScrollingFrame")
    Content.Name = name .. "Content"
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.Position = UDim2.new(0, 0, 0, 0)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.CanvasSize = UDim2.new(1, 0, 0, 0)
    Content.ScrollBarThickness = 5
    Content.Parent = VexoDrip.UI.ContentContainer
    Content.Visible = false

    table.insert(VexoDrip.UI.Tabs, {Button = Tab, Content = Content})
    return Tab, Content
end

local function CreateSection(parent, name)
    local Section = Instance.new("Frame")
    Section.Name = name .. "Section"
    Section.Size = UDim2.new(1, -20, 0, 0)
    Section.Position = UDim2.new(0, 10, 0, parent.CanvasSize.Y.Offset)
    Section.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary
    Section.BackgroundTransparency = 0.3
    Section.BorderSizePixel = 0
    Section.Parent = parent

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = name .. "Title"
    SectionTitle.Size = UDim2.new(1, 0, 0, 30)
    SectionTitle.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent
    SectionTitle.BackgroundTransparency = 0.2
    SectionTitle.Text = name
    SectionTitle.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    SectionTitle.TextScaled = true
    SectionTitle.Font = Enum.Font.RobotoMono
    SectionTitle.BorderSizePixel = 0
    SectionTitle.Parent = Section

    local SectionContent = Instance.new("Frame")
    SectionContent.Name = name .. "Content"
    SectionContent.Size = UDim2.new(1, 0, 1, -30)
    SectionContent.Position = UDim2.new(0, 0, 0, 30)
    SectionContent.BackgroundTransparency = 1
    SectionContent.BorderSizePixel = 0
    SectionContent.Parent = Section

    local CurrentY = 0
    local function AddElement(element)
        element.Position = UDim2.new(0, 10, 0, CurrentY)
        element.Parent = SectionContent
        CurrentY += element.Size.Y.Offset + 10
        Section.Size = UDim2.new(1, -20, 0, 30 + CurrentY)
        parent.CanvasSize = UDim2.new(1, 0, 0, parent.CanvasSize.Y.Offset + Section.Size.Y.Offset + 20)
    end

    return {Frame = Section, Add = AddElement}
end

local function CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, VexoDrip.Settings.UI.ButtonSize.X, 0, VexoDrip.Settings.UI.ButtonSize.Y)
    Button.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent
    Button.Text = text
    Button.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    Button.TextScaled = true
    Button.Font = Enum.Font.RobotoMono
    Button.BorderSizePixel = 0

    Button.MouseButton1Click:Connect(callback)

    local TweenIn = TweenService:Create(Button, TweenInfo.new(VexoDrip.Settings.UI.AnimationSpeed), {BackgroundColor3 = VexoDrip.Settings.UI.Theme.Highlight})
    local TweenOut = TweenService:Create(Button, TweenInfo.new(VexoDrip.Settings.UI.AnimationSpeed), {BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent})

    Button.MouseEnter:Connect(function() TweenIn:Play() end)
    Button.MouseLeave:Connect(function() TweenOut:Play() end)

    return Button
end

local function CreateToggle(text, settingPath)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0, VexoDrip.Settings.UI.SliderSize.X + 20, 0, VexoDrip.Settings.UI.ToggleSize.Y + 10)
    ToggleFrame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, VexoDrip.Settings.UI.SliderSize.X - VexoDrip.Settings.UI.ToggleSize.X - 10, 1, 0)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    Label.TextScaled = true
    Label.Font = Enum.Font.RobotoMono
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, VexoDrip.Settings.UI.ToggleSize.X, 0, VexoDrip.Settings.UI.ToggleSize.Y)
    Toggle.Position = UDim2.new(1, -VexoDrip.Settings.UI.ToggleSize.X, 0, 0)
    Toggle.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary
    Toggle.Text = ""
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ToggleFrame

    local ToggleFill = Instance.new("Frame")
    ToggleFill.Name = "Fill"
    ToggleFill.Size = UDim2.new(0.4, 0, 0.8, 0)
    ToggleFill.Position = UDim2.new(0.1, 0, 0.1, 0)
    ToggleFill.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent
    ToggleFill.BorderSizePixel = 0
    ToggleFill.Parent = Toggle

    local function UpdateToggle()
        local Enabled = VexoDrip.Settings
        for _, part in ipairs(settingPath) do
            Enabled = Enabled[part]
        end
        if Enabled then
            TweenService:Create(ToggleFill, TweenInfo.new(VexoDrip.Settings.UI.AnimationSpeed), {Position = UDim2.new(0.5, 0, 0.1, 0), BackgroundColor3 = VexoDrip.Settings.UI.Theme.Highlight}):Play()
            TweenService:Create(Toggle, TweenInfo.new(VexoDrip.Settings.UI.AnimationSpeed), {BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary}):Play()
        else
            TweenService:Create(ToggleFill, TweenInfo.new(VexoDrip.Settings.UI.AnimationSpeed), {Position = UDim2.new(0.1, 0, 0.1, 0), BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent}):Play()
            TweenService:Create(Toggle, TweenInfo.new(VexoDrip.Settings.UI.AnimationSpeed), {BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary}):Play()
        end
    end

    UpdateToggle()

    Toggle.MouseButton1Click:Connect(function()
        local Setting = VexoDrip.Settings
        for i = 1, #settingPath - 1 do
            Setting = Setting[settingPath[i]]
        end
        Setting[settingPath[#settingPath]] = not Setting[settingPath[#settingPath]]
        UpdateToggle()
    end)

    return ToggleFrame
end

local function CreateSlider(text, settingPath, min, max, step)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0, VexoDrip.Settings.UI.SliderSize.X + 20, 0, 40)
    SliderFrame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    Label.TextScaled = true
    Label.Font = Enum.Font.RobotoMono
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(1, -50, 0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = ""
    ValueLabel.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.RobotoMono
    ValueLabel.Parent = SliderFrame

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, 0, 0, 5)
    SliderBar.Position = UDim2.new(0, 0, 1, -5)
    SliderBar.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Secondary
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame

    local SliderKnob = Instance.new("Frame")
    SliderKnob.Size = UDim2.new(0, 15, 0, 15)
    SliderKnob.Position = UDim2.new(0, 0, 1, -10)
    SliderKnob.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent
    SliderKnob.BorderSizePixel = 0
    SliderKnob.Parent = SliderBar
    SliderKnob.ZIndex = 2

    local function GetCurrentValue()
        local Value = VexoDrip.Settings
        for _, part in ipairs(settingPath) do
            Value = Value[part]
        end
        return Value
    end

    local function UpdateSlider()
        local Value = GetCurrentValue()
        local Percent = (Value - min) / (max - min)
        SliderKnob.Position = UDim2.new(Percent, -7.5, 1, -10)
        ValueLabel.Text = tostring(math.round(Value * 100) / 100)
    end

    UpdateSlider()

    local Dragging = false
    SliderKnob.MouseButton1Down:Connect(function() Dragging = true end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end end)

    RunService.RenderStepped:Connect(function()
        if Dragging then
            local MousePos = Mouse.X - SliderBar.AbsolutePosition.X
            local Percent = math.clamp(MousePos / SliderBar.AbsoluteSize.X, 0, 1)
            local NewValue = min + (Percent * (max - min))
            if step then
                NewValue = math.round(NewValue / step) * step
            end
            local Setting = VexoDrip.Settings
            for i = 1, #settingPath - 1 do
                Setting = Setting[settingPath[i]]
            end
            Setting[settingPath[#settingPath]] = NewValue
            UpdateSlider()
        end
    end)

    return SliderFrame
end

local function CreateColorPicker(text, settingPath)
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Size = UDim2.new(0, VexoDrip.Settings.UI.SliderSize.X + 20, 0, 40)
    ColorFrame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, VexoDrip.Settings.UI.SliderSize.X - 50, 1, 0)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = VexoDrip.Settings.UI.Theme.Text
    Label.TextScaled = true
    Label.Font = Enum.Font.RobotoMono
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ColorFrame

    local ColorButton = Instance.new("TextButton")
    ColorButton.Size = UDim2.new(0, 30, 0, 30)
    ColorButton.Position = UDim2.new(1, -40, 0, 5)
    ColorButton.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Accent
    ColorButton.Text = ""
    ColorButton.BorderSizePixel = 0
    ColorButton.Parent = ColorFrame

    local function UpdateColor()
        local Color = VexoDrip.Settings
        for _, part in ipairs(settingPath) do
            Color = Color[part]
        end
        ColorButton.BackgroundColor3 = Color
    end

    UpdateColor()

    ColorButton.MouseButton1Click:Connect(function()
        local ColorPicker = Instance.new("ScreenGui")
        ColorPicker.Name = "ColorPicker"
        ColorPicker.Parent = LocalPlayer.PlayerGui

        local PickerFrame = Instance.new("Frame")
        PickerFrame.Size = UDim2.new(0, 300, 0, 300)
        PickerFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
        PickerFrame.BackgroundColor3 = VexoDrip.Settings.UI.Theme.Primary
        PickerFrame.BorderSizePixel = 0
        PickerFrame.Parent = ColorPicker

        local HueBar = Instance.new("Frame")
        HueBar.Size = UDim2.new(0, 30, 1, 0)
        HueBar.Position = UDim2.new(1, -30, 0, 0)
        HueBar.BackgroundColor3 = Color3.new(1, 1, 1)
        HueBar.BorderSizePixel = 0
        HueBar.Parent = PickerFrame

        local HueGradient = Instance.new("UIGradient")
        HueGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
            ColorSequenceKeypoint.new(1/6, Color3.new(1, 1, 0)),
            ColorSequenceKeypoint.new(2/6, Color3.new(0, 1, 0)),
            ColorSequenceKeypoint.new(3/6, Color3.new(0, 1, 1)),
            ColorSequenceKeypoint.new(4/6, Color3.new(0, 0, 1)),
            ColorSequenceKeypoint.new(