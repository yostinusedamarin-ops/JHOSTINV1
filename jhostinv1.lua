--// 🔥 JHOSTIN PREMIUM V4 🔥
--// MENU BONITO + BOLITAS + TOGGLE GOD 😮‍💨

local player = game.Players.LocalPlayer

if player.PlayerGui:FindFirstChild("JHOSTIN_PREMIUM") then
	player.PlayerGui:FindFirstChild("JHOSTIN_PREMIUM"):Destroy()
end

local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-------------------------------------------------
-- VARIABLES
-------------------------------------------------

local fly = false
local noclip = false
local sprintOn = false
local AntiAFK = true
local FPSBoost = false

local flySpeed = 80
local maxFlySpeed = 500

local walkSpeed = 16
local maxWalkSpeed = 5000

local savedPos = nil

local bv
local bg

-------------------------------------------------
-- ANTI AFK
-------------------------------------------------

player.Idled:Connect(function()
	if AntiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

-------------------------------------------------
-- GUI
-------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "JHOSTIN_PREMIUM"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-------------------------------------------------
-- BOTON MENU
-------------------------------------------------

local toggle = Instance.new("TextButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,65,0,65)
toggle.Position = UDim2.new(0,20,0.4,0)
toggle.Text = "💀"
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBlack
toggle.BackgroundColor3 = Color3.fromRGB(15,15,20)
toggle.TextColor3 = Color3.fromRGB(255,0,120)
toggle.Active = true
toggle.Draggable = true
toggle.ZIndex = 10

Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)

local toggleStroke = Instance.new("UIStroke",toggle)
toggleStroke.Color = Color3.fromRGB(255,0,120)
toggleStroke.Thickness = 2

-------------------------------------------------
-- FRAME
-------------------------------------------------

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,430,0,790)
frame.Position = UDim2.new(0.08,0,0.08,0)
frame.BackgroundColor3 = Color3.fromRGB(10,10,15)
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(255,0,120)
stroke.Thickness = 2

-------------------------------------------------
-- 🔵 BOLITAS REBOTANDO 🔵
-------------------------------------------------

for i = 1,20 do

	local ball = Instance.new("Frame")
	ball.Parent = frame
	ball.Size = UDim2.new(0,math.random(8,20),0,math.random(8,20))
	ball.Position = UDim2.new(math.random(),0,math.random(),0)
	ball.BackgroundColor3 = Color3.fromRGB(0,170,255)
	ball.BackgroundTransparency = 0.35
	ball.ZIndex = 0

	local corner = Instance.new("UICorner",ball)
	corner.CornerRadius = UDim.new(1,0)

	local speedX = math.random(-3,3)
	local speedY = math.random(-3,3)

	task.spawn(function()

		while ball.Parent do

			local pos = ball.Position

			local newX = pos.X.Scale + (speedX * 0.0015)
			local newY = pos.Y.Scale + (speedY * 0.0015)

			if newX <= 0 or newX >= 0.95 then
				speedX = -speedX
			end

			if newY <= 0 or newY >= 0.95 then
				speedY = -speedY
			end

			ball.Position = UDim2.new(newX,0,newY,0)

			RunService.RenderStepped:Wait()
		end
	end)
end

-------------------------------------------------
-- TITULO
-------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,70)
title.BackgroundTransparency = 1
title.Text = "🔥 JHOSTIN PREMIUM 🔥"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(255,255,255)
title.ZIndex = 5

-------------------------------------------------
-- TOGGLE MENU
-------------------------------------------------

toggle.MouseButton1Click:Connect(function()

	frame.Visible = not frame.Visible

	if frame.Visible then
		toggle.Text = "❌"
	else
		toggle.Text = "💀"
	end
end)

-------------------------------------------------
-- FUNCION BOTONES
-------------------------------------------------

local function createButton(parent,text,pos,color)

	local btn = Instance.new("TextButton")
	btn.Parent = parent
	btn.Size = UDim2.new(0,380,0,42)
	btn.Position = pos
	btn.Text = text
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(1,1,1)
	btn.ZIndex = 5

	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,12)

	local st = Instance.new("UIStroke",btn)
	st.Color = Color3.fromRGB(255,255,255)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn,TweenInfo.new(0.15),{
			BackgroundTransparency = 0.15
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn,TweenInfo.new(0.15),{
			BackgroundTransparency = 0
		}):Play()
	end)

	return btn
end

-------------------------------------------------
-- FPS
-------------------------------------------------

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Parent = frame
fpsLabel.Size = UDim2.new(0,380,0,40)
fpsLabel.Position = UDim2.new(0,25,0,80)
fpsLabel.BackgroundColor3 = Color3.fromRGB(15,25,15)
fpsLabel.TextColor3 = Color3.fromRGB(0,255,100)
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.GothamBlack
fpsLabel.ZIndex = 5

Instance.new("UICorner",fpsLabel).CornerRadius = UDim.new(0,12)

local fpsFrames = 0
local fpsTime = tick()

RunService.RenderStepped:Connect(function()
	fpsFrames += 1

	if tick() - fpsTime >= 1 then
		fpsLabel.Text = "🎮 FPS : "..fpsFrames
		fpsFrames = 0
		fpsTime = tick()
	end
end)

-------------------------------------------------
-- FUNCIONES
-------------------------------------------------

local function BoostFPS(state)

	if state then

		Lighting.GlobalShadows = false
		Lighting.FogEnd = 999999
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

		for _,v in pairs(game:GetDescendants()) do

			if v:IsA("BasePart") then
				v.Material = Enum.Material.Plastic
				v.Reflectance = 0
			end

			if v:IsA("Texture") or v:IsA("Decal") then
				v.Transparency = 1
			end

			if v:IsA("ParticleEmitter")
			or v:IsA("Trail")
			or v:IsA("Smoke")
			or v:IsA("Fire") then
				v.Enabled = false
			end
		end
	end
