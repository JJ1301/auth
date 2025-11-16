local Auth = loadstring(game:HttpGet("https://raw.githubusercontent.com/JJ1301/auth/refs/heads/main/authentification.lua"))()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local LoginFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local UsernameBox = Instance.new("TextBox")
local PasswordBox = Instance.new("TextBox")
local LoginButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local MainLabel = Instance.new("TextLabel")

ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- === LOGIN FRAME ===
LoginFrame.Size = UDim2.new(0, 340, 0, 260)
LoginFrame.Position = UDim2.new(0.5, -170, 0.5, -130)
LoginFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
LoginFrame.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = LoginFrame

UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Transparency = 0.7
UIStroke.Parent = LoginFrame

-- Title
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "LOGIN"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.Parent = LoginFrame

-- Username
UsernameBox.Size = UDim2.new(0, 300, 0, 45)
UsernameBox.Position = UDim2.new(0.5, -150, 0, 60)
UsernameBox.PlaceholderText = "Username"
UsernameBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
UsernameBox.Text = ""
UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
UsernameBox.Font = Enum.Font.Gotham
UsernameBox.TextSize = 20
UsernameBox.Parent = LoginFrame

local UserCorner = Instance.new("UICorner")
UserCorner.CornerRadius = UDim.new(0, 10)
UserCorner.Parent = UsernameBox

-- Password
PasswordBox.Size = UDim2.new(0, 300, 0, 45)
PasswordBox.Position = UDim2.new(0.5, -150, 0, 115)
PasswordBox.PlaceholderText = "Password"
PasswordBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
PasswordBox.Text = ""
PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PasswordBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.TextSize = 20
PasswordBox.Parent = LoginFrame

local PassCorner = Instance.new("UICorner")
PassCorner.CornerRadius = UDim.new(0, 10)
PassCorner.Parent = PasswordBox

-- Login Button
LoginButton.Size = UDim2.new(0, 300, 0, 45)
LoginButton.Position = UDim2.new(0.5, -150, 0, 170)
LoginButton.Text = "LOGIN"
LoginButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginButton.Font = Enum.Font.GothamBold
LoginButton.TextSize = 22
LoginButton.Parent = LoginFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = LoginButton

-- Status
StatusLabel.Size = UDim2.new(1, -40, 0, 30)
StatusLabel.Position = UDim2.new(0, 20, 1, -45)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 20
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = LoginFrame

-- === MAIN FRAME ===
MainFrame.Size = UDim2.new(0, 500, 0, 360)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(0, 255, 150)
MainStroke.Transparency = 0.6
MainStroke.Parent = MainFrame

MainLabel.Text = "Welcome Back!\nYou are now authenticated."
MainLabel.Size = UDim2.new(1, -40, 1, -40)
MainLabel.Position = UDim2.new(0, 20, 0, 20)
MainLabel.BackgroundTransparency = 1
MainLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
MainLabel.Font = Enum.Font.GothamBold
MainLabel.TextSize = 26
MainLabel.TextXAlignment = Enum.TextXAlignment.Center
MainLabel.TextYAlignment = Enum.TextYAlignment.Center
MainLabel.Parent = MainFrame

-- === TAB SYSTEM ===
local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, -40, 0, 50)
TabButtons.Position = UDim2.new(0, 20, 0, 60)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local MainTabButton = Instance.new("TextButton")
local VehicleTabButton = Instance.new("TextButton")
local TabButtonCorner = Instance.new("UICorner")

MainTabButton.Size = UDim2.new(0, 120, 1, 0)
MainTabButton.Position = UDim2.new(0, 0, 0, 0)
MainTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
MainTabButton.Text = "Main"
MainTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MainTabButton.Font = Enum.Font.GothamBold
MainTabButton.TextSize = 18
MainTabButton.Parent = TabButtons

VehicleTabButton.Size = UDim2.new(0, 120, 1, 0)
VehicleTabButton.Position = UDim2.new(0, 130, 0, 0)
VehicleTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
VehicleTabButton.Text = "Vehicle"
VehicleTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VehicleTabButton.Font = Enum.Font.GothamBold
VehicleTabButton.TextSize = 18
VehicleTabButton.Parent = TabButtons

TabButtonCorner.CornerRadius = UDim.new(0, 8)
TabButtonCorner.Parent = MainTabButton
TabButtonCorner:Clone().Parent = VehicleTabButton

