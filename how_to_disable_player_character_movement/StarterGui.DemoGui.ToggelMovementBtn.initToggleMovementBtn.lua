local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EnableEvent = ReplicatedStorage.EnableMovementEvent
local DisableEvent = ReplicatedStorage.DisableMovementEvent
local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

local button = script.Parent
local isEnabled = true

function isMobile()
  return UserInputService.TouchEnabled
end

local guiConnection = nil

function removeMobileGui()
  if isMobile() then
    guiConnection = RunService.RenderStepped:Connect(function()
      local touchGui = player.PlayerGui.TouchGui
      if touchGui then
        touchGui.Enabled = false
      end
    end)
  end
end

function enableMobileGui()
  if isMobile() then
    if guiConnection then
      guiConnection:Disconnect()
      local touchGui = player.PlayerGui.TouchGui
      if touchGui then
        touchGui.Enabled = true
      end
    end
  end
end

function enableMovement()
  EnableEvent:FireServer()
  enableMobileGui()
end

function disableMovement()
  DisableEvent:FireServer()
  removeMobileGui()
end

button.Activated:Connect(function()

  isEnabled = not isEnabled

  if isEnabled then
    button.Text = "ON"
    enableMovement()
  else
    button.Text = "OFF"
    disableMovement()
  end
end)