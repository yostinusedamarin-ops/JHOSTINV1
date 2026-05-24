local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local noclip = false
local fly = false
local speed = 200
local maxSpeed = 200

local bv
local bg

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JHOSTINV1"
ScreenGui.Parent = player.PlayerGui
ScreenGui.ResetOnSpawn = false

-- BOTON Y
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0,50,0,50)
ToggleButton.Position = UDim2.new(0,20,0.5,0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15,15,20)
ToggleButton.TextColor3 = Color3.fromRGB(0,170,255)
ToggleButton.TextScaled = true
ToggleButton.Text = "Y"
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.BorderSizePixel = 0
ToggleButton.Active = true
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1,0)
ToggleCorner.Parent = ToggleButton

-- PANEL
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,220,0,250)
Frame.Position = UDim2.new(0,80,0.45,0)
Frame.BackgroundColor3 = Color3.fromRGB(5,5,10)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,10)
MainCorner.Parent = Frame

-- PARTICULAS
for i = 1,25 do
	local Dot = Instance.new("Frame")
	Dot.Parent = Frame

	local size = math.random(2,6)

	Dot.Size = UDim2.new(0,size,0,size)
	Dot.Position = UDim2.new(math.random(),0,math.random(),0)

	Dot.BackgroundColor3 = Color3.fromRGB(0,170,255)
	Dot.BorderSizePixel = 0

	local DotCorner = Instance.new("UICorner")
	DotCorner.CornerRadius = UDim.new(1,0)
	DotCorner.Parent = Dot

	task.spawn(function()
		local xDir = math.random(-2,2)
		local yDir = math.random(-2,2)

		while true do
			task.wait(0.03)

			local x = Dot.Position.X.Scale
			local y = Dot.Position.Y.Scale

			if x >= 0.98 then
				xDir = -math.abs(xDir)
			elseif x <= 0 then
				xDir = math.abs(xDir)
			end

			if y >= 0.98 then
				yDir = -math.abs(yDir)
			elseif y <= 0 then
				yDir = math.abs(yDir)
			end

			Dot.Position = UDim2.new(
				x + (xDir * 0.001),
				0,
				y + (yDir * 0.001),
				0
			)
		end
	end)
end

-- TITULO
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "JHOSTIN V1"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack

-- NOCLIP
local NoclipButton = Instance.new("TextButton")
NoclipButton.Parent = Frame
NoclipButton.Size = UDim2.new(0,180,0,40)
NoclipButton.Position = UDim2.new(0,20,0,50)
NoclipButton.BackgroundColor3 = Color3.fromRGB(20,20,30)
NoclipButton.TextColor3 = Color3.fromRGB(255,255,255)
NoclipButton.TextScaled = true
NoclipButton.Text = "NOCLIP OFF"
NoclipButton.Font = Enum.Font.GothamBold

local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0,8)
NoclipCorner.Parent = NoclipButton

-- CUADRO FLY
local FlyFrame = Instance.new("Frame")
FlyFrame.Parent = Frame
FlyFrame.Size = UDim2.new(0,180,0,105)
FlyFrame.Position = UDim2.new(0,20,0,105)
FlyFrame.BackgroundColor3 = Color3.fromRGB(20,20,30)
FlyFrame.BorderSizePixel = 0

local FlyFrameCorner = Instance.new("UICorner")
FlyFrameCorner.CornerRadius = UDim.new(0,8)
FlyFrameCorner.Parent = FlyFrame

-- FLY BUTTON
local FlyButton = Instance.new("TextButton")
FlyButton.Parent = FlyFrame
FlyButton.Size = UDim2.new(0,160,0,35)
FlyButton.Position = UDim2.new(0,10,0,5)
FlyButton.BackgroundColor3 = Color3.fromRGB(35,35,45)
FlyButton.TextColor3 = Color3.fromRGB(255,255,255)
FlyButton.TextScaled = true
FlyButton.Text = "FLY OFF"
FlyButton.Font = Enum.Font.GothamBold

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0,8)
FlyCorner.Parent = FlyButton

