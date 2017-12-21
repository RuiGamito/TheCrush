require("world")


-- BLOCK = {XX, YY, WIDTH, HEIGHT, CRUSH_TRIGGER, STATUS}
-- STATUS = 0 -> No change
--          1 -> Crushing
--          2 -> Receding
PLAYER_SAFE = 0
PLAYER_CRUSHED = 1
PART = {}

-- each level has the following settings
-- {SCORE_CAP, BLOCK_WIDTH, BLOCK_SPEED, MESSAGE}
LEVEL_SETTINGS = {
  {20,  100, 1.5, "Level 1 - Avoid the crushing blocks"},
  {40, 100, 1.5, "Level 2 - Are the blocks getting smaller?"},
  {80, 100, 1.8, "Level 3 - ... oh boy, it's faster now?"}
}

FRAME_COUNT = 0

function updateLevelStats()
  if PLAYER_POINTS < LEVEL_SETTINGS[LEVEL][1] then
    return
  else
    LEVEL = LEVEL + 1
  end

  BLOCK_WIDTH = LEVEL_SETTINGS[LEVEL][2]
  BLOCK_SPEED = LEVEL_SETTINGS[LEVEL][3]
  MESSAGE = LEVEL_SETTINGS[LEVEL][4]

end

-- ############################################################################

function love.load()
  world.load()

  -- PARTICLE System
  local img = love.graphics.newImage("parts.png")
  pSystem = love.graphics.newParticleSystem(img, 32)
  pSystem:setSizes(0.1)
  pSystem:setParticleLifetime(1,2)
  --this will make your particals shoot out in diffrent directions
  --this will make your particles look much better
  --you can play with the numbers to make them move in diffrent directions
  pSystem:setLinearAcceleration(-40, -40, 0, 0)
end


function love.update(dt)
  FRAME_COUNT = FRAME_COUNT+1
  world.update()
  pSystem:update(dt)
  --updateLevelStats()
end

function love.draw()
  world.draw()
end


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
