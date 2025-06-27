-- ⚠️ Anti Knockback / Anti Stun / Anti Push toàn diện
local lp = game:GetService("Players").LocalPlayer
local chr = lp.Character or lp.CharacterAdded:Wait()
local hrp = chr:WaitForChild("HumanoidRootPart")

-- Chặn velocity
hrp:GetPropertyChangedSignal("Velocity"):Connect(function()
	hrp.Velocity = Vector3.zero
end)

-- Chặn damage vật lý / ragdoll
local hum = chr:FindFirstChildOfClass("Humanoid")
if hum then
	hum.StateChanged:Connect(function(_, new)
		if new == Enum.HumanoidStateType.FallingDown or
		   new == Enum.HumanoidStateType.Ragdoll or
		   new == Enum.HumanoidStateType.Physics then
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end)
end

-- Patch Remote Push từ server (nếu có)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	if method == "FireServer" and tostring(self):lower():find("push") then
		warn("🚫 Blocked push remote:", self.Name)
		return nil
	end
	return old(self, ...)
end)

-- Xóa BodyForce, BodyVelocity các loại
while true do
	for _, v in pairs(chr:GetDescendants()) do
		if v:IsA("BodyVelocity") or v:IsA("BodyForce") or v:IsA("BodyAngularVelocity") then
			v:Destroy()
		end
	end
	task.wait(1)
end
