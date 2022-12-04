local function createLeaderstats(player)
  local leaderstats = Instance.new("Folder")
  leaderstats.Name = "leaderstats"
  leaderstats.Parent = player

  local score = Instance.new("IntValue")
  score.Name = "Score"
  score.Value = 0
  score.Parent = leaderstats
end

game.Players.PlayerAdded:Connect(function(player)
  createLeaderstats(player)
end)

local function randomNumber(min, max)
  return math.random(min, max)
end

local function createPart(name, size, position)
  local part = Instance.new("Part")
  part.Name = name
  part.Size = size
  part.Position = position
  part.Anchored = true
  part.BrickColor = BrickColor.random()
  part.Parent = game.Workspace

  local gui = Instance.new("BillboardGui")
  gui.Name = name.."Gui"
  gui.Size = UDim2.new(1, 0, 1, 0)
  gui.StudsOffset = Vector3.new(0, 3, 0)
  gui.Parent = part

  local text = Instance.new("TextLabel")
  text.Name = name.."Label"
  text.Text = name
  text.Size = UDim2.new(1, 0, 1, 0)
  text.Position = UDim2.new(0, 0, 0, 1)
  text.Parent = gui

  part.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    player.leaderstats.Score.Value = player.leaderstats.Score.Value + 1
    part:Destroy()
  end)
end

for i = 1, 25 do
  local x = randomNumber(1, 100)
  local y = 0
  local z = randomNumber(1, 100)
  createPart(tostring(i), Vector3.new(2, 2, 2), Vector3.new(x, y, z))
end
