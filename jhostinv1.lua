local player = game.Players.LocalPlayer
if player.PlayerGui:FindFirstChild("JHOSTIN_FULL") then
	player.PlayerGui:FindFirstChild("JHOSTIN_FULL"):Destroy()
end

local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ✈️ FLY
local fly = false
local flySpeed = 120
local maxFlySpeed = 500

-- 🏃 RUN
local walkSpeed = 16
local maxWalkSpeed = 5000
local sprintOn = false

-- 📍 TP
local savedPos = nil
local marker = nil

local bv
local bg

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "JHOSTIN_FULL"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- TOGGLE BUTTON
local toggle = Instance.new("TextButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,80,0,80)
toggle.Position = UDim2.new(0,20,0.5,0)
toggle.Text = "Y" 
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBlack
toggle.BackgroundColor3 = Color3.fromRGB(10,10,15)
toggle.TextColor3 = Color3.fromRGB(0,170,255)
toggle.Active = true
toggle.Draggable = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

-- FRAME
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,420,0,650)
frame.Position = UDim2.new(0,90,0.15,0)
frame.BackgroundColor3 = Color3.fromRGB(5,5,10)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,70)
title.BackgroundTransparency = 1
title.Text = "JHOSTIN V1.5"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(0,170,255)

-------------------------------------------------
-- 🧱 NOCLIP
-------------------------------------------------
local noclipBtn = Instance.new("TextButton")
noclipBtn.Parent = frame
noclipBtn.Size = UDim2.new(0,380,0,50)
noclipBtn.Position = UDim2.new(0,20,0,80)
noclipBtn.Text = "NOCLIP OFF"
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamBold

-------------------------------------------------
-- 💜 FLY
-------------------------------------------------
local flyBox = Instance.new("Frame")
flyBox.Parent = frame
flyBox.Size = UDim2.new(0,380,0,170)
flyBox.Position = UDim2.new(0,20,0,140)
flyBox.BackgroundColor3 = Color3.fromRGB(40,15,70)
Instance.new("UICorner", flyBox).CornerRadius = UDim.new(0,10)

local flyTitle = Instance.new("TextLabel")
flyTitle.Parent = flyBox
flyTitle.Size = UDim2.new(1,0,0,30)
flyTitle.Text = "✈ FLY CONTROL"
flyTitle.TextScaled = true
flyTitle.Font = Enum.Font.GothamBlack
flyTitle.TextColor3 = Color3.fromRGB(200,120,255)
flyTitle.BackgroundTransparency = 1

local flyBtn = Instance.new("TextButton")
flyBtn.Parent = flyBox
flyBtn.Size = UDim2.new(0,360,0,40)
flyBtn.Position = UDim2.new(0,10,0,40)
flyBtn.Text = "FLY OFF"
flyBtn.TextScaled = true

local flyLabel = Instance.new("TextLabel")
flyLabel.Parent = flyBox
flyLabel.Size = UDim2.new(1,0,0,25)
flyLabel.Position = UDim2.new(0,0,0,85)
flyLabel.Text = "FLY SPEED: "..flySpeed
flyLabel.TextScaled = true
flyLabel.BackgroundTransparency = 1

local flyPlus = Instance.new("TextButton")
flyPlus.Parent = flyBox
flyPlus.Size = UDim2.new(0,180,0,40)
flyPlus.Position = UDim2.new(0,10,0,115)
flyPlus.Text = "+ SPEED"

local flyMinus = Instance.new("TextButton")
flyMinus.Parent = flyBox
flyMinus.Size = UDim2.new(0,180,0,40)
flyMinus.Position = UDim2.new(0,200,0,115)
flyMinus.Text = "- SPEED"

-------------------------------------------------
-- 💙 RUN BOX
-------------------------------------------------
local runBox = Instance.new("Frame")
runBox.Parent = frame
runBox.Size = UDim2.new(0,380,0,150)
runBox.Position = UDim2.new(0,20,0,320)
runBox.BackgroundColor3 = Color3.fromRGB(10,50,90)
Instance.new("UICorner", runBox).CornerRadius = UDim.new(0,10)

local runTitle = Instance.new("TextLabel")
runTitle.Parent = runBox
runTitle.Size = UDim2.new(1,0,0,30)
runTitle.Text = "🏃 RUN SPEED"
runTitle.TextScaled = true
runTitle.Font = Enum.Font.GothamBlack
runTitle.TextColor3 = Color3.fromRGB(0,200,255)
runTitle.BackgroundTransparency = 1

local walkLabel = Instance.new("TextLabel")
walkLabel.Parent = runBox
walkLabel.Size = UDim2.new(1,0,0,25)
walkLabel.Position = UDim2.new(0,0,0,30)
walkLabel.Text = "WALK SPEED: "..walkSpeed
walkLabel.TextScaled = true
walkLabel.BackgroundTransparency = 1

