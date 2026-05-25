--// 🔥 JHOSTIN PREMIUM V5.2 (EDICIÓN PREMIUM REPARADA) 🔥
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
local PlayersService = game:GetService("Players") -- Fixed! Corregido el servicio principal

-- Actualizar personaje automáticamente al morir/reaparecer
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = newChar:WaitForChild("Humanoid")
end)

-- VARIABLES DE CONTROL
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
local visualMarker = nil 
local selectedTargetPlayer = nil
local bv
local bg

-- ANTI AFK AUTOMÁTICO
player.Idled:Connect(function()
    if AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- SCREEN GUI DE LA INTERFAZ
local gui = Instance.new("ScreenGui")
gui.Name = "JHOSTIN_PREMIUM"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- BOTON ENTRADA / CERRAR MENÚ (Estilo Calavera Minimalista)
local toggle = Instance.new("TextButton")
toggle.Parent = gui
toggle.Size = UDim2.new(0,55,0,55)
toggle.Position = UDim2.new(0,15,0.4,0)
toggle.Text = "💀"
toggle.TextScaled = true
toggle.Font = Enum.Font.GothamBlack
toggle.BackgroundColor3 = Color3.fromRGB(15,15,20)
toggle.TextColor3 = Color3.fromRGB(255, 0, 100)
toggle.Active = true
toggle.Draggable = true
toggle.ZIndex = 10
Instance.new("UICorner", toggle).CornerRadius = UDim.new(1,0)
local toggleStroke = Instance.new("UIStroke",toggle)
toggleStroke.Color = Color3.fromRGB(255, 0, 100)
toggleStroke.Thickness = 2

-- PANEL NEGRO PRINCIPAL MATE
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 480, 0, 360)
frame.Position = UDim2.new(0.1, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
frame.Active = true
frame.Draggable = true
frame.Visible = true -- Abre abierto por defecto para comprobar que funciona
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(40, 40, 50)
stroke.Thickness = 1.5

toggle.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    toggle.Text = frame.Visible and "❌" or "💀"
end)

-- ==========================================
-- 📁 BARRA LATERAL IZQUIERDA (SIDEBAR)
-- ==========================================
local sidebar = Instance.new("Frame")
sidebar.Parent = frame
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)

local sideFix = Instance.new("Frame", sidebar)
sideFix.Size = UDim2.new(0, 15, 1, 0)
sideFix.Position = UDim2.new(1, -15, 0, 0)
sideFix.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
sideFix.BorderSizePixel = 0

local sideLine = Instance.new("Frame", frame)
sideLine.Size = UDim2.new(0, 1, 1, 0)
sideLine.Position = UDim2.new(0, 130, 0, 0)
sideLine.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
sideLine.BorderSizePixel = 0

local sideTitle = Instance.new("TextLabel", sidebar)
sideTitle.Size = UDim2.new(1, 0, 0, 50)
sideTitle.Position = UDim2.new(0, 0, 0, 10)
sideTitle.BackgroundTransparency = 1
sideTitle.Text = "JHOSTIN\nPREMIUM"
sideTitle.TextSize = 13
sideTitle.Font = Enum.Font.GothamBlack
sideTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local navList = Instance.new("Frame", sidebar)
navList.Size = UDim2.new(1, 0, 1, -70)
navList.Position = UDim2.new(0, 0, 0, 70)
navList.BackgroundTransparency = 1

local navLayout = Instance.new("UIListLayout", navList)
navLayout.Padding = UDim.new(0, 8)
navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ==========================================
-- 📂 PANELES DE CONTENIDO DERECHO
-- ==========================================
local contentFrame = Instance.new("Frame", frame)
contentFrame.Size = UDim2.new(1, -145, 1, -20)
contentFrame.Position = UDim2.new(0, 145, 0, 10)
contentFrame.BackgroundTransparency = 1

local playerSection = Instance.new("ScrollingFrame", contentFrame)
playerSection.Size = UDim2.new(1, 0, 1, 0)
playerSection.BackgroundTransparency = 1
playerSection.ScrollBarThickness = 4
playerSection.CanvasSize = UDim2.new(0, 0, 0, 440)

local teleportSection = Instance.new("ScrollingFrame", contentFrame)
teleportSection.Size = UDim2.new(1, 0, 1, 0)
teleportSection.BackgroundTransparency = 1
teleportSection.ScrollBarThickness = 4
teleportSection.CanvasSize = UDim2.new(0, 0, 0, 400)
teleportSection.Visible = false

