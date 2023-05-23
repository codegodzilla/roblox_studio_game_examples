local Players = game:getService("Players")
local Modifier = require(game:GetService("ServerStorage").Modifier)
local Mario = game.Workspace.character_templates.Mario
local Knight = game.Workspace.character_templates.Knight

game.Players.CharacterAutoLoads = false

local playerCount = 0
Players.PlayerAdded:connect(function(player)
  playerCount = playerCount + 1
  -- makes sure character spawn not on top of each other.
  local position = CFrame.new(playerCount * 4,8,0)
  -- only one starts of as Mario
  if playerCount == 1 then
    Modifier.preloadCharacter(player, position, Mario)
  else
    Modifier.preloadCharacter(player, position, Knight)
  end
end)