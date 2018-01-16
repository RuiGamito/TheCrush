require "colors"

Block = {
  x_coord = nil,
  y_coord = nil,
  height = nil,
  direction_height = nil,
  width = nil,
  pulse_up = true,
  pulse_down = true,
  pulse_right = true,
  pulse_left = true,
  distortHorizontal = true,
  distortVertical = false,
  crush_trigger = nil
}

BLOCK_STATUS_IDLE =0
BLOCK_STATUS_CRUSHING = 1
BLOCK_STATUS_RECEDING = 2

PULSING_TIME = 29
PULSING_SIZE = 10

CRUSH_SPEED = love.graphics.getHeight()/2
RETRACT_SPEED = love.graphics.getHeight()/4

DISTORT_VALUE = 20

Block.__index = Block

Block.DEFAULT_WIDTH = 120
Block.DEFAULT_HEIGHT = 50
Block.EXPAND_DOWN = 0
Block.EXPAND_UP = 1
Block.EXPAND_RANDOM = 2

function Block.create()
  local self = setmetatable({}, Block)

  -- {800, love.math.random(0,200), world.BLOCK_WIDTH, world.TILE_SIZE, love.math.random(0,1000)+800, 0}
  self.x_coord = love.graphics.getWidth()

  self.height = Block.DEFAULT_HEIGHT
  self.direction_height = self.height / 8

  if world.DYNAMIC_BLOCK_Y then
    self.y_coord = love.math.random(0,love.graphics.getHeight() - Block.DEFAULT_HEIGHT)
  else
    if world.BLOCK_SPAWN_LOCATION == "top" then
      self.y_coord = 0
    elseif world.BLOCK_SPAWN_LOCATION == "bottom" then
      self.y_coord = world.HEIGHT - self.height
    end
  end



  if world.DYNAMIC_BLOCK_WIDTH then
    self.width = love.math.random(Block.DEFAULT_WIDTH/2,Block.DEFAULT_WIDTH*2)
  else
    self.width = Block.DEFAULT_WIDTH
  end


  self.crush_trigger = love.math.random(0,world.CRUSH_BASE_VALUE)*2
  self.status = 0

  if world.EXPAND_DIRECTION==Block.EXPAND_RANDOM then
    self.expand = love.math.random(0,1)

    if(self.y_coord < love.graphics.getHeight()*0.15) then
        self.expand = Block.EXPAND_DOWN
    end
    if(self.y_coord > love.graphics.getHeight()-love.graphics.getHeight()*0.15) then
        self.expand = Block.EXPAND_UP
    end

  else
    self.expand = world.EXPAND_RANDOM
  end


  return self
end

-- Checks if the block is out of the screen (to the left)
function Block.isOutOfScreenLeft(block)
  return block.x_coord + block.width < 0
end

-- Checks if the block is out of the screen (to the rigth)
function Block.isOutOfScreenRigth(block)
  return block.x_coord > love.graphics.getWidth()
end

function Block.expand(block)

  if GAME_STATE ~= PLAYING then
    return
  end

  if block.expand == Block.EXPAND_DOWN then
    -- keep crushing if the block didn't hit the bottom
    if block.height < love.graphics.getHeight() then
      block.height = block.height + CRUSH_SPEED
    else
      -- otherwise change status to RECEDING, on the block
      -- and a point ;)
      pSystem:emit(32)
      PART[1] = block.x_coord + block.width/2
      PART[2] = love.graphics.getHeight()
      if PLAYER_SCORE == nil then
        PLAYER_SCORE = 0
      end
      PLAYER_SCORE = PLAYER_SCORE + 1
      block.status = 2
      local snd_src = love.audio.newSource(crush_src, "static")
      snd_src:setVolume(1)
      snd_src:play()
    end
  end
  if block.expand == Block.EXPAND_UP then
    -- keep crushing if the block didn't hit the bottom
    if block.y_coord > 0 then
      block.height = block.height + CRUSH_SPEED
      block.y_coord = block.y_coord - 200
    else
      -- otherwise change status to RECEDING, on the block
      -- and a point ;)
      pSystem:emit(32)
      PART[1] = block.x_coord + block.width/2
      PART[2] = 0
      PLAYER_SCORE = PLAYER_SCORE + 1
      block.status = 2
      local snd_src = love.audio.newSource(crush_src, "static")
      snd_src:setVolume(1)
      snd_src:play()
    end
  end