-- === MAIN TAB CONTENT ===
local MainTabContent = Instance.new("Frame")
MainTabContent.Size = UDim2.new(1, -40, 1, -130)
MainTabContent.Position = UDim2.new(0, 20, 0, 110)
MainTabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainTabContent.Parent = MainFrame

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 12)
MainTabCorner.Parent = MainTabContent

local SoonLabel = Instance.new("TextLabel")
SoonLabel.Size = UDim2.new(1, 0, 1, 0)
SoonLabel.BackgroundTransparency = 1
SoonLabel.Text = "Soon..."
SoonLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
SoonLabel.Font = Enum.Font.GothamBold
SoonLabel.TextSize = 28
SoonLabel.Parent = MainTabContent

-- === VEHICLE TAB CONTENT (smaller) ===
local VehicleTabContent = Instance.new("Frame")
VehicleTabContent.Size = UDim2.new(1, -40, 1, -130)
VehicleTabContent.Position = UDim2.new(0, 20, 0, 110)
VehicleTabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
VehicleTabContent.Visible = false
VehicleTabContent.Parent = MainFrame

local VehicleTabCorner = Instance.new("UICorner")
VehicleTabCorner.CornerRadius = UDim.new(0, 12)
VehicleTabCorner.Parent = VehicleTabContent

-- Smaller Fly Controls in Vehicle Tab
local TabTitle = Instance.new("TextLabel")
TabTitle.Size = UDim2.new(1, 0, 0, 35)
TabTitle.BackgroundTransparency = 1
TabTitle.Text = "Vehicle Fly"
TabTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
TabTitle.Font = Enum.Font.GothamBold
TabTitle.TextSize = 20
TabTitle.Parent = VehicleTabContent

local FlyToggle = Instance.new("TextButton")
local FlyCorner = Instance.new("UICorner")
FlyToggle.Size = UDim2.new(0, 220, 0, 40)
FlyToggle.Position = UDim2.new(0.5, -110, 0, 50)
FlyToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
FlyToggle.Text = "Car Fly: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.TextSize = 18
FlyToggle.Parent = VehicleTabContent

FlyCorner.CornerRadius = UDim.new(0, 10)
FlyCorner.Parent = FlyToggle

-- Smaller Slider
local SliderFrame = Instance.new("Frame")
local SliderBar = Instance.new("Frame")
local SliderKnob = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local BarUICorner = Instance.new("UICorner")
local KnobUICorner = Instance.new("UICorner")

SliderFrame.Size = UDim2.new(0, 220, 0, 45)
SliderFrame.Position = UDim2.new(0.5, -110, 0, 105)
SliderFrame.BackgroundTransparency = 1
SliderFrame.Parent = VehicleTabContent

SliderBar.Size = UDim2.new(1, 0, 0, 6)
SliderBar.Position = UDim2.new(0, 0, 0.5, -3)
SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
SliderBar.Parent = SliderFrame

BarUICorner.CornerRadius = UDim.new(0, 3)
BarUICorner.Parent = SliderBar

SliderKnob.Size = UDim2.new(0, 20, 0, 20)
SliderKnob.Position = UDim2.new(0, 0, 0.5, -10)
SliderKnob.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
SliderKnob.Text = ""
SliderKnob.AutoButtonColor = false
SliderKnob.Parent = SliderFrame

KnobUICorner.CornerRadius = UDim.new(1, 0)
KnobUICorner.Parent = SliderKnob

SpeedLabel.Size = UDim2.new(1, 0, 0, 18)
SpeedLabel.Position = UDim2.new(0, 0, 1, 3)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 50"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 14
SpeedLabel.Parent = SliderFrame

-- Enter Vehicle Button (smaller)
local EnterVehicleButton = Instance.new("TextButton")
local EnterCorner = Instance.new("UICorner")
EnterVehicleButton.Size = UDim2.new(0, 180, 0, 35)  -- Smaller
EnterVehicleButton.Position = UDim2.new(0.5, -90, 0, 180)  -- Centered
EnterVehicleButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
EnterVehicleButton.Text = "Enter Vehicle"
EnterVehicleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterVehicleButton.Font = Enum.Font.GothamBold
EnterVehicleButton.TextSize = 16
EnterVehicleButton.Parent = VehicleTabContent

EnterCorner.CornerRadius = UDim.new(0, 10)
EnterCorner.Parent = EnterVehicleButton

-- === FLY LOGIC ===
local flightEnabled = false
local flightSpeed = 50
local flyConnection = nil
local minSpeed = 1
local maxSpeed = 100
local dragging = false

