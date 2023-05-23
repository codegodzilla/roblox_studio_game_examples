local collisionBox = script.Parent.CollisionBox
local Modifier = require(game.ServerStorage.Modifier)
local marioCharacter = collisionBox.Parent

local visualEffects = require(game:GetService("ReplicatedStorage").VisualEffects)

-- Note: Only Mario has collision box script, other chracters do not!

-- On load, touched event must be disabled,
-- because otherwise characters will immediately switch back,
-- because after characters switch, they are still touching each other.

local isTouchedEnabled = false

delay(3, function()
  isTouchedEnabled = true
end)

-- Returns player who is controlling Mario character.
function getMarioPlayer()
  return game.Players:GetPlayerFromCharacter(marioCharacter)
end

-- Checks if someone touched the collision box.
--   and if touched, then change characters.
function onTouched(otherPart)

  if not isTouchedEnabled then
    return
  end

  -- Makes sure only Humanoid touched triggers it.
  if not otherPart.Parent:FindFirstChild("Humanoid") then
    return
  end

  local touchedPlayer = game.Players:GetPlayerFromCharacter(otherPart.Parent)

  if touchedPlayer == nil then
    return
  end

  -- Makes sure event is disabled after touch.
  isTouchedEnabled = false

  visualEffects.createVfx(touchedPlayer.Character.HumanoidRootPart.CFrame)

  local clonedTouchedCharacter = touchedPlayer.Character:Clone()
  local marioPlayer = getMarioPlayer(touchedPlayer.Character)

  Modifier.changeCharacter(touchedPlayer, marioCharacter, {
    isCopyScripts = false
  })

  Modifier.changeCharacter(marioPlayer, clonedTouchedCharacter, {
    isCopyScripts = false
  })


end

collisionBox.Touched:Connect(onTouched)