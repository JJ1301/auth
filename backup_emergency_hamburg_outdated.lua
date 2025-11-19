local Auth = loadstring(game:HttpGet("https://raw.githubusercontent.com/JJ1301/auth/refs/heads/main/authentification.lua"))()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- ==================== LOGIN (unverändert) ====================
local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 360, 0, 280)
LoginFrame.Position = UDim2.new(0.5, -180, 0.5, -140)
LoginFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LoginFrame.Active = true
LoginFrame.Draggable = true
LoginFrame.Parent = ScreenGui
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 16)
local LoginStroke = Instance.new("UIStroke", LoginFrame)
LoginStroke.Thickness = 2
LoginStroke.Color = Color3.fromRGB(0, 170, 255)

local Title = Instance.new("TextLabel", LoginFrame)
Title.Size = UDim2.new(1,0,0,48) Title.BackgroundTransparency = 1
Title.Text = "LOGIN" Title.TextColor3 = Color3.fromRGB(0,220,255) Title.Font = Enum.Font.GothamBold Title.TextSize = 26

local UsernameBox = Instance.new("TextBox", LoginFrame)
UsernameBox.Size = UDim2.new(0,300,0,42) UsernameBox.Position = UDim2.new(0.5,-150,0,64)
UsernameBox.PlaceholderText = "Username" UsernameBox.PlaceholderColor3 = Color3.fromRGB(170,170,170)
UsernameBox.Text = "" UsernameBox.ClearTextOnFocus = true
UsernameBox.BackgroundColor3 = Color3.fromRGB(45,45,55) UsernameBox.TextColor3 = Color3.fromRGB(255,255,255)
UsernameBox.Font = Enum.Font.Gotham UsernameBox.TextSize = 18
Instance.new("UICorner", UsernameBox).CornerRadius = UDim.new(0,10)

local PasswordBox = Instance.new("TextBox", LoginFrame)
PasswordBox.Size = UDim2.new(0,300,0,42) PasswordBox.Position = UDim2.new(0.5,-150,0,116)
PasswordBox.PlaceholderText = "Password" PasswordBox.PlaceholderColor3 = Color3.fromRGB(170,170,170)
PasswordBox.Text = "" PasswordBox.ClearTextOnFocus = true
PasswordBox.BackgroundColor3 = Color3.fromRGB(45,45,55) PasswordBox.TextColor3 = Color3.fromRGB(255,255,255)
PasswordBox.Font = Enum.Font.Gotham PasswordBox.TextSize = 18
Instance.new("UICorner", PasswordBox).CornerRadius = UDim.new(0,10)

local LoginButton = Instance.new("TextButton", LoginFrame)
LoginButton.Size = UDim2.new(0,300,0,42) LoginButton.Position = UDim2.new(0.5,-150,0,168)
LoginButton.Text = "LOGIN" LoginButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
LoginButton.TextColor3 = Color3.fromRGB(255,255,255) LoginButton.Font = Enum.Font.GothamBold LoginButton.TextSize = 20
Instance.new("UICorner", LoginButton).CornerRadius = UDim.new(0,10)

local StatusLabel = Instance.new("TextLabel", LoginFrame)
StatusLabel.Size = UDim2.new(1,-40,0,26) StatusLabel.Position = UDim2.new(0,20,1,-36)
StatusLabel.BackgroundTransparency = 1 StatusLabel.Text = "" StatusLabel.TextColor3 = Color3.fromRGB(255,255,0)
StatusLabel.Font = Enum.Font.GothamBold StatusLabel.TextSize = 17

-- ==================== MAIN GUI ====================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 560, 0, 460)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
MainFrame.Visible = false MainFrame.Active = true MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,20)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2.5 MainStroke.Color = Color3.fromRGB(0,255,150) MainStroke.Transparency = 0.5

-- Tabs
local TabButtons = Instance.new("Frame", MainFrame)
TabButtons.Size = UDim2.new(1,-50,0,46) TabButtons.Position = UDim2.new(0,25,0,70) TabButtons.BackgroundTransparency = 1

