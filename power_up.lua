PowerUp = {}

local width = 100
local height = 100

-- INIT the power ups
pu_random = love.graphics.newImage("img/power_ups/Random.png")
pu_noclip = love.graphics.newImage("img/power_ups/Noclip.png")
pu_sizeup = love.graphics.newImage("img/power_ups/Sizeup.png")
pu_slow   = love.graphics.newImage("img/power_ups/Slow.png")

ACTIVE_PU = -1

function PowerUp.createRandom()
  local self = setmetatable({}, PowerUp)

  self.height = height
  self.width = width
  self.x = love.graphics.getWidth()
  self.iy = love.math.random(0,love.graphics.getHeight())

  local img = love.math.random(0,3)

  self.pid = img


  if img == 0 then
    self.image = pu_random
  elseif img == 1 then
    self.image = pu_noclip
  elseif img == 2 then
    self.image = pu_sizeup
  elseif img == 3 then
    self.image = pu_slow
  end

  return self
end

function PowerUp.isOutOfScreenLeft(power)
  return power.x_coord + power.width < 0
end

function PowerUp.isOutOfScreenRigth(power)
  return power.x_coord > love.graphics.getWidth()
end
