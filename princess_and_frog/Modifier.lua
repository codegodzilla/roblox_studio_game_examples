
local module = {}

-- copies scripts from from one model to another
function copyScripts(fromModel, toModel)
  for _, child in ipairs(fromModel:GetChildren()) do
    if child:IsA("Script") then
      local newScript = child:Clone()
      newScript.Parent = toModel
    end
  end
end

-- parents all children to target.
function parentTo(children, target)
  for _, child in pairs(children) do
    child.Parent = target
  end
end

function switchCharacterOfNpc(oldCharacter, newCharacter, position)
  print(oldCharacter, newCharacter, position)
  local newCharacter = newCharacter:Clone()
  newCharacter:SetPrimaryPartCFrame(position)
  copyScripts(oldCharacter,newCharacter )
  oldCharacter:Destroy()
  newCharacter.Parent = workspace
end

function preloadCharacter(player,
                          position, templateModel, scripts
)
  local newCharacter = templateModel:Clone()

  newCharacter:SetPrimaryPartCFrame(position)

  parentTo(scripts, newCharacter)

  player.Character = newCharacter
  player.Character.Parent = workspace
end

module.preloadCharacter = preloadCharacter
module.switchCharacterOfNpc = switchCharacterOfNpc

return module




