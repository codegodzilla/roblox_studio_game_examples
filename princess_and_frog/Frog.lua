
local Frog = {
  isPrince = false,
  model = nil,
}

function Frog:new(o)
  local frog = o or {}
  local meta = self
  setmetatable(frog, meta)
  self.__index = self
  return frog
end

function Frog:setModel(model)
  self.model = model
  return self
end

function Frog:setIsPrince(isPrince)
  self.isPrince = isPrince
  return self
end

function Frog:getModel()
  return self.model
end

function Frog:getCFrame()
  return self:getModel().PrimaryPart.CFrame
end

function Frog:createAtCFrame(cframe)
  local frog = self:getModel()
  frog.PrimaryPart = frog.Torso
  frog:SetPrimaryPartCFrame(cframe)
  frog.Parent = workspace
  self:_createProximityPrompt(frog)
  return self
end

function Frog:onKiss(player)
  -- this must be overwriten by parent script
  error("not implemented onKiss")
end

function Frog:_createProximityPrompt(frog)
  local prompt = Instance.new("ProximityPrompt")
  prompt.Parent = frog.Torso
  prompt.MaxActivationDistance = 10
  prompt.ActionText = "Kiss"
  prompt.HoldDuration = 1
  prompt.KeyboardKeyCode = Enum.KeyCode.E
  prompt.Enabled = true
  prompt.RequiresLineOfSight = false
  prompt.Triggered:Connect(function(player)
    self:onKiss(player)
  end)
end

return Frog;