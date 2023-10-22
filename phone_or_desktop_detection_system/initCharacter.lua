-- This file is located in "StarterPlayer.StarterCharacterScripts.initCharacter"

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGuiControls = require(ReplicatedStorage.PlayerGuiControls)

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local label = playerGui.DemoScreenGui.MobileOrDesktopLabel

if PlayerGuiControls.isMobile() then
  print("MOBILE")
  label.Text = "MOBILE"
end

if PlayerGuiControls.isDesktop() then
  print("DESKTOP")
  label.Text = "DESKTOP"
end