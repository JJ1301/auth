local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- YOUR BACKEND URL
local LOGIN_URL = "https://function-bun-production-c7eb.up.railway.app/login"

-- Force enable HTTP
if not HttpService.HttpEnabled then
    HttpService.HttpEnabled = true
end

local request = request or http_request or (syn and syn.request)
if not request then
    error("Your executor doesn't support HTTP requests!")
end

local function ExecutorPost(url, body)
    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = body
        })
    end)
    if not success or not response.Success then
        return false, response.StatusMessage or "Request failed"
    end
    return true, response.Body
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Login Frame
local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 340, 0, 260)
LoginFrame.Position = UDim2.new(0.5, -170, 0.5, -130)
LoginFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
LoginFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = LoginFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Transparency = 0.7
UIStroke.Parent = LoginFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "LOGIN"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.Parent = LoginFrame

-- Username Box - FIXED: always shows "Username"
local UsernameBox = Instance.new("TextBox")
UsernameBox.Size = UDim2.new(0, 300, 0, 45)
UsernameBox.Position = UDim2.new(0.5, -150, 0, 60)
UsernameBox.PlaceholderText = "Username"
UsernameBox.Text = ""                              -- Must be empty
UsernameBox.ClearTextOnFocus = false             -- This fixes the issue
UsernameBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
UsernameBox.TextColor3 = Color3.new(1,1,1)
UsernameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
UsernameBox.Font = Enum.Font.Gotham
UsernameBox.TextSize = 20
UsernameBox.TextXAlignment = Enum.TextXAlignment.Left
UsernameBox.Parent = LoginFrame
Instance.new("UICorner", UsernameBox).CornerRadius = UDim.new(0, 10)
Instance.new("UIPadding", UsernameBox).PaddingLeft = UDim.new(0, 12)

-- Password Box - FIXED: always shows "Password"
local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(0, 300, 0, 45)
PasswordBox.Position = UDim2.new(0.5, -150, 0, 115)
PasswordBox.PlaceholderText = "Password"
PasswordBox.Text = ""                              -- Must be empty
PasswordBox.ClearTextOnFocus = false               -- This fixes the issue
PasswordBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
PasswordBox.TextColor3 = Color3.new(1,1,1)
PasswordBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.TextSize = 20
PasswordBox.TextXAlignment = Enum.TextXAlignment.Left
PasswordBox.Parent = LoginFrame
Instance.new("UICorner", PasswordBox).CornerRadius = UDim.new(0, 10)
Instance.new("UIPadding", PasswordBox).PaddingLeft = UDim.new(0, 12)

local LoginButton = Instance.new("TextButton")
LoginButton.Size = UDim2.new(0, 300, 0, 45)
LoginButton.Position = UDim2.new(0.5, -150, 0, 170)
LoginButton.Text = "LOGIN"
LoginButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoginButton.TextColor3 = Color3.new(1,1,1)
LoginButton.Font = Enum.Font.GothamBold
LoginButton.TextSize = 22
LoginButton.Parent = LoginFrame
Instance.new("UICorner", LoginButton).CornerRadius = UDim.new(0, 10)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 30)
StatusLabel.Position = UDim2.new(0, 20, 1, -45)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 20
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = LoginFrame

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 480)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(0, 255, 150)
MainStroke.Transparency = 0.6
MainStroke.Parent = MainFrame

local MainLabel = Instance.new("TextLabel")
MainLabel.Size = UDim2.new(1, -40, 0, 80)
MainLabel.Position = UDim2.new(0, 20, 0, 20)
MainLabel.BackgroundTransparency = 1
MainLabel.Text = "Welcome Back!\nYou are now authenticated."
MainLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
MainLabel.Font = Enum.Font.GothamBold
MainLabel.TextSize = 26
MainLabel.TextXAlignment = Enum.TextXAlignment.Center
MainLabel.TextYAlignment = Enum.TextYAlignment.Center
MainLabel.Parent = MainFrame

-- GROUND STONES TOGGLE
local GroundStonesToggle = Instance.new("TextButton")
GroundStonesToggle.Size = UDim2.new(0, 340, 0, 75)
GroundStonesToggle.Position = UDim2.new(0.5, -170, 0, 120)
GroundStonesToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
GroundStonesToggle.Text = "GROUND STONES: OFF"
GroundStonesToggle.TextColor3 = Color3.new(1,1,1)
GroundStonesToggle.Font = Enum.Font.GothamBold
GroundStonesToggle.TextSize = 30
GroundStonesToggle.Parent = MainFrame
Instance.new("UICorner", GroundStonesToggle).CornerRadius = UDim.new(0, 16)
local GSStroke = Instance.new("UIStroke")
GSStroke.Thickness = 4
GSStroke.Color = Color3.fromRGB(100, 100, 100)
GSStroke.Parent = GroundStonesToggle