local walkPlus = Instance.new("TextButton")
walkPlus.Parent = runBox
walkPlus.Size = UDim2.new(0,180,0,40)
walkPlus.Position = UDim2.new(0,10,0,70)
walkPlus.Text = "+ RUN"

local walkMinus = Instance.new("TextButton")
walkMinus.Parent = runBox
walkMinus.Size = UDim2.new(0,180,0,40)
walkMinus.Position = UDim2.new(0,200,0,70)
walkMinus.Text = "- RUN"

local sprintBtn = Instance.new("TextButton")
sprintBtn.Parent = runBox
sprintBtn.Size = UDim2.new(0,360,0,35)
sprintBtn.Position = UDim2.new(0,10,0,115)
sprintBtn.Text = "SPRINT OFF"

-------------------------------------------------
-- 💚 TP BOX
-------------------------------------------------
local tpBox = Instance.new("Frame")
tpBox.Parent = frame
tpBox.Size = UDim2.new(0,380,0,170)
tpBox.Position = UDim2.new(0,20,0,480)
tpBox.BackgroundColor3 = Color3.fromRGB(10,90,50)
Instance.new("UICorner", tpBox).CornerRadius = UDim.new(0,10)

local tpTitle = Instance.new("TextLabel")
tpTitle.Parent = tpBox
tpTitle.Size = UDim2.new(1,0,0,30)
tpTitle.Text = "📍 TELEPORT SYSTEM"
tpTitle.TextScaled = true
tpTitle.Font = Enum.Font.GothamBlack
tpTitle.TextColor3 = Color3.fromRGB(0,255,150)
tpTitle.BackgroundTransparency = 1

local markBtn = Instance.new("TextButton")
markBtn.Parent = tpBox
markBtn.Size = UDim2.new(0,180,0,40)
markBtn.Position = UDim2.new(0,10,0,50)
markBtn.Text = "MARCAR"

local tpBtn = Instance.new("TextButton")
tpBtn.Parent = tpBox
tpBtn.Size = UDim2.new(0,180,0,40)
tpBtn.Position = UDim2.new(0,200,0,50)
tpBtn.Text = "TELEPORT"

local removeMark = Instance.new("TextButton")
removeMark.Parent = tpBox
removeMark.Size = UDim2.new(0,360,0,40)
removeMark.Position = UDim2.new(0,10,0,100)
removeMark.Text = "❌ QUITAR MARCA"

-------------------------------------------------
-- LOGICA
-------------------------------------------------

toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

RunService.Stepped:Connect(function()
	if noclip and player.Character then
		for _,v in pairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

noclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
	noclipBtn.Text = noclip and "NOCLIP ON" or "NOCLIP OFF"
end)

flyBtn.MouseButton1Click:Connect(function()
	fly = not fly
	char = player.Character or player.CharacterAdded:Wait()
	humanoid = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")

	if fly then
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e9,1e9,1e9)
		bv.Parent = hrp

		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
		bg.Parent = hrp

		humanoid.PlatformStand = true
		flyBtn.Text = "FLY ON"
	else
		humanoid.PlatformStand = false
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		flyBtn.Text = "FLY OFF"
	end
end)

RunService.RenderStepped:Connect(function()
	if fly then
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp and bv and bg then
			local cam = workspace.CurrentCamera
			local move = Vector3.zero

			if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

			bv.Velocity = move * flySpeed
			bg.CFrame = cam.CFrame
		end
	end
end)

flyPlus.MouseButton1Click:Connect(function()
	if flySpeed < maxFlySpeed then flySpeed += 20 flyLabel.Text = "FLY SPEED: "..flySpeed end
end)

flyMinus.MouseButton1Click:Connect(function()
	if flySpeed > 10 then flySpeed -= 20 flyLabel.Text = "FLY SPEED: "..flySpeed end
end)

walkPlus.MouseButton1Click:Connect(function()
	if walkSpeed < maxWalkSpeed then walkSpeed += 50 humanoid.WalkSpeed = walkSpeed walkLabel.Text = "WALK SPEED: "..walkSpeed end
end)

walkMinus.MouseButton1Click:Connect(function()
	if walkSpeed > 16 then walkSpeed -= 50 humanoid.WalkSpeed = walkSpeed walkLabel.Text = "WALK SPEED: "..walkSpeed end
end)

sprintBtn.MouseButton1Click:Connect(function()
	sprintOn = not sprintOn
	humanoid.WalkSpeed = sprintOn and walkSpeed or 16
	sprintBtn.Text = sprintOn and "SPRINT ON" or "SPRINT OFF"
end)

markBtn.MouseButton1Click:Connect(function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then savedPos = hrp.Position end
end)

tpBtn.MouseButton1Click:Connect(function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp and savedPos then
		hrp.CFrame = CFrame.new(savedPos + Vector3.new(0,3,0))
	end
end)

removeMark.MouseButton1Click:Connect(function()
	savedPos = nil
	if marker then marker:Destroy() marker = nil end
end)
