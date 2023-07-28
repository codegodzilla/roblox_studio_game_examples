
local SCORE_NAME = "Worms"

function createTwoParts(
  height1, height2, width, thickness, zPos, capSize, index,
  touchedEventHandler
)
  local part1 = Instance.new("Part")
  part1.Size = Vector3.new(thickness, height1, width)
  part1.Position = Vector3.new(0, height1/2, zPos)
  part1.BrickColor = BrickColor.new("Bright green")
  part1.Anchored = true
  part1.Name = "wall-bottom-" .. index
  part1.Parent = workspace

  local part2 = Instance.new("Part")
  part2.Size = Vector3.new(thickness, height2, width)
  part2.Position = Vector3.new(0, height1 + height2/2 + capSize, zPos)
  part2.BrickColor = BrickColor.new("Bright red")
  part2.Anchored = true
  part2.Name = "wall-top-" .. index
  part2.Parent = workspace

  part1.Touched:Connect(touchedEventHandler)
  part2.Touched:Connect(touchedEventHandler)
end

function getHighestIndexPart()
  local highestIndex = 0
  local highestIndexPart = nil

  for _, part in pairs(workspace:GetChildren()) do
    if part:IsA("BasePart") then
      local partName = part.Name
      local index = tonumber(partName:match("%d+$"))

      if index and index > highestIndex then
        highestIndex = index
        highestIndexPart = part
      end
    end
  end

  return highestIndexPart
end

function onWallTouch(part)
  local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
  local character = humanoid.Parent
  local player = game.Players:GetPlayerFromCharacter(character)
  if humanoid then
    humanoid.Health = 0
    resetScore(player)
  end
end

local numberOfWalls = 3
local zPos = 0

for i = 1, numberOfWalls do
  local height1 = math.random(20, 100)
  local height2 = math.random(20, 100)

  createTwoParts(
    height1, height2, 20, 100, zPos, 20, i,
    onWallTouch
  )

  zPos = zPos + 100
end

function tweenWorm(wormPart)
  local tweenService = game:GetService("TweenService")
  local tweenInfo = TweenInfo.new(
    1, -- duration
    Enum.EasingStyle.Linear, -- easing style
    Enum.EasingDirection.Out, -- easing direction
    -1, -- repeat count (-1 for infinite)
    true, -- reverses
    0 -- delay
  )

  local upPosition = wormPart.Position + Vector3.new(0, 3, 0)
  local downPosition = wormPart.Position

  local upTween = tweenService:Create(wormPart, tweenInfo, {Position = upPosition})
  local downTween = tweenService:Create(wormPart, tweenInfo, {Position = downPosition})

  upTween.Completed:Connect(function()
    downTween:Play()
  end)

  downTween.Completed:Connect(function()
    upTween:Play()
  end)

  upTween:Play()
end

function onWormTouch(wormPart, touchingPart)
  local character = touchingPart.Parent
  local player = game.Players:GetPlayerFromCharacter(character)

  if not player:FindFirstChild("leaderstats") then
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
  end

  if not player.leaderstats:FindFirstChild(SCORE_NAME) then
    local score = Instance.new("IntValue")
    score.Name = SCORE_NAME
    score.Parent = player.leaderstats
  end

  player.leaderstats[SCORE_NAME].Value = player.leaderstats[SCORE_NAME].Value + 1

  local soundService = game:GetService("SoundService")
  local scoreSound = soundService:FindFirstChild("score")

  if scoreSound then
    scoreSound:Play()
  end

  wormPart.CanTouch = false
  wormPart.Transparency = 1
  wait(2)
  wormPart.CanTouch = true
  wormPart.Transparency = 0
end

function resetScore(player)
  if player:FindFirstChild("leaderstats") == nil then
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    local score = Instance.new("IntValue")
    score.Name = SCORE_NAME
    score.Value = 0
    score.Parent = leaderstats
  else
    player.leaderstats[SCORE_NAME].Value = 0
  end
end

function getPlayerScore(player)
  local leaderstats = player:FindFirstChild("leaderstats")
  if leaderstats == nil then
    return 0
  else
    local score = leaderstats:FindFirstChild(SCORE_NAME)
    if score == nil then
      return 0
    else
      return score.Value
    end
  end
end

function createWorms()
  local parts = {}
  for _, part in ipairs(workspace:GetChildren()) do
    if string.match(part.Name, "wall%-bottom%-%d+") then
      table.insert(parts, part)
    end
  end

  local worm = game.Workspace.worm:Clone()

  for _, part in ipairs(parts) do
    local newWorm = worm:Clone()
    newWorm.Position = part.Position + Vector3.new(
      0, part.Size.Y/2 + newWorm.Size.Y/2 + 10, 0
    )
    newWorm.Parent = workspace

    tweenWorm(newWorm)

    newWorm.Touched:Connect(function(touchingPart)
      onWormTouch(newWorm, touchingPart)
    end)
  end

  return parts
end

function moveBirdNest()
  local highestIndexPart = getHighestIndexPart()
  local birdNest = workspace.BirdNest
  birdNest:MoveTo(highestIndexPart.Position)
end

function setupBirdNestTouchedListener()
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local GameEndedEvent = ReplicatedStorage:WaitForChild("GameEndedEvent")
  local Workspace = game:GetService("Workspace")
  local birdNest = Workspace:WaitForChild("BirdNest")

  birdNest.Bird.Touched:Connect(function(part)
    local player = game.Players:GetPlayerFromCharacter(part.Parent)
    if player then
      GameEndedEvent:FireClient(player, getPlayerScore(player))
    end
  end)
end

function teleportToStart(player)
  local spawnLocation = workspace:FindFirstChild("SpawnLocation")
  local character = player.Character
  character:SetPrimaryPartCFrame(spawnLocation.CFrame)
end

function setupPlayAgainListener()
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local PlayAgainEvent = ReplicatedStorage:WaitForChild("PlayAgainEvent")
  PlayAgainEvent.OnServerEvent:Connect(function(player)
    teleportToStart(player)
    resetScore(player)
  end)
end

createWorms()
moveBirdNest()
setupBirdNestTouchedListener()
setupPlayAgainListener()


