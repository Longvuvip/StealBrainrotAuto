-- 🚫 Anti Kick (ngăn server dùng kick bạn ra khỏi game)
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if tostring(self):lower():find("kick") and method == "FireServer" then
		warn("🚫 Blocked Kick Remote:", self)
		return nil
	end
	if method == "Kick" then
		warn("🚫 Blocked Local Kick:", self)
		return nil
	end
	return oldNamecall(self, ...)
end)

game:GetService("Players").LocalPlayer.Kick = function() return nil end
hookfunction(game:GetService("Players").LocalPlayer.Kick, function() return nil end)
