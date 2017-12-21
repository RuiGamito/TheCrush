require "tiles"

Wall = {
  x = 0,
  y = 0,
  height = 0,
  width = 0,
  colorR = 0,
  colorG = 0,
  colorB = 0,
  tile = nil
}

WALL_NUM = 0

function Wall.create(lastwall)
  local self = setmetatable({}, Wall)

  self.height = love.graphics.getHeight()*0.5
  self.width = love.graphics.getHeight()*0.5

  local top = WALL_NUM%2
  WALL_NUM = WALL_NUM+1

  if(top == 0)then
    self.y = love.graphics.getHeight()*0.5
  end
  if(top == 1)then
    self.y = 0
  end

  if(lastwall == nil)then
    self.x = love.graphics.getWidth()
  else
    self.x = lastwall.x+lastwall.width
  end


  self.colorR = love.math.random(0,255)
  self.colorG = love.math.random(0,255)
  self.colorB = love.math.random(0,255)

  self.tile = TILES[love.math.random(1,#TILES)]

  --print(self.tile[2].x)


  return self
end

-- Checks if the block is out of the screen (to the left)
function Wall.isOutOfScreenLeft(wall)
  return wall.x + wall.width < 0
end

-- Checks if the block is out of the screen (to the rigth)
function Wall.isOutOfScreenRigth(wall)
  return wall.x > love.graphics.getWidth()
end

function Wall.checkPlayerWallCollision(agr_wall)

  for index,agr_wall_colider in ipairs(agr_wall.tile) do

    local rect_x = (agr_wall_colider.x/100 * love.graphics.getHeight()*0.5 ) + agr_wall.x
    local rect_y = (agr_wall_colider.y/100 * love.graphics.getHeight()*0.5 ) + agr_wall.y
    local rect_w = (agr_wall_colider.w/100 * love.graphics.getHeight()*0.5 )
    local rect_h = (agr_wall_colider.h/100 * love.graphics.getHeight()*0.5 )

    if rect_x < world.PLAYER.X + world.PLAYER.WIDTH and
       rect_x + rect_w > world.PLAYER.X and
       rect_y + rect_h >= world.PLAYER.Y and
       rect_y < world.PLAYER.Y + world.PLAYER.HEIGHT then


         if     world.PLAYER.X < rect_x and
                world.PLAYER.X + world.PLAYER.WIDTH > rect_x and
                world.PLAYER.Y + world.PLAYER.HEIGHT > rect_y and
                world.PLAYER.Y < rect_y + rect_h then
                    world.PLAYER.X = rect_x - world.PLAYER.WIDTH
         elseif world.PLAYER.X + world.PLAYER.WIDTH > rect_x + rect_w and
                world.PLAYER.X < rect_x + rect_w and
                world.PLAYER.Y + world.PLAYER.HEIGHT > rect_y and
                world.PLAYER.Y < rect_y + rect_h then
                    world.PLAYER.X = rect_x + rect_w
         end

         if     world.PLAYER.Y < rect_y and
                world.PLAYER.Y + world.PLAYER.HEIGHT > rect_y and
                world.PLAYER.X + world.PLAYER.WIDTH > rect_x and
                world.PLAYER.X < rect_x + rect_w then
                    world.PLAYER.Y = rect_y - world.PLAYER.HEIGHT
         elseif world.PLAYER.Y + world.PLAYER.HEIGHT > rect_y + rect_h and
                world.PLAYER.Y < rect_y + rect_h and
                world.PLAYER.X + world.PLAYER.WIDTH > rect_x and
                world.PLAYER.X < rect_x + rect_w then
                    world.PLAYER.Y = rect_y + rect_h
         end
       end
  end
end

function Wall.draw(wall)
  --love.graphics.setColor(wall.colorR/2, wall.colorG/2, wall.colorB/2)
  --love.graphics.rectangle("line",wall.x,wall.y,wall.width,wall.height)

  for _,colider in ipairs(wall.tile) do

    local rect_x = ((colider.x)/100 * love.graphics.getHeight()*0.5 )+ wall.x
    local rect_y = ((colider.y)/100 * love.graphics.getHeight()*0.5 )+ wall.y
    local rect_w = ((colider.w)/100 * love.graphics.getHeight()*0.5 )
    local rect_h = ((colider.h)/100 * love.graphics.getHeight()*0.5 )


     love.graphics.setColor(wall.colorR, wall.colorG, wall.colorB)
     love.graphics.rectangle("fill",rect_x,rect_y,rect_w,rect_h)
   end
 end
