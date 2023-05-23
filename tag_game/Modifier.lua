local PlayersService = game:GetService("Players")

local module = {}

function cloneScripts(container1, container2)
  for _, value in ipairs(container1:GetChildren()) do
    if value:IsA("Script") or value:IsA("LocalScript") then
      value:Clone().Parent = container2
    end
  end
end

function preloadCharacter(player, position, characterModel)
  local clonedTemplate = characterModel:Clone()
  clonedTemplate:SetPrimaryPartCFrame(position)
  cloneScripts(game:GetService("StarterPlayer").StarterCharacterScripts, clonedTemplate)
  player.Character = clonedTemplate
  player.Character.Parent = workspace
end


function changeCharacter(player, characterModel, options)
  local isCopyScripts = options.isCopyScripts

  -- For immutability
  local clonedTemplate = characterModel:Clone()

  -- Make sure the player is in the same spot after transition.
  clonedTemplate:SetPrimaryPartCFrame(player.Character.PrimaryPart.CFrame)

  if isCopyScripts then
    -- Copies current animation scripts into the new model.
    cloneScripts(player.Character, clonedTemplate)
  end

  player.Character = clonedTemplate
  player.Character.Parent = workspace
end


module.changeCharacter = changeCharacter
module.preloadCharacter = preloadCharacter

return module




