--============================================================--
-- EXTORT FLY + ANTI-FLING | FINAL VERSION – ALLES FIX
--============================================================--

local HttpService   = game:GetService("HttpService")
local Players       = game:GetService("Players")
local TweenService  = game:GetService("TweenService")
local UIS           = game:GetService("UserInputService")
local RunService    = game:GetService("RunService")

local player        = Players.LocalPlayer
local playerGui     = player:WaitForChild("PlayerGui")

--========================== AUTH CONFIG ==========================--
local LOGIN_URL = "https://function-bun-production-c7eb.up.railway.app/login"

if not HttpService.HttpEnabled then HttpService.HttpEnabled = true end
local request = request or http_request or (syn and syn.request)
if not request then error("Your executor does not support HTTP requests!") end

local function ExecutorPost(url, body)
    local success, resp = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = body
        })
    end)
    if not success or not resp.Success then
        return false, resp.StatusMessage or resp.StatusCode or "Unknown Error"
    end
    return true, resp.Body
end

--========================== LOGIN GUI ==========================--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 340, 0, 280)
LoginFrame.Position = UDim2.new(0.5, -170, 0.5, -140)
LoginFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
LoginFrame.Parent = ScreenGui
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 16)

local Stroke = Instance.new("UIStroke", LoginFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Transparency = 0.7

local Title = Instance.new("TextLabel", LoginFrame)
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "Extort Login"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32

local UsernameBox = Instance.new("TextBox", LoginFrame)
UsernameBox.Size = UDim2.new(0,300,0,45)
UsernameBox.Position = UDim2.new(0.5,-150,0,70)
UsernameBox.Text = "Username"
UsernameBox.BackgroundColor3 = Color3.fromRGB(45,45,55)
UsernameBox.TextColor3 = Color3.fromRGB(180,180,180)
UsernameBox.Font = Enum.Font.Gotham
UsernameBox.TextSize = 20
UsernameBox.TextXAlignment = Enum.TextXAlignment.Center
UsernameBox.ClearTextOnFocus = false
Instance.new("UICorner", UsernameBox).CornerRadius = UDim.new(0,10)

local PasswordBox = Instance.new("TextBox", LoginFrame)
PasswordBox.Size = UDim2.new(0,300,0,45)
PasswordBox.Position = UDim2.new(0.5,-150,0,125)
PasswordBox.Text = "Password"
PasswordBox.BackgroundColor3 = Color3.fromRGB(45,45,55)
PasswordBox.TextColor3 = Color3.fromRGB(180,180,180)
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.TextSize = 20
PasswordBox.TextXAlignment = Enum.TextXAlignment.Center
PasswordBox.ClearTextOnFocus = false
Instance.new("UICorner", PasswordBox).CornerRadius = UDim.new(0,10)

local LoginButton = Instance.new("TextButton", LoginFrame)
LoginButton.Size = UDim2.new(0,300,0,45)
LoginButton.Position = UDim2.new(0.5,-150,0,180)
LoginButton.Text = "LOGIN"
LoginButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
LoginButton.TextColor3 = Color3.new(1,1,1)
LoginButton.Font = Enum.Font.GothamBold
LoginButton.TextSize = 22
Instance.new("UICorner", LoginButton).CornerRadius = UDim.new(0,10)

local StatusLabel = Instance.new("TextLabel", LoginFrame)
StatusLabel.Size = UDim2.new(1,-40,0,40)
StatusLabel.Position = UDim2.new(0,20,0,235)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255,255,0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 22
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

local function setupSmartBox(box, placeholder)
    box.Focused:Connect(function()
        if box.Text == placeholder then
            box.Text = ""
            box.TextColor3 = Color3.new(1,1,1)
        end
    end)
    box.FocusLost:Connect(function()
        if box.Text == "" then
            box.Text = placeholder
            box.TextColor3 = Color3.fromRGB(180,180,180)
        end
    end)
end
setupSmartBox(UsernameBox, "Username")
setupSmartBox(PasswordBox, "Password")

--========================== MAIN GUI ==========================--
local function LoadMainGUI()
    ScreenGui:Destroy()

    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "ExtortGUI"
    mainGui.ResetOnSpawn = false
    mainGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 420, 0, 240)
    mainFrame.Position = UDim2.new(0.03, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Parent = mainGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

    -- DragHandle (nur oben ziehen – Slider bleibt frei!)
    local dragHandle = Instance.new("Frame")
    dragHandle.Size = UDim2.new(1, 0, 0, 50)
    dragHandle.BackgroundTransparency = 1
    dragHandle.Name = "DragHandle"
    dragHandle.Parent = mainFrame

    local dragging = false
    dragHandle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local startPos = mainFrame.Position
            local startMouse = inp.Position
            local conn
            conn = UIS.InputChanged:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                    local delta = i.Position - startMouse
                    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    conn:Disconnect()
                end
            end)
        end
    end)

    -- Tabs
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 110, 1, 0)
    tabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    tabContainer.Parent = mainFrame
    Instance.new("UICorner", tabContainer).CornerRadius = UDim.new(0, 14)
    local tabLayout = Instance.new("UIListLayout", tabContainer)
    tabLayout.Padding = UDim.new(0, 4)

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -110, 1, 0)
    contentFrame.Position = UDim2.new(0, 110, 0, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local currentTabContent = nil
    local function switchTab(newContent, button)
        if currentTabContent then currentTabContent.Visible = false end
        currentTabContent = newContent
        newContent.Visible = true
        for _, b in tabContainer:GetChildren() do
            if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(35,35,50) end
        end
        if button then button.BackgroundColor3 = Color3.fromRGB(0, 255, 100) end
    end

    local function createTab(name, icon)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -12, 0, 50)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        btn.Text = icon .. " " .. name
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Parent = tabContainer
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

        local content = Instance.new("Frame")
        content.Size = UDim2.new(1, -20, 1, -20)
        content.Position = UDim2.new(0, 10, 0, 10)
        content.BackgroundTransparency = 1
        content.Visible = false
        content.Parent = contentFrame

        btn.MouseButton1Click:Connect(function() switchTab(content, btn) end)
        return content, btn
    end

    -- Fly Tab
    local flyTab, flyButton = createTab("Fly", "Fly")

    local flyTitle = Instance.new("TextLabel", flyTab)
    flyTitle.Size = UDim2.new(1,0,0,32)
    flyTitle.BackgroundTransparency = 1
    flyTitle.Text = "Fly Controller"
    flyTitle.TextColor3 = Color3.new(1,1,1)
    flyTitle.Font = Enum.Font.GothamBold
    flyTitle.TextSize = 20

    local flyInfo = Instance.new("TextLabel", flyTab)
    flyInfo.Position = UDim2.new(0,0,0,32)
    flyInfo.Size = UDim2.new(1,0,0,20)
    flyInfo.BackgroundTransparency = 1
    flyInfo.Text = "W/A/S/D = Move | Space = Up | LShift = Down"
    flyInfo.TextColor3 = Color3.fromRGB(180,180,180)
    flyInfo.Font = Enum.Font.Gotham
    flyInfo.TextSize = 13

    -- PERFECT SLIDER + LABEL
    local speedValue = 100

    local speedLabel = Instance.new("TextLabel", flyTab)
    speedLabel.Size = UDim2.new(1,-20,0,25)
    speedLabel.Position = UDim2.new(0,10,0,60)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Fly Speed: 100"
    speedLabel.TextColor3 = Color3.fromRGB(0,255,100)
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.TextSize = 18

    local sliderBack = Instance.new("Frame", flyTab)
    sliderBack.Size = UDim2.new(1,-20,0,12)
    sliderBack.Position = UDim2.new(0,10,0,95)
    sliderBack.BackgroundColor3 = Color3.fromRGB(50,50,60)
    Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(0,6)

    local sliderFill = Instance.new("Frame", sliderBack)
    sliderFill.Size = UDim2.new(100/300,0,1,0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0,255,100)
    sliderFill.BorderSizePixel = 0
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0,6)

    local sliderKnob = Instance.new("Frame", sliderBack)
    sliderKnob.Size = UDim2.new(0,20,0,20)
    sliderKnob.Position = UDim2.new(100/300,-10,0,-4)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(0,255,100)
    sliderKnob.ZIndex = 2
    Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1,0)

    local draggingSlider = false
    local function updateSlider(x)
        local rel = math.clamp((x - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(rel,0,1,0)
        sliderKnob.Position = UDim2.new(rel,-10,0,-4)
        speedValue = math.floor(rel * 300 + 0.5)
        speedLabel.Text = "Fly Speed: " .. speedValue
    end

    sliderBack.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true updateSlider(i.Position.X) end end)
    sliderKnob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end end)
    UIS.InputChanged:Connect(function(i) if draggingSlider and i.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(i.Position.X) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end end)

    local function getSpeed() return speedValue end

    -- Keybind
    local keybindLabel = Instance.new("TextLabel", flyTab)
    keybindLabel.Size = UDim2.new(1,-10,0,30)
    keybindLabel.Position = UDim2.new(0,5,0,145)
    keybindLabel.BackgroundColor3 = Color3.fromRGB(40,40,55)
    keybindLabel.Text = "Keybind: X"
    keybindLabel.TextColor3 = Color3.new(1,1,1)
    keybindLabel.Font = Enum.Font.GothamBold
    keybindLabel.TextSize = 16
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Center
    Instance.new("UICorner", keybindLabel).CornerRadius = UDim.new(0,8)

    local toggleKey = Enum.KeyCode.X
    keybindLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            keybindLabel.Text = "Press any key..."
            local conn; conn = UIS.InputBegan:Connect(function(i)
                if i.KeyCode ~= Enum.KeyCode.Unknown then
                    toggleKey = i.KeyCode
                    keybindLabel.Text = "Keybind: " .. i.KeyCode.Name
                    conn:Disconnect()
                end
            end)
        end
    end)

    -- Fly Logic
    local flying = false
    local root, flyConn

    local function startFly()
        local char = player.Character or player.CharacterAdded:Wait()
        root = char:WaitForChild("HumanoidRootPart")
        if flyConn then flyConn:Disconnect() end
        flyConn = RunService.Heartbeat:Connect(function()
            if not flying or not root then return end
            local cam = workspace.CurrentCamera
            local move = Vector3.new()
            local look = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit

            if UIS:IsKeyDown(Enum.KeyCode.W) then move += look end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move -= look end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end

            root.Velocity = move.Magnitude > 0 and (move.Unit * getSpeed()) or Vector3.new()
        end)
    end

    UIS.InputBegan:Connect(function(i,gp)
        if gp then return end
        if i.KeyCode == toggleKey then
            flying = not flying
            if flying then startFly() end
        end
    end)

    -- Anti-Fling Tab (OFF by default)
    local afTab, afButton = createTab("Anti-Fling", "Anti-Fling")

    local afTitle = Instance.new("TextLabel", afTab)
    afTitle.Size = UDim2.new(1,0,0,35)
    afTitle.BackgroundTransparency = 1
    afTitle.Text = "Anti-Fling"
    afTitle.TextColor3 = Color3.new(1,1,1)
    afTitle.Font = Enum.Font.GothamBold
    afTitle.TextSize = 22

    local afToggle = Instance.new("TextButton", afTab)
    afToggle.Size = UDim2.new(1,-20,0,50)
    afToggle.Position = UDim2.new(0,10,0,60)
    afToggle.BackgroundColor3 = Color3.fromRGB(255,80,80)
    afToggle.Text = "OFF (VULNERABLE)"
    afToggle.TextColor3 = Color3.new(1,1,1)
    afToggle.Font = Enum.Font.GothamBold
    afToggle.TextSize = 18
    Instance.new("UICorner", afToggle).CornerRadius = UDim.new(0,10)

    local antiFlingEnabled = false
    local lastSafe = nil
    local conn1 = nil

    local function enableAntiFling()
        if conn1 then conn1:Disconnect() end
        conn1 = RunService.Heartbeat:Connect(function()
            if not antiFlingEnabled then return end
            local char = player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            pcall(function() hrp:SetNetworkOwner(player) end)
            local vel = hrp.AssemblyLinearVelocity
            if vel.Magnitude < 150 then lastSafe = hrp.CFrame return end
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            if lastSafe then hrp.CFrame = lastSafe end
        end)
    end

    afToggle.MouseButton1Click:Connect(function()
        antiFlingEnabled = not antiFlingEnabled
        if antiFlingEnabled then
            enableAntiFling()
            afToggle.BackgroundColor3 = Color3.fromRGB(0,255,100)
            afToggle.Text = "ON (UNFLINGABLE)"
        else
            if conn1 then conn1:Disconnect() end
            afToggle.BackgroundColor3 = Color3.fromRGB(255,80,80)
            afToggle.Text = "OFF (VULNERABLE)"
        end
    end)

    player.CharacterAdded:Connect(function()
        task.wait(1)
        lastSafe = nil
        if antiFlingEnabled then enableAntiFling() end
    end)

    -- Start auf Fly Tab
    switchTab(flyTab, flyButton)

    print("Extort Ultimate Loaded – Dragging & Slider 100% perfekt!")
