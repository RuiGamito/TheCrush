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
    self.y = 0;
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
function Wall.isOutOfScreenRigth(block)
  return wall.x > love.graphics.getWidth()
end


function Wall.draw(wall)
  --love.graphics.setColor(wall.colorR/2, wall.colorG/2, wall.colorB/2)
  --love.graphics.rectangle("fill",wall.x,wall.y,wall.width,wall.height)

  for _,colider in ipairs(wall.tile) do

    local rect_x = ((colider.x)/100 * love.graphics.getHeight()*0.5 )+ wall.x
    local rect_y = ((colider.y)/100 * love.graphics.getHeight()*0.5 )+ wall.y
    local rect_w = ((colider.w)/100 * love.graphics.getHeight()*0.5 )
    local rect_h = ((colider.h)/100 * love.graphics.getHeight()*0.5 )


     love.graphics.setColor(wall.colorR, wall.colorG, wall.colorB)
     love.graphics.rectangle("fill",rect_x,rect_y,rect_w,rect_h)
   end
 end
