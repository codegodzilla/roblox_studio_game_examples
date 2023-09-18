local part1 = script.Parent.PassPart1
local part2 = script.Parent.PassPart2

function handlePurchaseFinished(player, gamePassId, wasPurchased)
  print("was purchased", player, gamePassId, wasPurchased)
end

function handleGamePassPrompt(player)
  local GAME_PASS_ID = 256884822

  local MarketPlaceService = game:GetService("MarketplaceService")

  local hasGamePass = MarketPlaceService
    :UserOwnsGamePassAsync(player.UserId,GAME_PASS_ID)

  print("has game pass" , hasGamePass)

  if hasGamePass then
    return
  end

  MarketPlaceService:PromptGamePassPurchase(player, GAME_PASS_ID)

  MarketPlaceService.PromptGamePassPurchaseFinished
                    :Connect(handlePurchaseFinished)

end

part1.ProximityPrompt.Triggered:Connect(function(player)
  print('proximity triggered')
  handleGamePassPrompt(player)
end)

local isTouched = false

part2.Touched:Connect(function(partTouched)
  -- do not continue if recently touched.
  if isTouched then
    return
  end

  local player = game.Players:GetPlayerFromCharacter(partTouched.Parent)
  print('touched', player)

  if not player then
    return
  end

  isTouched = true

  delay(2, function()
    isTouched = false
  end)

  handleGamePassPrompt(player)
end)