end

--========================== LOGIN LOGIC ==========================--
local function clearStatus()
    task.wait(3)
    if StatusLabel.Text ~= "Login successful!" then StatusLabel.Text = "" end
end

LoginButton.MouseButton1Click:Connect(function()
    local user = UsernameBox.Text
    local pass = PasswordBox.Text
    if user == "Username" or pass == "Password" or user == "" or pass == "" then
        StatusLabel.Text = "Enter username & password!"
        StatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
        task.spawn(clearStatus)
        return
    end

    StatusLabel.Text = "Authenticating..."
    StatusLabel.TextColor3 = Color3.fromRGB(255,255,0)

    task.spawn(function()
        local success, result = ExecutorPost(LOGIN_URL, HttpService:JSONEncode({username = user, password = pass}))
        if success then
            local data = HttpService:JSONDecode(result)
            if data.sessionToken then
                StatusLabel.Text = "Login successful!"
                StatusLabel.TextColor3 = Color3.fromRGB(0,255,100)
                task.wait(1.5)
                TweenService:Create(LoginFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(Stroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
                task.wait(0.6)
                getgenv().MY_SESSION_TOKEN = data.sessionToken
                LoadMainGUI()
            else
                StatusLabel.Text = "Invalid credentials"
                StatusLabel.TextColor3 = Color3.fromRGB(255,80,80)
                task.spawn(clearStatus)
            end
        else
            StatusLabel.Text = "Server Error: " .. result
            StatusLabel.TextColor3 = Color3.fromRGB(255,100,100)
            task.spawn(clearStatus)
        end
    end)
end)

print("Extort Login Loaded – Inject & Own the server.")