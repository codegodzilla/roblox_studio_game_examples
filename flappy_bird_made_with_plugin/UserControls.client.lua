
local PlayerModule = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule)
local controls = PlayerModule:GetControls()
controls:Disable()

function moveTowardsDestination(humanoid)
  local highestIndex = 0
  local highestPart = nil

  for _, part in ipairs(workspace:GetChildren()) do
    if string.match(part.Name, "wall%-top%-%d+") then
      local index = tonumber(string.match(part.Name, "%d+"))
      if index > highestIndex then
        highestIndex = index
        highestPart = part
      end
    end
  end

  if highestPart then
    humanoid:MoveTo(highestPart.Position)
  end
end

function jump()
  local player = game.Players.LocalPlayer
  local character = player.Character
  local humanoid = character:WaitForChild("Humanoid")

  local animation = character.animations.FlyOneTime

  local sound = game:GetService("SoundService").one_fly_wing
  sound:Play()

  local track = humanoid:LoadAnimation(animation)
  track:Play()

  humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

  moveTowardsDestination(humanoid)

end

game:GetService("UserInputService").InputBegan:Connect(function(input)
  if input.KeyCode == Enum.KeyCode.Space then
    jump()
  end
end)
