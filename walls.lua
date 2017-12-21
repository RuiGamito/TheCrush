Wall = {
  x = 0,
  y = 0,
  height = 0,
  width = 0,
  colorR = 0,
  colorG = 0,
  colorB = 0
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

  love.graphics.setColor(wall.colorR, wall.colorG, wall.colorB)
  love.graphics.rectangle("fill", wall.x , wall.y , wall.width , wall.height )
end
