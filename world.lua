require("player")
require("block")
require("catui")
require("buttons")
require("walls")

world = {}

-- GAME STATES
GAMEMENU = 0
PLAYING = 1



-- GAME CICLE

-- Initialize the world
function world.init()
  print("Initializing world...")

  world.BLOCKS = {}
  world.WALLS = {}
  num_blocks = 0
  world.TILE_SIZE = 50

  world.DYNAMIC_BLOCK_WIDTH = false
  world.DYNAMIC_BLOCK_Y = true
  world.BLOCK_SPEED = 2.4
  world.MESSAGE = ""
  world.BLOCK_SPAWN_PROBABILITY = 0.01
  world.WIDTH = love.graphics.getWidth()
  world.HEIGHT = love.graphics.getHeight()
  world.PLAYER = Player.create()
  world.PLAYER.WIDTH = world.TILE_SIZE
  world.PLAYER.HEIGHT = world.TILE_SIZE
  world.CRUSH_BASE_VALUE = 500
  world.GRAVITY_X=0
  world.GRAVITY_Y=0
  world.PLAYER_SPEED_X=6
  world.PLAYER_SPEED_Y=3
  world.EXPAND_DIRECTION=Block.EXPAND_RANDOM

  -- Initialize buttons
  world.buttons = {}

  mgr = UIManager:getInstance()
  mgrContainer = mgr.rootCtrl.coreContainer

  GAME_STATE = GAMEMENU
end

function world.play()

  world.BLOCKS = {}
  world.WALLS = {}

  -- create the block table
  initial_block = Block.create()
  initial_block.crush_trigger = love.math.random(0,world.CRUSH_BASE_VALUE)*2
  table.insert(world.BLOCKS, initial_block)
  num_blocks = 1

  table.insert(world.WALLS,Wall.create(nil))
  table.insert(world.WALLS,Wall.create(nil))
  num_wall = 2

  -- Set the LEVEL
  LEVEL = 1

  -- Add the player
  --local player = {300, 550, world.TILE_SIZE, world.TILE_SIZE}
  PLAYER_STATUS = PLAYER_SAFE

  -- Reset PLAYER_POINTS
  PLAYER_POINTS = 0

  -- Set the BLOCK_WAIT var
  BLOCK_WAIT = 10
  BLOCK_WAIT_tmp = BLOCK_WAIT

  GAME_STATE = PLAYING
end

function world.load()
  world.init()
  addButtons()
end

function world.update()

  mgr:update(dt)

  if PLAYER_STATUS == PLAYER_CRUSHED then

    local ts = love.touch.getTouches()
    for i, id in ipairs(ts) do
      local x, y = love.touch.getPosition(id)
      if y+100 > love.graphics.getHeight()/2 and
          y-100 < love.graphics.getHeight()/2 and
          x<500 then -- use string.getWidth() to get the lenght in pixels
            world.init()
          end
    end

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

  -- deal with the touch movements
  local touches = love.touch.getTouches()
  for i, id in ipairs(touches) do
    local x, y = love.touch.getPosition(id)
    if touch then
      local dx = x - touch_x
      local dy = y - touch_y

      --love.graphics.circle("fill", x, y, 20)
      Player.setPosition(world.PLAYER, world.PLAYER.X + dx, world.PLAYER.Y + dy)

      touch_x = x
      touch_y = y
    end
  end

  Player.adjustPosition(world.PLAYER)


  -- evaluate if head block is completely out of the screen (to the left)
  -- and if it is, remove it
  if num_blocks > 0 then
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
  end

  -- decrease the x pos of the blocks, that is, make them move to the left
  -- also, decrease block crush_trigger , and if <= 0, CRUSH!!!
  for _, block in ipairs(world.BLOCKS) do
      block.x_coord = block.x_coord - world.BLOCK_SPEED

      local STATUS = block.status
      local LENGTH = block.height



      -- if crush_trigger is over and status is 0
      if block.crush_trigger <= 0 and STATUS == BLOCK_STATUS_IDLE then
        -- change the status to CRUSHING on the block
        block.status = BLOCK_STATUS_CRUSHING
      elseif STATUS == BLOCK_STATUS_CRUSHING then -- if the block is crushing
        -- keep crushing if the block didn't hit the bottom
        Block.expand(block)

      elseif STATUS == BLOCK_STATUS_RECEDING then -- if the block is receding
        Block.retract(block)
      else -- simply decrease the CRUSH_TRIGGER
        block.crush_trigger = block.crush_trigger - 4
      end

      if world.checkPlayerBlockCollision(block) then
        PLAYER_STATUS = PLAYER_CRUSHED
      end

  end -- for

  for _, wall in ipairs(world.WALLS) do
      wall.x = wall.x - world.BLOCK_SPEED
  end -- for
  if(#world.WALLS > 0) then
    local lastwall = world.WALLS[#world.WALLS]
    if(lastwall.x <= love.graphics.getHeight())then
      table.insert(world.WALLS,Wall.create(lastwall))
      table.insert(world.WALLS,Wall.create(lastwall))
      num_wall = num_wall + 2
    end
  end
end

function world.draw()
  if GAME_STATE == PLAYING then
    world.drawWalls()
    world.drawPlayer()
    world.drawInfo()
    world.drawParticles()
    world.drawBlocks()
  end
  mgr:draw()
  world.drawButtons()
end

function love.touchpressed(id, x, y, dx, dy, pressure)
  touch = true
  touch_x = x
  touch_y = y
end

function love.mousepressed(x, y, button, isTouch)
    mgr:mouseDown(x, y, button, isTouch)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
  touch = false
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
  love.graphics.print("Crushes avoided: " .. PLAYER_POINTS, 10, 100, 0, 2, 2)

  if PLAYER_STATUS == PLAYER_CRUSHED then
    -- love.graphics.setColor(255, 0, 0)
    -- love.graphics.print("Touch here to play again! ;)", 10, love.graphics.getHeight()/2, 0, 4, 4)
    local b = world.buttons["play_again"]
    if not b:getVisible() then
      b:setVisible(true)
      mgrContainer:addChild(b)
    end
  end

  -- Print the level message
  love.graphics.setColor(0, 255, 0)
  love.graphics.print(world.MESSAGE, 200, 200)

end

function world.drawParticles()
  love.graphics.setColor(255, 100, 100)
  love.graphics.draw(pSystem, PART[1], PART[2])
end

function world.drawButtons()
  -- add visible buttons to the UIManager
  for _,button in pairs(world.buttons) do
    if button:getVisible() and not mgrContainer:hasChildren(button) then
      mgrContainer:addChild(button)
    end
  end

  -- remove not visible elements from UIManager
  for _,element in pairs(mgrContainer:getChildren()) do
    if not element:getVisible() then
      mgrContainer:removeChild(element)
    end
  end
end

function world.drawBlocks()
  for _, block in ipairs(world.BLOCKS) do
      Block.draw(block)
  end
end

function world.drawWalls()
  for _, wall in ipairs(world.WALLS) do
      Wall.draw(wall)
  end
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
