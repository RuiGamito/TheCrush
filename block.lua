Block = {
  x_coord = nil,
  y_coord = nil,
  height = nil,
  width = nil,
  expand_up = false,
  expand_down = false,
  expand_right = false,
  expand_left = false,
  crush_trigger = nil,
  status = "something"
}

Block.__index = Block

Block.DEFAULT_WIDTH = 30
Block.DEFAULT_HEIGHT = 20
Block.EXPAND_DOWN = 0
Block.EXPAND_UP = 1
Block.EXPAND_RANDOM = 2

function Block.create(init)
  local self = setmetatable({}, Block)

  -- {800, love.math.random(0,200), world.BLOCK_WIDTH, world.TILE_SIZE, love.math.random(0,1000)+800, 0}
  self.x_coord = love.graphics.getWidth()

  if world.DYNAMIC_BLOCK_Y then
    self.y_coord = love.math.random(0,love.graphics.getHeight() - Block.DEFAULT_HEIGHT)
  else
    self.y_coord = 0
  end

  self.height = Block.DEFAULT_HEIGHT

  if world.DYNAMIC_BLOCK_WIDTH then
    self.width = love.math.random(Block.DEFAULT_WIDTH/2,Block.DEFAULT_WIDTH*2)
  else
    self.width = Block.DEFAULT_WIDTH
  end


  self.crush_trigger = love.math.random(0,world.CRUSH_BASE_VALUE)*2
  self.status = 0

  if world.EXPAND_DIRECTION==Block.EXPAND_RANDOM then
    self.expand = love.math.random(0,1)
  else
    self.expand = world.EXPAND_DIRECTION
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

  if block.expand == Block.EXPAND_DOWN then
    -- keep crushing if the block didn't hit the bottom
    if block.height < 800 then
      block.height = block.height + 200
    else
      -- otherwise change status to RECEDING, on the block
      -- and a point ;)
      pSystem:emit(32)
      PART[1] = block.x_coord + block.width/2
      PART[2] = 600
      PLAYER_POINTS = PLAYER_POINTS + 1
      block.status = 2
    end
  end
  if block.expand == Block.EXPAND_UP then
    -- keep crushing if the block didn't hit the bottom
    if block.y_coord > 0 then
      block.height = block.height + 200
      block.y_coord = block.y_coord - 200
    else
      -- otherwise change status to RECEDING, on the block
      -- and a point ;)
      pSystem:emit(32)
      PART[1] = block.x_coord + block.width/2
      PART[2] = 0
      PLAYER_POINTS = PLAYER_POINTS + 1
      block.status = 2
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
      block.height = block.height - 50
    else
      -- change status to NO CHANGE on the block
      block.status = 0
      -- reset the crush trigger
      block.crush_trigger = love.math.random(0,1000)+500
    end
  end
end
