-- ✅ ANTI KICK TOÀN DIỆN
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Chặn Kick qua __namecall
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if method == "Kick" or tostring(self):lower():find("kick") then
		warn("🚫 Blocked Kick:", tostring(self))
		return nil
	end
	return oldNamecall(self, ...)
end)

-- Chặn Local Kick
lp.Kick = function() end
hookfunction(lp.Kick, function() return end)

-- Xóa RemoteEvent liên quan tới kick
for _, v in pairs(game:GetDescendants()) do
	if v:IsA("RemoteEvent") and tostring(v.Name):lower():find("kick") then
		v:Destroy()
	end
end

print("[✅] AntiKick đã bật – không ai đá bạn được nữa.")
