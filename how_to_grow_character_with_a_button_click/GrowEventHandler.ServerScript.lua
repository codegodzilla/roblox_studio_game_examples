local RS = game:GetService("ReplicatedStorage")
local event = RS.GrowEvent

-- note: "arg2" is not doing anything at the moment, but we could sent increaseValue with it from client.
event.OnServerEvent:Connect(function(player, arg2)
  print("i am server script", player, arg2)

  local increaseValue = 1

  local humanoid = player.Character:FindFirstChild("Humanoid")

  humanoid.BodyHeightScale.Value = humanoid.BodyHeightScale.Value + increaseValue
  humanoid.BodyWidthScale.Value = humanoid.BodyWidthScale.Value + increaseValue
  humanoid.BodyDepthScale.Value = humanoid.BodyDepthScale.Value + increaseValue
  humanoid.HeadScale.Value = humanoid.HeadScale.Value + increaseValue
end)