local fpsSection = Instance.new("ScrollingFrame", contentFrame)
fpsSection.Size = UDim2.new(1, 0, 1, 0)
fpsSection.BackgroundTransparency = 1
fpsSection.ScrollBarThickness = 4
fpsSection.CanvasSize = UDim2.new(0, 0, 0, 300)
fpsSection.Visible = false

local function createTabBtn(text)
    local btn = Instance.new("TextButton", navList)
    btn.Size = UDim2.new(0, 110, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local bStroke = Instance.new("UIStroke", btn)
    bStroke.Color = Color3.fromRGB(35, 35, 45)
    return btn
end

local playerTabBtn = createTabBtn("👤 PLAYER")
local tpTabBtn = createTabBtn("🌀 TELEPORT")
local fpsTabBtn = createTabBtn("🚀 FPS / SYS")

local function switchTab(activeSection, activeBtn)
    playerSection.Visible = (activeSection == playerSection)
    teleportSection.Visible = (activeSection == teleportSection)
    fpsSection.Visible = (activeSection == fpsSection)
    
    for _, btn in pairs({playerTabBtn, tpTabBtn, fpsTabBtn}) do
        btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
        btn.TextColor3 = Color3.fromRGB(160, 160, 170)
        btn.UIStroke.Color = Color3.fromRGB(35, 35, 45)
    end
    
    activeBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 45)
    activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activeBtn.UIStroke.Color = Color3.fromRGB(255, 0, 100)
end

playerTabBtn.MouseButton1Click:Connect(function() switchTab(playerSection, playerTabBtn) end)
tpTabBtn.MouseButton1Click:Connect(function() switchTab(teleportSection, tpTabBtn) end)
fpsTabBtn.MouseButton1Click:Connect(function() switchTab(fpsSection, fpsTabBtn) end)

switchTab(playerSection, playerTabBtn)

