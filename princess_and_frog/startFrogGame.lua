local frogTemplate = game:GetService("ServerStorage").frogTemplate
local SS = game:GetService("ServerScriptService")
local vfx = require(SS.VisualEffects)
local Modifier = require(SS.Modifier)
local ServerStorage = game:GetService("ServerStorage")
local FrogGame = require(ServerStorage.FrogGame)

local blastSound = script.Parent.BlastSound
local croakSound = script.Parent.CroakSound

FrogGame:new({
  changeCharacterMethod = Modifier.switchCharacterOfNpc,
  kissVisualEffect = vfx.createVfx,
  croakSound = croakSound,
  transformSound = blastSound,
  frogModelTemplate = frogTemplate,
  princeModelTemplate = ServerStorage.princeTemplate,
})
        :createFrogAtCFrame(script.Parent.location1.CFrame)
        :createFrogAtCFrame(script.Parent.location2.CFrame)
        :createFrogAtCFrame(script.Parent.location3.CFrame)
        :randomizePrince()