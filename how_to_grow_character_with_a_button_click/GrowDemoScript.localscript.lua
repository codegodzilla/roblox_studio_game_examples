local button = script.Parent.GrowButton

local RS = game:GetService("ReplicatedStorage")
local growEvent = RS.GrowEvent

button.Activated:Connect(function()
  print('clicked me')
  growEvent:FireServer("this is argument FROM CLIENT")
end)