local function createOptionButton(parent, text, yPos, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Text = text
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color or Color3.fromRGB(20, 20, 28)
    btn.TextColor3 = Color3.fromRGB(230, 230, 235)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local st = Instance.new("UIStroke", btn)
    st.Color = Color3.fromRGB(40, 40, 50)
    return btn
end

-- ==========================================
-- 👤 CONTENIDO: PLAYER
-- ==========================================
local noclipBtn = createOptionButton(playerSection, "👻 NOCLIP: DESACTIVADO", 0)
local flyBtn = createOptionButton(playerSection, "✈️ VOLAR: DESACTIVADO", 45)

local flyLabel = Instance.new("TextLabel", playerSection)
flyLabel.Size = UDim2.new(1, -10, 0, 25)
flyLabel.Position = UDim2.new(0, 0, 0, 95)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "VELOCIDAD DE VUELO: " .. flySpeed
flyLabel.TextSize = 11
flyLabel.Font = Enum.Font.GothamBold
flyLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
flyLabel.TextXAlignment = Enum.TextXAlignment.Left

local flyPlus = createOptionButton(playerSection, "➕ AUMENTAR VUELO", 120)
local flyMinus = createOptionButton(playerSection, "➖ DISMINUIR VUELO", 160)

local walkLabel = Instance.new("TextLabel", playerSection)
walkLabel.Size = UDim2.new(1, -10, 0, 25)
walkLabel.Position = UDim2.new(0, 0, 0, 210)
walkLabel.BackgroundTransparency = 1
walkLabel.Text = "VELOCIDAD DE CAMINADO: " .. walkSpeed
walkLabel.TextSize = 11
walkLabel.Font = Enum.Font.GothamBold
walkLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
walkLabel.TextXAlignment = Enum.TextXAlignment.Left

local walkPlus = createOptionButton(playerSection, "🏃 VELOCIDAD +", 235)
local walkMinus = createOptionButton(playerSection, "🐢 VELOCIDAD -", 275)
local sprintBtn = createOptionButton(playerSection, "⚡ SPRINT MANUAL: OFF", 315)

task.spawn(function()
    while true do
        task.wait(0.1)
        if noclip and player.Character then
            for _,v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
            end
        end
    end
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = noclip and "👻 NOCLIP: ACTIVADO" or "👻 NOCLIP: DESACTIVADO"
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
        flyBtn.Text = "✈️ VOLAR: ACTIVADO"
    else
        humanoid.PlatformStand = false
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        flyBtn.Text = "✈️ VOLAR: DESACTIVADO"
    end
end)

RunService.RenderStepped:Connect(function()
    if fly and char then
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

flyPlus.MouseButton1Click:Connect(function() if flySpeed < maxFlySpeed then flySpeed += 20 flyLabel.Text = "VELOCIDAD DE VUELO: "..flySpeed end end)
flyMinus.MouseButton1Click:Connect(function() if flySpeed > 20 then flySpeed -= 20 flyLabel.Text = "VELOCIDAD DE VUELO: "..flySpeed end end)
walkPlus.MouseButton1Click:Connect(function() if walkSpeed < maxWalkSpeed then walkSpeed += 50 if humanoid then humanoid.WalkSpeed = walkSpeed end walkLabel.Text = "VELOCIDAD DE CAMINADO: "..walkSpeed end end)
walkMinus.MouseButton1Click:Connect(function() if walkSpeed > 16 then walkSpeed -= 50 if humanoid then humanoid.WalkSpeed = walkSpeed end walkLabel.Text = "VELOCIDAD DE CAMINADO: "..walkSpeed end end)
sprintBtn.MouseButton1Click:Connect(function()
    sprintOn = not sprintOn
    if humanoid then humanoid.WalkSpeed = sprintOn and walkSpeed or 16 end
    sprintBtn.Text = sprintOn and "⚡ SPRINT MANUAL: ON" or "⚡ SPRINT MANUAL: OFF"
end)


-- ==========================================
-- 🌀 CONTENIDO: TELEPORT (100% REPARADO)
-- ==========================================
local markBtn = createOptionButton(teleportSection, "📍 FIJAR / MARCAR POSICIÓN", 0)
local tpBtn = createOptionButton(teleportSection, "🌀 TELETRANSPORTE A MI MARCA", 45)

local lineDiv = Instance.new("Frame", teleportSection)
lineDiv.Size = UDim2.new(1, -10, 0, 1)
lineDiv.Position = UDim2.new(0, 0, 0, 95)
lineDiv.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
lineDiv.BorderSizePixel = 0

local playerDropdownBtn = createOptionButton(teleportSection, "      👤 SELECCIONAR JUGADOR", 110)

local avatarImage = Instance.new("ImageLabel", playerDropdownBtn)
avatarImage.Size = UDim2.new(0, 24, 0, 24)
avatarImage.Position = UDim2.new(0, 8, 0.5, -12)
avatarImage.BackgroundColor3 = Color3.fromRGB(30,30,40)
avatarImage.Image = "rbxassetid://13471012920"
Instance.new("UICorner", avatarImage).CornerRadius = UDim.new(1, 0)

local tpToPlayerBtn = createOptionButton(teleportSection, "⚡ IR AL JUGADOR SELECCIONADO", 155, Color3.fromRGB(0, 90, 220))

local dropdownList = Instance.new("ScrollingFrame", teleportSection)
dropdownList.Size = UDim2.new(1, -10, 0, 120)
dropdownList.Position = UDim2.new(0, 0, 0, 205)
dropdownList.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
dropdownList.ZIndex = 30
dropdownList.Visible = false
dropdownList.ScrollBarThickness = 4
Instance.new("UICorner", dropdownList).CornerRadius = UDim.new(0, 6)
local dropdownStroke = Instance.new("UIStroke", dropdownList)
dropdownStroke.Color = Color3.fromRGB(45, 45, 55)

local listLayout = Instance.new("UIListLayout", dropdownList)
listLayout.Padding = UDim.new(0, 4)

local function updateDropdown()
    for _, child in pairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in pairs(PlayersService:GetPlayers()) do
        if p ~= player then
            local pBtn = Instance.new("TextButton", dropdownList)
            pBtn.Size = UDim2.new(1, -8, 0, 30)
            pBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            pBtn.Text = "     " .. p.Name
            pBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
            pBtn.Font = Enum.Font.GothamBold
            pBtn.TextSize = 11
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            pBtn.ZIndex = 31
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 5)
            
            local smallImg = Instance.new("ImageLabel", pBtn)
            smallImg.Size = UDim2.new(0, 22, 0, 22)
            smallImg.Position = UDim2.new(0, 5, 0.5, -11)
            smallImg.BackgroundTransparency = 1
            smallImg.ZIndex = 32
            Instance.new("UICorner", smallImg).CornerRadius = UDim.new(1,0)
            
            task.spawn(function()
                pcall(function()
                    local content, isReady = PlayersService:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                    if isReady then smallImg.Image = content end
                end)
            end)
            
            pBtn.MouseButton1Click:Connect(function()
                selectedTargetPlayer = p
                playerDropdownBtn.Text = "      👤: " .. p.Name
                avatarImage.Image = smallImg.Image
                dropdownList.Visible = false
            end)
        end
    end
    dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end

playerDropdownBtn.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
    if dropdownList.Visible then updateDropdown() end
end)