end

-------------------------------------------------
-- BOTONES
-------------------------------------------------

local noclipBtn = createButton(frame,"👻 NOCLIP OFF",UDim2.new(0,25,0,135),Color3.fromRGB(40,40,40))
local afkBtn = createButton(frame,"😴 ANTI AFK ON",UDim2.new(0,25,0,190),Color3.fromRGB(90,60,20))
local fpsBtn = createButton(frame,"🚀 FPS BOOST OFF",UDim2.new(0,25,0,245),Color3.fromRGB(20,60,90))
local flyBtn = createButton(frame,"✈️ FLY OFF",UDim2.new(0,25,0,300),Color3.fromRGB(80,40,120))

-------------------------------------------------
-- NOCLIP
-------------------------------------------------

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

	noclipBtn.Text = noclip and "👻 NOCLIP ON" or "👻 NOCLIP OFF"
end)

-------------------------------------------------
-- AFK
-------------------------------------------------

afkBtn.MouseButton1Click:Connect(function()

	AntiAFK = not AntiAFK

	afkBtn.Text = AntiAFK and "😴 ANTI AFK ON" or "💀 ANTI AFK OFF"
end)

-------------------------------------------------
-- FPS BOOST
-------------------------------------------------

fpsBtn.MouseButton1Click:Connect(function()

	FPSBoost = not FPSBoost

	fpsBtn.Text = FPSBoost and "🚀 FPS BOOST ON" or "🚀 FPS BOOST OFF"

	BoostFPS(FPSBoost)
end)

-------------------------------------------------
-- FLY
-------------------------------------------------

local flyLabel = Instance.new("TextLabel")
flyLabel.Parent = frame
flyLabel.Size = UDim2.new(0,380,0,35)
flyLabel.Position = UDim2.new(0,25,0,350)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "FLY SPEED : "..flySpeed
flyLabel.TextScaled = true
flyLabel.Font = Enum.Font.GothamBold
flyLabel.TextColor3 = Color3.fromRGB(220,180,255)
flyLabel.ZIndex = 5

local flyPlus = createButton(frame,"➕ FLY SPEED",UDim2.new(0,25,0,390),Color3.fromRGB(120,60,180))
local flyMinus = createButton(frame,"➖ FLY SPEED",UDim2.new(0,25,0,440),Color3.fromRGB(90,40,140))

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

		flyBtn.Text = "✈️ FLY ON"

	else

		humanoid.PlatformStand = false

		if bv then bv:Destroy() end
		if bg then bg:Destroy() end

		flyBtn.Text = "✈️ FLY OFF"
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

	if flySpeed < maxFlySpeed then
		flySpeed += 20
		flyLabel.Text = "FLY SPEED : "..flySpeed
	end
end)

flyMinus.MouseButton1Click:Connect(function()

	if flySpeed > 20 then
		flySpeed -= 20
		flyLabel.Text = "FLY SPEED : "..flySpeed
	end
end)

-------------------------------------------------
-- RUN
-------------------------------------------------

local walkLabel = Instance.new("TextLabel")
walkLabel.Parent = frame
walkLabel.Size = UDim2.new(0,380,0,35)
walkLabel.Position = UDim2.new(0,25,0,500)
walkLabel.BackgroundTransparency = 1
walkLabel.Text = "RUN SPEED : "..walkSpeed
walkLabel.TextScaled = true
walkLabel.Font = Enum.Font.GothamBold
walkLabel.TextColor3 = Color3.fromRGB(120,220,255)
walkLabel.ZIndex = 5

local walkPlus = createButton(frame,"🏃 + RUN",UDim2.new(0,25,0,540),Color3.fromRGB(20,100,140))
local walkMinus = createButton(frame,"🐢 - RUN",UDim2.new(0,25,0,590),Color3.fromRGB(20,60,100))
local sprintBtn = createButton(frame,"⚡ SPRINT OFF",UDim2.new(0,25,0,640),Color3.fromRGB(0,140,255))

walkPlus.MouseButton1Click:Connect(function()

	if walkSpeed < maxWalkSpeed then

		walkSpeed += 50
		humanoid.WalkSpeed = walkSpeed
		walkLabel.Text = "RUN SPEED : "..walkSpeed
	end
end)

walkMinus.MouseButton1Click:Connect(function()

	if walkSpeed > 16 then

		walkSpeed -= 50
		humanoid.WalkSpeed = walkSpeed
		walkLabel.Text = "RUN SPEED : "..walkSpeed
	end
end)

sprintBtn.MouseButton1Click:Connect(function()

	sprintOn = not sprintOn

	humanoid.WalkSpeed = sprintOn and walkSpeed or 16

	sprintBtn.Text = sprintOn and "⚡ SPRINT ON" or "⚡ SPRINT OFF"
end)

-------------------------------------------------
-- TP
-------------------------------------------------

local markBtn = createButton(frame,"📍 MARCAR POS",UDim2.new(0,25,0,700),Color3.fromRGB(20,120,60))
markBtn.Size = UDim2.new(0,180,0,42)

local tpBtn = createButton(frame,"🌀 TELEPORT",UDim2.new(0,225,0,700),Color3.fromRGB(20,180,100))
tpBtn.Size = UDim2.new(0,180,0,42)

markBtn.MouseButton1Click:Connect(function()

	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if hrp then
		savedPos = hrp.Position
	end
end)

tpBtn.MouseButton1Click:Connect(function()

	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if hrp and savedPos then
		hrp.CFrame = CFrame.new(savedPos + Vector3.new(0,3,0))
	end
end)

print("🔥 MENU GOD CARGADO YA QUEDÓ BIEN JAJA")