end

function Block.retract(block)
  local LENGTH = block.height

  if block.expand == Block.EXPAND_DOWN then
    if LENGTH > 50 then
      block.height = block.height - 50
    else
      -- change status to NO CHANGE on the block
      block.status = 0
      -- reset the crush trigger
      block.crush_trigger = love.math.random(0,1000)+500
    end
  end
  if block.expand == Block.EXPAND_UP then
    if LENGTH > 50 then
      block.y_coord = block.y_coord + 50
      block.height = block.height - RETRACT_SPEED
    else
      -- change status to NO CHANGE on the block
      block.status = 0
      -- reset the crush trigger
      block.crush_trigger = love.math.random(0,1000)+500
    end
  end
end

function Block.draw(block)

  local pulsing = ((FRAME_COUNT%PULSING_TIME)/PULSING_TIME)*PULSING_SIZE

  local pulsing_left = 0
  local pulsing_right = 0
  local pulsing_up = 0
  local pulsing_down = 0
  local distortH = 0
  local distortV = 0

  if(block.pulse_left) then
    pulsing_left = pulsing
  end
  if(block.pulse_right) then
    pulsing_right = pulsing
  end
  if(block.pulse_up) then
    pulsing_up = pulsing
  end
  if(block.pulse_down) then
    pulsing_down = pulsing
  end
  if(block.distortHorizontal) then
    distortH = DISTORT_VALUE - block.crush_trigger/10
    if(distortH <= 0)then
      distortH = 0
    end
  end
  if(block.distortVertical) then
    distortV = DISTORT_VALUE - block.crush_trigger/10
    if(distortV <= 0)then
      distortV = 0
    end
  end

  love.graphics.setColor(CANON_COLOR.R,CANON_COLOR.G,CANON_COLOR.B)
  love.graphics.rectangle("fill", block.x_coord , block.y_coord  , block.width , block.height )
  love.graphics.setColor(CANON_COLOR.R+50,CANON_COLOR.G+50,CANON_COLOR.B+50)
  love.graphics.rectangle("fill",block.x_coord-2,block.y_coord-2,4,block.height+4)
  love.graphics.rectangle("fill",block.x_coord-2,block.y_coord-2,block.width+4,4)
  love.graphics.rectangle("fill",block.x_coord+block.width-2,block.y_coord-2,4,block.height+4)
  love.graphics.rectangle("fill",block.x_coord-2,block.y_coord+block.height-2,block.width+4,4)

  local x = block.x_coord - pulsing_left
  local y = block.y_coord - pulsing_up
  local w = block.width + pulsing_left + pulsing_right
  local h = block.height + pulsing_up + pulsing_down

  love.graphics.setColor(CANON_COLOR.R,CANON_COLOR.G,CANON_COLOR.B,100)
  love.graphics.rectangle("fill", x , y , w , h )

  if(block.expand == 0) then
    if block.crush_trigger > 100 then
      love.graphics.rectangle("fill", x , y + h + block.direction_height , w , block.direction_height )
    end
    if block.crush_trigger > 200 then
      love.graphics.rectangle("fill", x , y + h + 3 * block.direction_height , w , block.direction_height )
    end
    if  block.crush_trigger > 300 then
      love.graphics.rectangle("fill", x , y + h + 5 * block.direction_height , w , block.direction_height )
    end
  end
  if(block.expand == 1) then
    if block.crush_trigger > 100 then
      love.graphics.rectangle("fill", x , y - 2 * block.direction_height , w , block.direction_height)
    end
    if block.crush_trigger > 200 then
      love.graphics.rectangle("fill", x , y - 4 * block.direction_height , w , block.direction_height)
    end
    if  block.crush_trigger > 300 then
      love.graphics.rectangle("fill", x , y - 6 * block.direction_height , w , block.direction_height)
    end
  end
end
