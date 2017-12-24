PowerUp = {}

local width = 50
local height = 50

PU_1 = 1
PU_2 = 2

function PowerUp.createRandom()
  local self = setmetatable({}, PowerUp)

  self.height = height
  self.width = width
  self.x = love.graphics.getWidth()
  self.y = love.math.random(0,love.graphics.getHeight()-self.height)

  return self
end

function PowerUp.isOutOfScreenLeft(power)
  return power.x_coord + power.width < 0
end

function PowerUp.isOutOfScreenRigth(power)
  return power.x_coord > love.graphics.getWidth()
end