local MainTabButton = Instance.new("TextButton", TabButtons)
MainTabButton.Size = UDim2.new(0,110,1,0) MainTabButton.BackgroundColor3 = Color3.fromRGB(45,45,55)
MainTabButton.Text = "Main" MainTabButton.TextColor3 = Color3.fromRGB(200,200,200) MainTabButton.Font = Enum.Font.GothamBold MainTabButton.TextSize = 17
Instance.new("UICorner", MainTabButton).CornerRadius = UDim.new(0,9)

local VehicleTabButton = Instance.new("TextButton", TabButtons)
VehicleTabButton.Size = UDim2.new(0,110,1,0) VehicleTabButton.Position = UDim2.new(0,120,0,0)
VehicleTabButton.BackgroundColor3 = Color3.fromRGB(35,35,45) VehicleTabButton.Text = "Vehicle"
VehicleTabButton.TextColor3 = Color3.fromRGB(255,255,255) VehicleTabButton.Font = Enum.Font.GothamBold VehicleTabButton.TextSize = 17
Instance.new("UICorner", VehicleTabButton).CornerRadius = UDim.new(0,9)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1,-50,1,-140) ContentFrame.Position = UDim2.new(0,25,0,126)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35,35,45) ContentFrame.ClipsDescendants = true
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0,14)

-- Main Tab
local MainTabContent = Instance.new("Frame", ContentFrame)
MainTabContent.Size = UDim2.new(1,0,1,0) MainTabContent.BackgroundTransparency = 1
local SoonLabel = Instance.new("TextLabel", MainTabContent)
SoonLabel.Size = UDim2.new(1,0,1,0) SoonLabel.BackgroundTransparency = 1
SoonLabel.Text = "Soon..." SoonLabel.TextColor3 = Color3.fromRGB(170,170,170) SoonLabel.Font = Enum.Font.GothamBold SoonLabel.TextSize = 36

-- ==================== VEHICLE TAB – CLEAN & OHNE TITEL ====================
local VehicleTabContent = Instance.new("Frame", ContentFrame)
VehicleTabContent.Size = UDim2.new(1,0,1,0) VehicleTabContent.BackgroundTransparency = 1 VehicleTabContent.Visible = false

-- Titel komplett entfernt → mehr Platz, cleaner Look

-- Vehicle Fly Toggle
local FlyToggle = Instance.new("TextButton", VehicleTabContent)
FlyToggle.Size = UDim2.new(0, 210, 0, 38)
FlyToggle.Position = UDim2.new(0.5, -105, 0, 50)   -- höher gerückt
FlyToggle.BackgroundColor3 = Color3.fromRGB(45,45,55)
FlyToggle.Text = "Vehicle Fly: OFF"
FlyToggle.TextColor3 = Color3.fromRGB(200,200,200)
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.TextSize = 17
Instance.new("UICorner", FlyToggle).CornerRadius = UDim.new(0,11)

-- Speed Slider – jetzt ohne Box, nur Leiste + Knopf
local SliderBar = Instance.new("Frame", VehicleTabContent)
SliderBar.Size = UDim2.new(0, 240, 0, 6)
SliderBar.Position = UDim2.new(0.5, -120, 0, 110)
SliderBar.BackgroundColor3 = Color3.fromRGB(60,60,70)
SliderBar.BorderSizePixel = 0
Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(0,3)

local SliderKnob = Instance.new("TextButton", VehicleTabContent)
SliderKnob.Size = UDim2.new(0, 24, 0, 24)
SliderKnob.Position = UDim2.new(0.5, -12, 0, 99)   -- zentriert über der Leiste
SliderKnob.BackgroundColor3 = Color3.fromRGB(0,220,120)
SliderKnob.Text = ""
SliderKnob.ZIndex = 2
Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1,0)

local SpeedLabel = Instance.new("TextLabel", VehicleTabContent)
SpeedLabel.Size = UDim2.new(0, 240, 0, 20)
SpeedLabel.Position = UDim2.new(0.5, -120, 0, 122)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 50"
SpeedLabel.TextColor3 = Color3.fromRGB(220,220,220)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 15