local function getActualSpeed(sliderValue)
    local normalized = (sliderValue - minSpeed) / (maxSpeed - minSpeed)
    return 0.1 + (normalized ^ 3) * 1.9  -- Ultra-slow: 0.1 to 2 studs/sec
end

local function updateSpeedDisplay()
    SpeedLabel.Text = "Speed: " .. math.floor(flightSpeed)
end

SliderKnob.MouseButton1Down:Connect(function()
    dragging = true
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mousePos = UIS:GetMouseLocation()
        local relativeX = math.clamp((mousePos.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
        SliderKnob.Position = UDim2.new(relativeX, -10, 0.5, -10)
        flightSpeed = math.floor(minSpeed + (maxSpeed - minSpeed) * relativeX)
        updateSpeedDisplay()
    end
end)

local function enableFly()
    if flyConnection then return end
    flightEnabled = true
    FlyToggle.Text = "Car Fly: ON"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 80)

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flightEnabled or not player.Character then return end
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if not humanoid or not humanoid.Sit then return end
        local SeatPart = humanoid.SeatPart
        if not SeatPart or SeatPart.Name ~= "DriveSeat" then return end
        local Vehicle = SeatPart.Parent
        if not Vehicle then return end
        if not Vehicle.PrimaryPart then Vehicle.PrimaryPart = SeatPart end

        local PrimaryPartCFrame = Vehicle:GetPrimaryPartCFrame()
        local cam = camera.CFrame
        local actualSpeed = getActualSpeed(flightSpeed)

        local moveX = ((UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0)) * actualSpeed
        local moveZ = ((UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0)) * actualSpeed
        local moveY = ((UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0)) * actualSpeed

        Vehicle:SetPrimaryPartCFrame(
            CFrame.new(PrimaryPartCFrame.Position, PrimaryPartCFrame.Position + cam.LookVector) *
            CFrame.new(moveX, moveY, moveZ)
        )

        SeatPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        SeatPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end)
end

local function disableFly()
    flightEnabled = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    FlyToggle.Text = "Car Fly: OFF"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
end

FlyToggle.MouseButton1Click:Connect(function()
    if flightEnabled then disableFly() else enableFly() end
end)

-- Enter Vehicle
EnterVehicleButton.MouseButton1Click:Connect(function()
    pcall(function()
        local vehicle = game.Workspace.Vehicles:FindFirstChild(player.Name)
        if vehicle and vehicle:FindFirstChild("DriveSeat") and player.Character and player.Character:FindFirstChild("Humanoid") then
            vehicle.DriveSeat:Sit(player.Character.Humanoid)
        end
    end)
end)

-- Initialize Slider
local initRelative = (50 - minSpeed) / (maxSpeed - minSpeed)
SliderKnob.Position = UDim2.new(initRelative, -10, 0.5, -10)
updateSpeedDisplay()

-- === TAB SWITCHING ===
local function showMainTab()
    MainTabContent.Visible = true
    VehicleTabContent.Visible = false
    MainTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    VehicleTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MainTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    VehicleTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end

local function showVehicleTab()
    MainTabContent.Visible = false
    VehicleTabContent.Visible = true
    MainTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    VehicleTabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    MainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    VehicleTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
end

MainTabButton.MouseButton1Click:Connect(showMainTab)
VehicleTabButton.MouseButton1Click:Connect(showVehicleTab)
showMainTab()

-- === LOGIN LOGIC ===
local function clearStatus(delay)
    task.wait(delay or 2.5)
    if StatusLabel.Text ~= "Successfully logged in!" then
        StatusLabel.Text = ""
    end
end

LoginButton.MouseButton1Click:Connect(function()
    local username = UsernameBox.Text
    local password = PasswordBox.Text
    if username == "" or password == "" then
        StatusLabel.Text = "Fill in all fields!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.spawn(clearStatus, 2.5)
        return
    end
    StatusLabel.Text = "Loading..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    task.spawn(function()
        local success, valid = pcall(function()
            return Auth:Check(username, password)
        end)
        if success and valid then
            StatusLabel.Text = "Successfully logged in!"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
            task.wait(2)
            TweenService:Create(LoginFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            TweenService:Create(UIStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
            task.wait(0.4)
            LoginFrame.Visible = false
            MainFrame.Visible = true
            MainFrame.BackgroundTransparency = 1
            TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        else
            StatusLabel.Text = "Wrong User or Password"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            task.spawn(clearStatus, 2.5)
        end
    end)
end)

-- Cleanup
player.CharacterAdded:Connect(function()
    task.wait(1)
    disableFly()
end)
