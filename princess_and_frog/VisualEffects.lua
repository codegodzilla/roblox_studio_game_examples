-- This is a modal containing two models.
-- we will rotate these.
local brolyVfx = script.broly_vfx

local TweenService = game:GetService("TweenService")

local module = {}

-- Recursively anchroes each part in a model.
function anchorParts(model)
  for _, child in ipairs(model:GetChildren()) do
    if child:IsA("BasePart") or child:IsA("MeshPart") then
      child.Anchored = true
    elseif child:IsA("Model") then
      anchorParts(child)
    end
  end
  return model
end

-- applies tween on part, rotates it.
function rotatePart(part)
  local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false)
  local goal = {
    CFrame = part.CFrame * CFrame.Angles(0,math.rad(180),0),
  }
  local tween = TweenService:Create(part, tweenInfo, goal)
  tween:Play()
end

-- Using tween transparency to fade out in 1 second, given part.
function fadeOut(part, time)
  local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0)
  local goal = {
    Transparency = 1,
  }
  local tween = TweenService:Create(part, tweenInfo, goal)
  tween:Play()
end

-- Rotates each part in a model
-- after 1.5 seconds opacity out
function animateChildren(model)
  local parts = model:GetDescendants()
  for _, part in ipairs(parts) do
    if part:IsA("BasePart") or part:IsA("MeshPart") then
      rotatePart(part)
      fadeOut(part, 3)
    end
  end
end

-- Creates VFX in given position
function module.createVfx(position)
  -- move position slightly up
  position = position + Vector3.new(0, 2, 0)
  local vfx = anchorParts(brolyVfx:Clone())

  local inside = vfx:WaitForChild("inside")
  local outside = vfx:WaitForChild("outside")
  inside:SetPrimaryPartCFrame(position)
  outside:SetPrimaryPartCFrame(position)

  vfx.Parent = workspace

  animateChildren(inside)
  animateChildren(outside)


end

return module
