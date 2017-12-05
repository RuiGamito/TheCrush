require("player")
require("block")

world = {
  BLOCKS = nil,
  TILE_SIZE = nil,
  BLOCK_WIDTH = nil,
  DYNAMIC_BLOCK_WITH = nil,
  PLAYER_SAFE = nil,
  PLAYER_CRUSHED = nil,
  PART = nil,
  BLOCK_SPEED = nil,
  MESSAGE = nil,
  BLOCK_SPAWN_PROBABILITY = nil,
  WIDTH = nil,
  HEIGHT = nil,
  PLAYER = nil
}

-- GAME CICLE

-- Initialize the world
function world.init()
  print("Initializing world...")
  world.BLOCKS = {}
  world.TILE_SIZE = 30

  world.DYNAMIC_BLOCK_WIDTH = true
  world.DYNAMIC_BLOCK_Y = true
  world.DYNAMIC_BLOCK_CRUSH_DIR = true
  --PLAYER_SAFE = 0
  --PLAYER_CRUSHED = 1
  --PART = {},
  world.BLOCK_SPEED = 3.0
  world.MESSAGE = ""
  world.BLOCK_SPAWN_PROBABILITY = 0.20
  world.WIDTH = love.graphics.getWidth()
  world.HEIGHT = love.graphics.getHeight()
  world.PLAYER = player.create()
  world.PLAYER.WIDTH = world.TILE_SIZE
  world.PLAYER.HEIGHT = world.TILE_SIZE
  world.CRUSH_BASE_VALUE = 500
  world.GRAVITY_X=0
  world.GRAVITY_Y=0
  world.PLAYER_SPEED_X=6
  world.PLAYER_SPEED_Y=3
  world.EXPAND_DIRECTION=Block.EXPAND_DOWN
  -- create the block table
  initial_block = Block.create()
  initial_block.crush_trigger = love.math.random(0,world.CRUSH_BASE_VALUE)*2
  table.insert(world.BLOCKS, initial_block)
  num_blocks = 1

  -- Set the LEVEL
  LEVEL = 1

  -- Add the player
  --local player = {300, 550, world.TILE_SIZE, world.TILE_SIZE}
  PLAYER_STATUS = PLAYER_SAFE

  -- Add PLAYER_POINTS
  PLAYER_POINTS = 0

  -- Set the BLOCK_WAIT var
  BLOCK_WAIT = 10
  BLOCK_WAIT_tmp = BLOCK_WAIT
end

function world.load()
  world.init()
end

