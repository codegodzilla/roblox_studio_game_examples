-- This file is located in "ReplicatedStorage.PlayerGuiControls"

local UserInputService = game:GetService("UserInputService")

local PlayerGuiControls = {}

function PlayerGuiControls.isMobile()
  return UserInputService.TouchEnabled
end

function PlayerGuiControls.isDesktop()
  return not PlayerGuiControls.isMobile()
end

return PlayerGuiControls
