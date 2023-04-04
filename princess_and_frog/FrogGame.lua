local Frog = require(script.Frog)

local function checkDependencies(dependencies)
  assert(dependencies.changeCharacterMethod, "Missing changeCharacterMethod dependency")
  assert(dependencies.kissVisualEffect, "Missing kissVisualEffect dependency")
  assert(dependencies.transformSound, "Missing transformSound dependency")
  assert(dependencies.croakSound, "Missing croakSound dependency")
  assert(dependencies.frogModelTemplate, "Missing frogModelTemplate dependency")
  assert(dependencies.princeModelTemplate, "Missing princeModelTemplate dependency")
end

local FrogGame = {}

function FrogGame:new(dependencies)
  checkDependencies(dependencies)
  local manager = setmetatable({}, self)
  self.__index = self
  manager.dependencies = dependencies
  manager.frogs = {}
  return manager
end

function FrogGame:injurePlayerFromFrog(player)
  player.Character.Humanoid:TakeDamage(100)
end

function FrogGame:transformToFrogPrince(frog)
  local cFrameOfFrog = frog:getCFrame()
  self.dependencies.transformSound:Play()
  self.dependencies.kissVisualEffect(cFrameOfFrog)
  self.dependencies.changeCharacterMethod(
    frog:getModel(),
    self.dependencies.princeModelTemplate,
    frog:getCFrame() + Vector3.new(0, 4, 0)
  )
end

function FrogGame:createFrogAtCFrame(cframe)
  local frog = Frog:new()
                   :setModel(self.dependencies.frogModelTemplate:Clone())
                   :createAtCFrame(cframe)

  local frogGame = self

  function frog:onKiss(player)
    frogGame.dependencies.croakSound:Play()

    if frog.isPrince then
      frogGame:transformToFrogPrince(frog)
    else
      frogGame:injurePlayerFromFrog(player)
    end
  end

  table.insert(self.frogs, frog)
  return self
end

function FrogGame:randomizePrince()
  -- Set all frogs to not be the prince.
  for _, frog in ipairs(self.frogs) do
    frog:setIsPrince(false)
  end

  -- Get a random index between 1 and the length of the frogs table.
  local randomIndex = math.random(1, #self.frogs)

  -- Set the frog at the random index to be the prince.
  self.frogs[randomIndex]:setIsPrince(true)
  return self
end

return FrogGame