function world.update()

  if PLAYER_STATUS == PLAYER_CRUSHED then
    if love.keyboard.isDown("space")  then
      world.init()
    else
      return
    end
  end

  -- create some keyboard events to control the player
  if love.keyboard.isDown("right") then
    if world.PLAYER.X+world.PLAYER_SPEED_X > 750 then
      world.PLAYER.X = 750
    else
      world.PLAYER.X = world.PLAYER.X + world.PLAYER_SPEED_X
    end
  end
  if love.keyboard.isDown("left") then
    if world.PLAYER.X-world.PLAYER_SPEED_X < 0 then
      world.PLAYER.X = 0
    else
      world.PLAYER.X = world.PLAYER.X - world.PLAYER_SPEED_X
    end
  end
  if love.keyboard.isDown("up") then
    if world.PLAYER.Y-world.PLAYER_SPEED_Y < 0 then
      world.PLAYER.Y = 0
    else
      world.PLAYER.Y = world.PLAYER.Y - world.PLAYER_SPEED_Y
    end
  end
  if love.keyboard.isDown("down") then
    if world.PLAYER.Y+world.PLAYER.HEIGHT+world.PLAYER_SPEED_Y > world.HEIGHT then
      world.PLAYER.Y = world.HEIGHT - world.PLAYER.HEIGHT
    else
      world.PLAYER.Y = world.PLAYER.Y + world.PLAYER_SPEED_Y
    end
  end

  -- evaluate if head block is completely out of the screen (to the left)
  -- and if it is, remove it
  local first = world.BLOCKS[1]
  if first.x_coord+first.height < 0 then
    table.remove(world.BLOCKS,1)
    num_blocks = num_blocks - 1
  end

  -- evaluate if tail block is completely on the screen (on the right)
  -- and if it is, spawn a new one
  local last = world.BLOCKS[num_blocks]

  local pos = last.x_coord+last.width

  local prob = love.math.random(0,100)

  if BLOCK_WAIT_tmp > 0 then
    BLOCK_WAIT_tmp = BLOCK_WAIT - (world.WIDTH - pos)
  elseif world.BLOCK_SPAWN_PROBABILITY * 100 > prob and pos < love.graphics.getWidth() then
    table.insert(world.BLOCKS,Block.create())
    num_blocks = num_blocks + 1
    BLOCK_WAIT_tmp = BLOCK_WAIT
  end

  -- decrease the x pos of the blocks, that is, make them move to the left
  -- also, decrease block crush_trigger , and if <= 0, CRUSH!!!
  for _, block in ipairs(world.BLOCKS) do
      block.x_coord = block.x_coord - world.BLOCK_SPEED

      local STATUS = block.status
      local LENGTH = block.height



      -- if crush_trigger is over and status is 0
      if block.crush_trigger <= 0 and STATUS == 0 then
        -- change the status to CRUSHING on the block
        block.status = 1
      elseif STATUS == 1 then -- if the block is crushing
        -- keep crushing if the block didn't hit the bottom
        Block.expand(block)

      elseif STATUS == 2 then -- if the block is receding
        Block.retract(block)
      else -- simply decrease the CRUSH_TRIGGER
        block.crush_trigger = block.crush_trigger - 4
      end

      if world.checkPlayerBlockCollision(block) then
        PLAYER_STATUS = PLAYER_CRUSHED
      end

  end -- for

end

function world.draw()
  world.drawPlayer()
  world.drawInfo()
  world.drawParticles()

  local touches = love.touch.getTouches()

    for i, id in ipairs(touches) do
        local x, y = love.touch.getPosition(id)
        print(x,y)
        --love.graphics.circle("fill", x, y, 20)
        world.PLAYER.X = x
        world.PLAYER.Y = y
    end

end

--- OTHER GAME FUNCTIONS

function world.checkPlayerBlockCollision(block)
  if block.x_coord < world.PLAYER.X + world.PLAYER.WIDTH and
     block.x_coord + block.width > world.PLAYER.X and
     block.y_coord + block.height >= world.PLAYER.Y and
     block.y_coord < world.PLAYER.Y + world.PLAYER.HEIGHT then
       return true
  else
       return false
  end
end

function world.drawPlayer()
  love.graphics.setColor(100, 100, 255)
  love.graphics.rectangle("fill", world.PLAYER.X, world.PLAYER.Y, world.PLAYER.HEIGHT, world.PLAYER.WIDTH)
end

function world.drawInfo()
  -- Print the score
  love.graphics.setColor(255, 0, 0)
  love.graphics.print("Crushes avoided: " .. PLAYER_POINTS, 10, 100)

  -- Print the level message
  love.graphics.setColor(0, 255, 0)
  love.graphics.print(world.MESSAGE, 200, 200)

end

function world.drawParticles()
  love.graphics.setColor(255, 100, 100)
  love.graphics.draw(pSystem, PART[1], PART[2])
end

function world.print()
  for key,_ in pairs(world) do
    print(key)
  end
  for key,value in pairs(world) do
    if type(value) == "table" then
      print(key .. ":")
      for _, nvalue in pairs(value) do
        print("   ", nvalue)
      end
    elseif type(value) == "function" then
    else
        print(key, value)
    end
  end
  print("----------------- ENDED WORLD PRINT -----------------")
end