-- SPEED LABEL
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = FlyFrame
SpeedLabel.Size = UDim2.new(0,160,0,20)
SpeedLabel.Position = UDim2.new(0,10,0,45)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(0,170,255)
SpeedLabel.TextScaled = true
SpeedLabel.Text = "SPEED : "..speed
SpeedLabel.Font = Enum.Font.GothamBold

-- SPEED +
local PlusButton = Instance.new("TextButton")
PlusButton.Parent = FlyFrame
PlusButton.Size = UDim2.new(0,75,0,25)
PlusButton.Position = UDim2.new(0,10,0,72)
PlusButton.BackgroundColor3 = Color3.fromRGB(35,35,45)
PlusButton.TextColor3 = Color3.fromRGB(255,255,255)
PlusButton.TextScaled = true
PlusButton.Text = "+"

local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0,8)
PlusCorner.Parent = PlusButton

-- SPEED -
local MinusButton = Instance.new("TextButton")
MinusButton.Parent = FlyFrame
MinusButton.Size = UDim2.new(0,75,0,25)
MinusButton.Position = UDim2.new(0,95,0,72)
MinusButton.BackgroundColor3 = Color3.fromRGB(35,35,45)
MinusButton.TextColor3 = Color3.fromRGB(255,255,255)
MinusButton.TextScaled = true
MinusButton.Text = "-"

local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0,8)
MinusCorner.Parent = MinusButton

-- MOSTRAR / OCULTAR
local visible = true

ToggleButton.MouseButton1Click:Connect(function()
	visible = not visible
	Frame.Visible = visible
end)

-- SPEED
PlusButton.MouseButton1Click:Connect(function()
	if speed < maxSpeed then
		speed += 10
		SpeedLabel.Text = "SPEED : "..speed
	end
end)

MinusButton.MouseButton1Click:Connect(function()
	if speed > 10 then
		speed -= 10
		SpeedLabel.Text = "SPEED : "..speed
	end
end)

-- NOCLIP
RunService.Stepped:Connect(function()
	char = player.Character or player.CharacterAdded:Wait()

	if noclip and char then
		for _,v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

NoclipButton.MouseButton1Click:Connect(function()
	noclip = not noclip

	if noclip then
		NoclipButton.Text = "NOCLIP ON"
	else
		NoclipButton.Text = "NOCLIP OFF"

		if char then
			for _,v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = true
				end
			end
		end
	end
end)

-- FLY
FlyButton.MouseButton1Click:Connect(function()
	fly = not fly

	char = player.Character or player.CharacterAdded:Wait()
	humanoid = char:WaitForChild("Humanoid")

	local hrp = char:WaitForChild("HumanoidRootPart")

	if fly then
		FlyButton.Text = "FLY ON"

		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = Vector3.zero
		bv.Parent = hrp

		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bg.CFrame = hrp.CFrame
		bg.Parent = hrp

		humanoid.PlatformStand = true
	else
		FlyButton.Text = "FLY OFF"

		humanoid.PlatformStand = false

		if bv then
			bv:Destroy()
		end

		if bg then
			bg:Destroy()
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if fly and char then
		local hrp = char:FindFirstChild("HumanoidRootPart")

		if hrp and bv and bg then
			local cam = workspace.CurrentCamera
			local move = Vector3.zero

			if UIS:IsKeyDown(Enum.KeyCode.W) then
				move += cam.CFrame.LookVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				move -= cam.CFrame.LookVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				move -= cam.CFrame.RightVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				move += cam.CFrame.RightVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				move += Vector3.new(0,1,0)
			end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
				move -= Vector3.new(0,1,0)
			end

			bv.Velocity = move * speed
			bg.CFrame = cam.CFrame
		end
	end
end)
