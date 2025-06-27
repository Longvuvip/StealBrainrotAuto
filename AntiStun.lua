-- 🛡️ Script miễn nhiễm bị đánh / không bị knockback / stun trong Steal a Brainrot
local lp = game:GetService("Players").LocalPlayer
local chr = lp.Character or lp.CharacterAdded:Wait()

-- 🔁 Hàm xóa các force vật lý gây knockback
local function RemoveForces()
	for _, v in pairs(chr:GetDescendants()) do
		if v:IsA("BodyVelocity") or v:IsA("BodyForce") or v:IsA("BodyAngularVelocity") then
			v:Destroy()
		end
	end
end

-- 🔒 Khóa velocity
chr:WaitForChild("HumanoidRootPart"):GetPropertyChangedSignal("Velocity"):Connect(function()
	chr.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
end)

-- Xóa các force ngay khi script bắt đầu
RemoveForces()

-- 🔁 Lặp lại mỗi 1s để đảm bảo không force nào tồn tại lâu
while true do
	RemoveForces()
	task.wait(1)
end