-- WALK FLING TOGGLE (now GREEN when ON, no notification)
local WalkFlingToggle = Instance.new("TextButton")
WalkFlingToggle.Size = UDim2.new(0, 340, 0, 75)
WalkFlingToggle.Position = UDim2.new(0.5, -170, 0, 210)
WalkFlingToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
WalkFlingToggle.Text = "WALK FLING: OFF"
WalkFlingToggle.TextColor3 = Color3.new(1,1,1)
WalkFlingToggle.Font = Enum.Font.GothamBold
WalkFlingToggle.TextSize = 30
WalkFlingToggle.Parent = MainFrame
Instance.new("UICorner", WalkFlingToggle).CornerRadius = UDim.new(0, 16)
local WFStroke = Instance.new("UIStroke")
WFStroke.Thickness = 4
WFStroke.Color = Color3.fromRGB(100, 100, 100)
WFStroke.Parent = WalkFlingToggle

-- WALK FLING LOGIC (exactly like yours)
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local walkFlingActive = false
local walkFlingConnection = nil
local flingTouchConnection = nil

localPlayer.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
end)

local function fling(target)
    for _, part in ipairs(target:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Velocity = Vector3.new(math.random(-100, 100), 120, math.random(-100, 100))
            part.RotVelocity = Vector3.new(math.random(-80, 80), math.random(-80, 80), math.random(-80, 80))
        end
    end
end

local function startWalkFling()
    if walkFlingConnection then return end
    flingTouchConnection = humanoidRootPart.Touched:Connect(function(hit)
        if not walkFlingActive then return end
        local char = hit.Parent
        if char and char ~= character and Players:GetPlayerFromCharacter(char) then
            fling(char)
        end
    end)

    walkFlingConnection = RunService.Heartbeat:Connect(function()
        if not walkFlingActive then return end
        if not humanoidRootPart or not humanoidRootPart.Parent then return end
        local oldVel = humanoidRootPart.Velocity
        humanoidRootPart.Velocity = oldVel * 10000 + Vector3.new(0, 10000, 0)
        RunService.RenderStepped:Wait()
        humanoidRootPart.Velocity = oldVel
        RunService.Stepped:Wait()
        humanoidRootPart.Velocity = oldVel + Vector3.new(0, 0.1, 0)
    end)
end

local function stopWalkFling()
    walkFlingActive = false
    if walkFlingConnection then walkFlingConnection:Disconnect() walkFlingConnection = nil end
    if flingTouchConnection then flingTouchConnection:Disconnect() flingTouchConnection = nil end
end

-- GROUND STONES LOGIC
local groundStonesEnabled = false
local gsConnection = nil

local function startGroundStones()
    if gsConnection then return end
    gsConnection = RunService.Heartbeat:Connect(function()
        if not groundStonesEnabled then return end
        pcall(function()
            local args = {{ Dash = Enum.KeyCode.D, Key = Enum.KeyCode.Q, Goal = "KeyPress" }}
            game:GetService("Players").LocalPlayer.Character:WaitForChild("Communicate"):FireServer(unpack(args))
        end)
    end)
end

local function stopGroundStones()
    if gsConnection then gsConnection:Disconnect() gsConnection = nil end
end

-- TOGGLE CONNECTIONS
GroundStonesToggle.MouseButton1Click:Connect(function()
    groundStonesEnabled = not groundStonesEnabled
    if groundStonesEnabled then
        GroundStonesToggle.Text = "GROUND STONES: ON"
        GroundStonesToggle.BackgroundColor3 = Color3.fromRGB(0, 220, 110)
        GSStroke.Color = Color3.fromRGB(0, 255, 150)
        startGroundStones()
    else
        GroundStonesToggle.Text = "GROUND STONES: OFF"
        GroundStonesToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        GSStroke.Color = Color3.fromRGB(100, 100, 100)
        stopGroundStones()
    end
end)

-- WALK FLING TOGGLE - GREEN when ON, NO notification
WalkFlingToggle.MouseButton1Click:Connect(function()
    walkFlingActive = not walkFlingActive
    if walkFlingActive then
        WalkFlingToggle.Text = "WALK FLING: ON"
        WalkFlingToggle.BackgroundColor3 = Color3.fromRGB(0, 220, 110)
        WFStroke.Color = Color3.fromRGB(0, 255, 150)
        startWalkFling()
    else
        WalkFlingToggle.Text = "WALK FLING: OFF"
        WalkFlingToggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        WFStroke.Color = Color3.fromRGB(100, 100, 100)
        stopWalkFling()
    end
end)

-- Login Logic
local function clearStatus()
    task.wait(3)
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
        task.spawn(clearStatus)
        return
    end

    StatusLabel.Text = "Authenticating..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)

    task.spawn(function()
        local body = HttpService:JSONEncode({username = username, password = password})
        local success, result = ExecutorPost(LOGIN_URL, body)
        if success then
            local data = HttpService:JSONDecode(result)
            if data.sessionToken then
                StatusLabel.Text = "Successfully logged in!"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
                task.wait(1.5)
                TweenService:Create(LoginFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
                TweenService:Create(UIStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
                task.wait(0.5)
                LoginFrame.Visible = false
                MainFrame.Visible = true
                MainFrame.BackgroundTransparency = 1
                TweenService:Create(MainFrame, TweenInfo.new(0.6), {BackgroundTransparency = 0}):Play()
                getgenv().MY_SESSION_TOKEN = data.sessionToken
                print("Logged in!")
            else
                StatusLabel.Text = "Wrong credentials"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                task.spawn(clearStatus)
            end
        else
            StatusLabel.Text = "Server error"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.spawn(clearStatus)
        end
    end)
end)
