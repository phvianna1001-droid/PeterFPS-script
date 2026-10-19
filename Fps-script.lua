local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui")
Gui.Name = "FPSOptimizer"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "FPSCounter"
Main.Size = UDim2.new(0, 145, 0, 55)
Main.Position = UDim2.new(0, 20, 0, 80)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BackgroundTransparency = 0.12
Main.BorderSizePixel = 0
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(80, 80, 90)
Stroke.Transparency = 0.35
Stroke.Thickness = 1
Stroke.Parent = Main

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(1, -45, 1, 0)
FPSLabel.Position = UDim2.new(0, 10, 0, 0)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.Text = "FPS: 0"
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.TextSize = 18
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = Main

local MenuButton = Instance.new("TextButton")
MenuButton.Size = UDim2.new(0, 35, 0, 35)
MenuButton.Position = UDim2.new(1, -42, 0.5, -17)
MenuButton.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
MenuButton.Text = "⚙"
MenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuButton.TextSize = 18
MenuButton.Font = Enum.Font.GothamBold
MenuButton.AutoButtonColor = true
MenuButton.Parent = Main

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 9)
ButtonCorner.Parent = MenuButton

local Menu = Instance.new("Frame")
Menu.Name = "Settings"
Menu.Size = UDim2.new(0, 250, 0, 150)
Menu.Position = UDim2.new(0, 0, 1, 8)
Menu.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
Menu.BackgroundTransparency = 0.05
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.Parent = Main

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 12)
MenuCorner.Parent = Menu

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(80, 80, 90)
MenuStroke.Transparency = 0.3
MenuStroke.Parent = Menu

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 35)
Title.Position = UDim2.new(0, 10, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Melhorador de FPS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Menu

local Description = Instance.new("TextLabel")
Description.Size = UDim2.new(1, -20, 0, 35)
Description.Position = UDim2.new(0, 10, 0, 40)
Description.BackgroundTransparency = 1
Description.Text = "Reduz gráficos e efeitos visuais"
Description.TextColor3 = Color3.fromRGB(170, 170, 180)
Description.TextSize = 12
Description.Font = Enum.Font.Gotham
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.Parent = Menu

local OptimizeButton = Instance.new("TextButton")
OptimizeButton.Size = UDim2.new(1, -20, 0, 45)
OptimizeButton.Position = UDim2.new(0, 10, 1, -55)
OptimizeButton.BackgroundColor3 = Color3.fromRGB(45, 150, 75)
OptimizeButton.Text = "ATIVAR"
OptimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OptimizeButton.TextSize = 15
OptimizeButton.Font = Enum.Font.GothamBold
OptimizeButton.Parent = Menu

local OptimizeCorner = Instance.new("UICorner")
OptimizeCorner.CornerRadius = UDim.new(0, 10)
OptimizeCorner.Parent = OptimizeButton

local Optimized = false

local function OptimizeFPS()
	Optimized = true

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)

	pcall(function()
		UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
	end)

	Lighting.GlobalShadows = false
	Lighting.Brightness = 1

	for _, Object in ipairs(Lighting:GetChildren()) do
		if Object:IsA("BloomEffect")
			or Object:IsA("BlurEffect")
			or Object:IsA("ColorCorrectionEffect")
			or Object:IsA("SunRaysEffect")
			or Object:IsA("DepthOfFieldEffect") then
			Object.Enabled = false
		end
	end

	for _, Object in ipairs(Workspace:GetDescendants()) do
		if Object:IsA("ParticleEmitter")
			or Object:IsA("Trail")
			or Object:IsA("Beam") then

			Object.Enabled = false

		elseif Object:IsA("Smoke")
			or Object:IsA("Fire")
			or Object:IsA("Sparkles") then

			Object.Enabled = false

		elseif Object:IsA("Decal") or Object:IsA("Texture") then
			Object.Transparency = 1

		elseif Object:IsA("PointLight")
			or Object:IsA("SpotLight")
			or Object:IsA("SurfaceLight") then

			Object.Enabled = false
		end
	end

	OptimizeButton.Text = "ATIVADO"
	OptimizeButton.BackgroundColor3 = Color3.fromRGB(35, 110, 55)
end

local function RestoreFPS()
	Optimized = false

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end)

	pcall(function()
		UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.Automatic
	end)

	OptimizeButton.Text = "ATIVAR"
	OptimizeButton.BackgroundColor3 = Color3.fromRGB(45, 150, 75)
end

OptimizeButton.MouseButton1Click:Connect(function()
	if Optimized then
		RestoreFPS()
	else
		OptimizeFPS()
	end
end)

MenuButton.MouseButton1Click:Connect(function()
	Menu.Visible = not Menu.Visible
end)

local dragging = false
local dragStart
local startPosition

local function UpdateDrag(Input)
	local Delta = Input.Position - dragStart

	Main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + Delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + Delta.Y
	)
end

Main.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = Input.Position
		startPosition = Main.Position

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(Input)
	if dragging and (
		Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch
	) then
		UpdateDrag(Input)
	end
end)

local Frames = 0
local LastTime = tick()

RunService.RenderStepped:Connect(function()
	Frames += 1

	local CurrentTime = tick()

	if CurrentTime - LastTime >= 0.5 then
		local FPS = math.floor(Frames / (CurrentTime - LastTime))

		FPSLabel.Text = "FPS: " .. FPS

		Frames = 0
		LastTime = CurrentTime
	end
end)
