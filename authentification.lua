local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- YOUR BACKEND URL
local LOGIN_URL = "https://function-bun-production-c7eb.up.railway.app/login"

if not HttpService.HttpEnabled then
    HttpService.HttpEnabled = true
end

local oldRequest = request or http_request or syn and syn.request
if not oldRequest then
    error("Your executor doesn't support HTTP requests!")
end

local function ExecutorPost(url, body)
    local success, response = pcall(function()
        return oldRequest({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })
    end)
    
    if not success then
        return false, "Request failed"
    end
    
    if response.Success then
        return true, response.Body
    else
        return false, response.StatusMessage or "HTTP " .. response.StatusCode
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

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

local UsernameBox = Instance.new("TextBox")
UsernameBox.Size = UDim2.new(0, 300, 0, 45)
UsernameBox.Position = UDim2.new(0.5, -150, 0, 60)
UsernameBox.PlaceholderText = "Username"
UsernameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
UsernameBox.TextColor3 = Color3.new(1,1,1)
UsernameBox.Text = ""
UsernameBox.Parent = LoginFrame
Instance.new("UICorner", UsernameBox).CornerRadius = UDim.new(0, 10)

local PasswordBox = Instance.new("TextBox")
PasswordBox.Size = UDim2.new(0, 300, 0, 45)
PasswordBox.Position = UDim2.new(0.5, -150, 0, 115)
PasswordBox.PlaceholderText = "Password"
PasswordBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PasswordBox.TextColor3 = Color3.new(1,1,1)
PasswordBox.Text = ""
PasswordBox.Parent = LoginFrame
Instance.new("UICorner", PasswordBox).CornerRadius = UDim.new(0, 10)

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

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
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
MainLabel.Size = UDim2.new(1, -40, 1, -40)
MainLabel.Position = UDim2.new(0, 20, 0, 20)
MainLabel.BackgroundTransparency = 1
MainLabel.Text = "Welcome Back!\nYou are now authenticated."
MainLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
MainLabel.Font = Enum.Font.GothamBold
MainLabel.TextSize = 26
MainLabel.TextXAlignment = Enum.TextXAlignment.Center
MainLabel.TextYAlignment = Enum.TextYAlignment.Center
MainLabel.Parent = MainFrame

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
                --// print("Logged in! Token:", data.sessionToken)
            else
                StatusLabel.Text = "Wrong username or password"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
                task.spawn(clearStatus)
            end
        else
            StatusLabel.Text = "Server error: " .. result
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.spawn(clearStatus)
        end
    end)
end)