-- Enter Vehicle
local EnterVehicleButton = Instance.new("TextButton", VehicleTabContent)
EnterVehicleButton.Size = UDim2.new(0, 180, 0, 38)
EnterVehicleButton.Position = UDim2.new(0.5, -90, 0, 170)
EnterVehicleButton.BackgroundColor3 = Color3.fromRGB(0,140,255)
EnterVehicleButton.Text = "Enter Vehicle"
EnterVehicleButton.TextColor3 = Color3.fromRGB(255,255,255)
EnterVehicleButton.Font = Enum.Font.GothamBold
EnterVehicleButton.TextSize = 16
Instance.new("UICorner", EnterVehicleButton).CornerRadius = UDim.new(0,11)

-- Bring Vehicle
local BringVehicleButton = Instance.new("TextButton", VehicleTabContent)
BringVehicleButton.Size = UDim2.new(0, 180, 0, 52)
BringVehicleButton.Position = UDim2.new(0.5, -90, 0, 220)
BringVehicleButton.BackgroundColor3 = Color3.fromRGB(255,80,80)
BringVehicleButton.Text = "Bring Vehicle\n(Don't use if far away)"
BringVehicleButton.TextColor3 = Color3.fromRGB(255,255,255)
BringVehicleButton.Font = Enum.Font.GothamBold
BringVehicleButton.TextSize = 14
BringVehicleButton.TextWrapped = true
Instance.new("UICorner", BringVehicleButton).CornerRadius = UDim.new(0,11)

-- ==================== LOGIC ====================
local flightEnabled = false
local flightSpeed = 50
local flyConnection = nil
local dragging = false

local function updateSpeedDisplay()
    SpeedLabel.Text = "Speed: " .. math.floor(flightSpeed)
end