tpToPlayerBtn.MouseButton1Click:Connect(function()
    if selectedTargetPlayer and selectedTargetPlayer.Parent then
        local targetChar = selectedTargetPlayer.Character
        if targetChar then
            local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
            local myHrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            
            if targetHrp and myHrp then
                myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 3)
            end
        else
            playerDropdownBtn.Text = "      ❌ JUGADOR SIN PERSONAJE"
            task.wait(1)
            playerDropdownBtn.Text = "      👤: " .. selectedTargetPlayer.Name
        end
    else
        playerDropdownBtn.Text = "      ❌ SELECCIONA UN JUGADOR"
        avatarImage.Image = "rbxassetid://13471012920"
        task.wait(1.5)
        playerDropdownBtn.Text = "      👤 SELECCIONAR JUGADOR"
    end
end)

markBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        savedPos = hrp.Position
        if visualMarker then visualMarker:Destroy() end
        
        visualMarker = Instance.new("Part")
        visualMarker.Name = "Jhostin_TP_Marker"
        visualMarker.Size = Vector3.new(2, 2, 2)
        visualMarker.Position = savedPos
        visualMarker.Shape = Enum.PartType.Ball
        visualMarker.Material = Enum.Material.Neon
        visualMarker.Color = Color3.fromRGB(255, 0, 100) 
        visualMarker.Transparency = 0.5
        visualMarker.Anchored = true
        visualMarker.CanCollide = false
        visualMarker.Parent = workspace
        
        local box = Instance.new("SelectionBox")
        box.Adornee = visualMarker
        box.Color3 = Color3.fromRGB(255, 255, 255)
        box.LineThickness = 0.03
        box.Parent = visualMarker
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and savedPos then hrp.CFrame = CFrame.new(savedPos + Vector3.new(0, 3, 0)) end
end)


-- ==========================================
-- 🚀 CONTENIDO: FPS & SISTEMA
-- ==========================================
local fpsLabel = Instance.new("TextLabel", fpsSection)
fpsLabel.Size = UDim2.new(1, -10, 0, 36)
fpsLabel.Position = UDim2.new(0, 0, 0, 0)
fpsLabel.BackgroundColor3 = Color3.fromRGB(15, 22, 18)
fpsLabel.TextColor3 = Color3.fromRGB(0, 210, 90)
fpsLabel.TextSize = 13
fpsLabel.Font = Enum.Font.GothamBlack
Instance.new("UICorner", fpsLabel).CornerRadius = UDim.new(0, 6)
local fpsStroke = Instance.new("UIStroke", fpsLabel)
fpsStroke.Color = Color3.fromRGB(25, 45, 30)

local fpsBtn = createOptionButton(fpsSection, "🚀 OPTIMIZAR TEXTURAS (FPS BOOST): OFF", 45)
local afkBtn = createOptionButton(fpsSection, "😴 ANTI-AFK SISTEMA: ACTIVO", 90)

local fpsFrames = 0
local fpsTime = tick()
RunService.RenderStepped:Connect(function()
    fpsFrames += 1
    if tick() - fpsTime >= 1 then
        fpsLabel.Text = "MONITOR RENDIMIENTO: "..fpsFrames.." FPS"
        fpsFrames = 0
        fpsTime = tick()
    end
end)

fpsBtn.MouseButton1Click:Connect(function()
    FPSBoost = not FPSBoost
    fpsBtn.Text = FPSBoost and "🚀 OPTIMIZAR TEXTURAS (FPS BOOST): ON" or "🚀 OPTIMIZAR TEXTURAS (FPS BOOST): OFF"
    if FPSBoost then
        Lighting.GlobalShadows = false
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.Plastic v.Reflectance = 0 end
        end
    end
end)

afkBtn.MouseButton1Click:Connect(function()
    AntiAFK = not AntiAFK
    afkBtn.Text = AntiAFK and "😴 ANTI-AFK SISTEMA: ACTIVO" or "💀 ANTI-AFK SISTEMA: APAGADO"
end)

print("🔥 JHOSTIN V5.2 CARGADO CON ÉXITO")
