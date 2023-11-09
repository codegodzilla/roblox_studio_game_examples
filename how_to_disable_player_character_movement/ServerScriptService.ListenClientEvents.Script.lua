local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DisableMovementEvent = ReplicatedStorage.DisableMovementEvent
local EnableMovementEvent = ReplicatedStorage.EnableMovementEvent

DisableMovementEvent.OnServerEvent:Connect(function(player)
  print("Received event disable", player)
  local character = player.Character
  local humanoid = character:WaitForChild('Humanoid')

  local originalWalkSpeed = Instance.new("IntValue")
  originalWalkSpeed.Value = humanoid.WalkSpeed
  originalWalkSpeed.Parent = humanoid
  originalWalkSpeed.Name = "originalWalkSpeed"

  local originalJumpHeight = Instance.new("IntValue")
  originalJumpHeight.Value = humanoid.JumpHeight
  originalJumpHeight.Parent = humanoid
  originalJumpHeight.Name = "originalJumpHeight"

  humanoid.WalkSpeed = 0
  humanoid.JumpHeight = 0
end)

EnableMovementEvent.OnServerEvent:Connect(function(player)
  local character = player.Character
  local humanoid = character:WaitForChild('Humanoid')

  local originalWalkSpeed = humanoid.originalWalkSpeed
  local originalJumpHeight = humanoid.originalJumpHeight

  humanoid.WalkSpeed = originalWalkSpeed.Value
  humanoid.JumpHeight = originalJumpHeight.Value
end)