-- MAIN ROBLOX AUTH SCRIPT (USERNAME FIELD = PASSWORD FIELD STYLE: PLACEHOLDER TEXT)
local Auth = loadstring(game:HttpGet("https://raw.githubusercontent.com/JJ1301/auth/refs/heads/main/authentification.lua"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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

-- Username (NOW SAME AS PASSWORD: PLACEHOLDER TEXT)
UsernameBox.Size = UDim2.new(0, 300, 0, 45)
UsernameBox.Position = UDim2.new(0.5, -150, 0, 60)
UsernameBox.PlaceholderText = "Username"  -- Placeholder like Password
UsernameBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)  -- Gray placeholder
UsernameBox.Text = ""  -- Empty by default
UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White when typing
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
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
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
