local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GameCompletedGui"
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BorderColor3 = Color3.new(0, 0, 0)
Frame.BackgroundTransparency = 1
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1 -- invisible
TextLabel.Text = "Game completed"
TextLabel.TextColor3 = Color3.new(1, 1, 0)
TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
TextLabel.TextSize = 48
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextStrokeTransparency = 0
TextLabel.Parent = Frame

local ScoreLabel = Instance.new("TextLabel")
ScoreLabel.Size = UDim2.new(1, 0, 0.5, 0)
ScoreLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ScoreLabel.BackgroundTransparency = 1 -- invisible
ScoreLabel.TextColor3 = Color3.new(1, 1, 1)
ScoreLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
ScoreLabel.TextSize = 24
ScoreLabel.Font = Enum.Font.GothamBold
ScoreLabel.TextStrokeTransparency = 0
ScoreLabel.Parent = Frame

local TextButton = Instance.new("TextButton")
TextButton.Size = UDim2.new(1, 0, 0.5, 0)
TextButton.BackgroundColor3 = Color3.new(0, 0.635294, 0)
TextButton.Text = "Play again"
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.Parent = Frame
TextButton.TextSize = 16
TextButton.Font = Enum.Font.GothamBold

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = TextButton

TextLabel.Position = UDim2.new(0, 0, 0, 0)
ScoreLabel.Position = UDim2.new(0, 0, 0.5, 0)
TextButton.Position = UDim2.new(0, 0, 1, 0)

ScoreLabel.Text = "You collected 69 worms."
ScreenGui.Enabled = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEndedEvent = ReplicatedStorage:WaitForChild("GameEndedEvent")
local PlayAgainEvent = ReplicatedStorage:WaitForChild("PlayAgainEvent")

TextButton.Activated:Connect(function()
  local PlayAgainEvent = ReplicatedStorage:WaitForChild("PlayAgainEvent")
  PlayAgainEvent:FireServer()
  ScreenGui.Enabled = false
end)

GameEndedEvent.OnClientEvent:Connect(function(score)
  ScoreLabel.Text = "You collected " .. score .. " worms."
  ScreenGui.Enabled = true
end)

