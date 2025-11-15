local Auth = {}

local ValidUsers = {
	["Player1"] = "secret123",
	["DevUser"] = "admin2025",
	["TestAcc"] = "pass456"
}

function Auth:Check(username, password)
	if ValidUsers[username] and ValidUsers[username] == password then
		return true
	end
	return false
end

return Auth
