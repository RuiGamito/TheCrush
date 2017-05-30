require("player")

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
  world.BLOCKS = {}
  world.TILE_SIZE = 50
  world.BLOCK_WIDTH = 100
  world.DYNAMIC_BLOCK_WITH = false
  --PLAYER_SAFE = 0
  --PLAYER_CRUSHED = 1
  --PART = {},
  world.BLOCK_SPEED = 1.5
  world.MESSAGE = ""
  world.BLOCK_SPAWN_PROBABILITY = 0.03
  world.WIDTH = love.graphics.getWidth()
  world.HEIGHT = love.graphics.getHeight()
  world.PLAYER = player.create()

  -- create the block table
  table.insert(world.BLOCKS, world.spawnBlock())
  num_blocks = 1

  -- Set the LEVEL
  LEVEL = 1

  -- Add the player
  --local player = {300, 550, world.TILE_SIZE, world.TILE_SIZE}
  PLAYER_STATUS = PLAYER_SAFE

  -- Add PLAYER_POINTS
  PLAYER_POINTS = 0

  -- Set the BLOCK_WAIT var
  BLOCK_WAIT = 100
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
    if world.PLAYER.X+10 > 750 then
      world.PLAYER.X = 750
    else
      world.PLAYER.X = world.PLAYER.X + 10
    end
  elseif love.keyboard.isDown("left") then
    if world.PLAYER.X-10 < 0 then
      world.PLAYER.X = 0
    else
      world.PLAYER.X = world.PLAYER.X - 10
    end
  end

  -- evaluate if head block is completely out of the screen (to the left)
  -- and if it is, remove it
  local first = world.BLOCKS[1]
  if first[1]+first[3] < 0 then
    table.remove(world.BLOCKS,1)
    num_blocks = num_blocks - 1
  end

  -- evaluate if tail block is completely on the screen (on the right)
  -- and if it is, spawn a new one
  local last = world.BLOCKS[num_blocks]

  local pos = last[1]+last[3]

  local prob = love.math.random(0,100)

  if BLOCK_WAIT_tmp > 0 then
    BLOCK_WAIT_tmp = BLOCK_WAIT - (world.WIDTH - pos)
  elseif world.BLOCK_SPAWN_PROBABILITY * 100 > prob and pos < 800 then
    table.insert(world.BLOCKS,world.spawnBlock())
    num_blocks = num_blocks + 1
    BLOCK_WAIT_tmp = BLOCK_WAIT
  end

  -- decrease the x pos of the blocks, that is, make them move to the left
  -- also, decrease block crush_trigger , and if <= 0, CRUSH!!!
  for _, block in ipairs(world.BLOCKS) do
      block[1] = block[1] - world.BLOCK_SPEED

      local STATUS = block[6]
      local LENGTH = block[4]

      -- if crush_trigger is over and status is 0
      if block[5] <= 0 and STATUS == 0 then
        -- change the status to CRUSHING on the block
        block[6] = 1
      elseif STATUS == 1 then -- if the block is crushing
        -- keep crushing if the block didn't hit the bottom
        if LENGTH < 800 then
          block[4] = block[4] + 200
          PLAYER_STATUS = world.checkPlayerCrush(block)
        else
          -- otherwise change status to RECEDING, on the block
          -- and a point ;)
          pSystem:emit(32)
          PART[1] = block[1]+block[3]/2
          PART[2] = 600
          PLAYER_POINTS = PLAYER_POINTS + 1
          block[6] = 2
        end
      elseif STATUS == 2 then -- if the block is receding
        if LENGTH > 50 then
          block[4] = block[4] - 50
        else
          -- change status to NO CHANGE on the block
          block[6] = 0
          -- reset the crush trigger
          block[5] = love.math.random(0,1000)+500
        end
      else -- simply decrease the CRUSH_TRIGGER
        block[5] = block[5] - 4
      end
  end -- for

end

function world.draw()
  world.drawPlayer()
  world.drawInfo()
  world.drawParticles()
end

--- OTHER GAME FUNCTIONS


function world.spawnBlock()
  return {800, love.math.random(0,200), world.BLOCK_WIDTH, world.TILE_SIZE, love.math.random(0,1000)+800, 0}
end

function world.checkPlayerCrush(block)
  if block[1] < world.PLAYER.X+world.PLAYER.HEIGHT and
     block[1] + block[3] > world.PLAYER.X and
     block[2] + block[4] > world.PLAYER.Y then
       return PLAYER_CRUSHED
  else
       return PLAYER_SAFE
  end
end

function world.drawPlayer()
  love.graphics.setColor(100, 100, 255)
  love.graphics.rectangle("fill", world.PLAYER.X, world.PLAYER.Y, world.PLAYER.HEIGHT, world.PLAYER.WIDTH)
  --love.graphics.print("STATUS:" .. PLAYER_STATUS, 10, 10)
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
