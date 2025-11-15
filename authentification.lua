local Auth = {}

local ValidUsers = {
    ["User"] = "123",
    ["Sigma"] = "sigma",
    ["Bust"] = "Nut"
}

function Auth:Check(username, password)
    return ValidUsers[username] and ValidUsers[username] == password
end

return Auth
