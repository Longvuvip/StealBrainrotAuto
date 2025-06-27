-- ✅ FULL BYPASS STEAL A BRAINROT
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local chr = lp.Character or lp.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local hrp = chr:WaitForChild("HumanoidRootPart")

-- 🛡 Anti Kick
local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if method == "Kick" or tostring(self):lower():find("kick") then
		warn("🚫 Blocked Kick:", self)
		return nil
	end
	return oldNamecall(self, ...)
end)
lp.Kick = function() end
hookfunction(lp.Kick, function() return end)

-- 🛡 Anti Stun / Knockback
hum.StateChanged:Connect(function(_, new)
	if new == Enum.HumanoidStateType.FallingDown or new == Enum.HumanoidStateType.Ragdoll then
		hum:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end)
hrp:GetPropertyChangedSignal("Velocity"):Connect(function()
	hrp.Velocity = Vector3.zero
end)
while true do
	for _, v in pairs(chr:GetDescendants()) do
		if v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") then
			v:Destroy()
		end
	end
	wait(1)
end

-- 🐾 Auto Steal 1 pet mỗi lượt (tùy chọn)
task.spawn(function()
	while task.wait(2) do
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Tool") and v:FindFirstChild("Handle") and v.Parent.Name ~= lp.Name then
				firetouchinterest(hrp, v.Handle, 0)
				firetouchinterest(hrp, v.Handle, 1)
				print("🦴 Stolen pet:", v.Name)
				break
			end
		end
	end
end)