SliderKnob.MouseButton1Down:Connect(function() dragging = true end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local relX = math.clamp((UIS:GetMouseLocation().X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderKnob.Position = UDim2.new(0, SliderBar.AbsolutePosition.X + relX * SliderBar.AbsoluteSize.X - 12, 0, 99)
        flightSpeed = math.floor(1 + 99 * relX)
        updateSpeedDisplay()
    end
end)

local function enableFly()
    if flyConnection then return end
    flightEnabled = true
    FlyToggle.Text = "Vehicle Fly: ON"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(0,180,80)
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flightEnabled or not player.Character or not player.Character:FindFirstChild("Humanoid") or not player.Character.Humanoid.Sit then return end
        local seat = player.Character.Humanoid.SeatPart
        if not seat or seat.Name ~= "DriveSeat" then return end
        local vehicle = seat.Parent
        if not vehicle then return end
        if not vehicle.PrimaryPart then vehicle.PrimaryPart = seat end

        local speed = 0.1 + (((flightSpeed-1)/99)^3)*1.9
        local cam = camera.CFrame
        local move = Vector3.new(
            (UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
            (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0),
            (UIS:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
        ) * speed

        vehicle:SetPrimaryPartCFrame(CFrame.new(vehicle:GetPrimaryPartCFrame().Position, vehicle:GetPrimaryPartCFrame().Position + cam.LookVector) * CFrame.new(move))
        seat.AssemblyLinearVelocity = Vector3.new(0,0,0)
        seat.AssemblyAngularVelocity = Vector3.new(0,0,0)
    end)
end

local function disableFly()
    flightEnabled = false
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    FlyToggle.Text = "Vehicle Fly: OFF"
    FlyToggle.BackgroundColor3 = Color3.fromRGB(45,45,55)
end

FlyToggle.MouseButton1Click:Connect(function() if flightEnabled then disableFly() else enableFly() end end)

EnterVehicleButton.MouseButton1Click:Connect(function()
    pcall(function()
        local v = workspace.Vehicles:FindFirstChild(player.Name)
        if v and v:FindFirstChild("DriveSeat") then v.DriveSeat:Sit(player.Character.Humanoid) end
    end)
end)

BringVehicleButton.MouseButton1Click:Connect(function()
    if BringVehicleButton.Text:find("Bringing") then return end
    BringVehicleButton.Text = "Bringing..."
    BringVehicleButton.BackgroundColor3 = Color3.fromRGB(255,180,80)
    pcall(function()
        local oldpos = player.Character:GetPivot().Position
        task.wait(0.2)
        local vehicle = workspace.Vehicles:FindFirstChild(player.Name)
        if not vehicle then
            BringVehicleButton.Text = "Bring Vehicle\n(Don't use if far away)"
            BringVehicleButton.BackgroundColor3 = Color3.fromRGB(255,80,80)
            return
        end
        vehicle.PrimaryPart = vehicle.PrimaryPart or vehicle:FindFirstChild("DriveSeat", true)
        if vehicle:FindFirstChild("DriveSeat") then vehicle.DriveSeat:Sit(player.Character.Humanoid) end
        task.wait(0.2)
        local dist = (vehicle.PrimaryPart.Position - oldpos).Magnitude
        local dur = math.clamp(dist/125, 0.3, 6)

        local val = Instance.new("CFrameValue") val.Value = vehicle:GetPivot()
        val.Changed:Connect(function(cf)
            vehicle:PivotTo(cf)
            if vehicle:FindFirstChild("DriveSeat") then
                vehicle.DriveSeat.AssemblyLinearVelocity = Vector3.new(0,0,0)
                vehicle.DriveSeat.AssemblyAngularVelocity = Vector3.new(0,0,0)
            end
        end)
        local tween = TweenService:Create(val, TweenInfo.new(dur, Enum.EasingStyle.Linear), {Value = CFrame.new(oldpos + Vector3.new(0,5,-8))})
        tween:Play() tween.Completed:Wait() val:Destroy()
    end)
    BringVehicleButton.Text = "Bring Vehicle\n(Don't use if far away)"
    BringVehicleButton.BackgroundColor3 = Color3.fromRGB(255,80,80)
end)

-- Init
SliderKnob.Position = UDim2.new(0.5, -12, 0, 99)
updateSpeedDisplay()

-- Tab switching
local function showMainTab() MainTabContent.Visible = true VehicleTabContent.Visible = false
    MainTabButton.BackgroundColor3 = Color3.fromRGB(45,45,55) VehicleTabButton.BackgroundColor3 = Color3.fromRGB(35,35,45)
end
local function showVehicleTab() MainTabContent.Visible = false VehicleTabContent.Visible = true
    MainTabButton.BackgroundColor3 = Color3.fromRGB(35,35,45) VehicleTabButton.BackgroundColor3 = Color3.fromRGB(45,45,55)
end
MainTabButton.MouseButton1Click:Connect(showMainTab)
VehicleTabButton.MouseButton1Click:Connect(showVehicleTab)
showMainTab()

-- Login Logic
local function clearStatus(t) task.wait(t or 2.5) if StatusLabel.Text ~= "Successfully logged in!" then StatusLabel.Text = "" end end
LoginButton.MouseButton1Click:Connect(function()
    local u,p = UsernameBox.Text, PasswordBox.Text
    if u == "" or p == "" then StatusLabel.Text = "Fill in all fields!" StatusLabel.TextColor3 = Color3.fromRGB(255,100,100) task.spawn(clearStatus,2.5) return end
    StatusLabel.Text = "Loading..." StatusLabel.TextColor3 = Color3.fromRGB(255,255,0)
    task.spawn(function()
        local ok,v = pcall(function() return Auth:Check(u,p) end)
        if ok and v then
            StatusLabel.Text = "Successfully logged in!" StatusLabel.TextColor3 = Color3.fromRGB(0,255,100)
            task.wait(1.8)
            TweenService:Create(LoginFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            TweenService:Create(LoginStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
            task.wait(0.4) LoginFrame.Visible = false
            MainFrame.Visible = true MainFrame.BackgroundTransparency = 1
            TweenService:Create(MainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        else
            StatusLabel.Text = "Wrong User or Password" StatusLabel.TextColor3 = Color3.fromRGB(255,80,80) task.spawn(clearStatus,2.5)
        end
    end)
end)

player.CharacterAdded:Connect(function() task.wait(1) disableFly() end)
