Player = {}

local t_width = 50
local t_height = 50
local t_x = (love.graphics.getWidth()) / 2
local t_y = love.graphics.getHeight() - t_height
local target_x = 0
local target_y = 0

function Player.create()
  print("---> ", t_x, t_y, t_height, t_width)
  return {X=t_x, Y=t_y, HEIGHT=t_height, WIDTH=t_width, target_x=target_x, target_y=target_y, TILE=nil}
end

function Player.reset(player)
  player.X=t_x
  player.Y=t_y
end

function Player.setPosition(p, xx, yy)
  p.X = xx
  p.Y = yy
end

function Player.setNudgeOffset(p, dx, dy)
  p.target_x = dx
  p.target_y = dy
end

function Player.setNudgeOffsetX(p, dx)
  p.target_x = dx
end

function Player.setNudgeOffsetY(p, dy)
  p.target_y = dy
end

function Player.setHeight(p, h)
  p.HEIGHT = h
end

function Player.setWidth(p, w)
  p.WIDTH = w
end

function Player.adjustPosition(p)
  if p.X < 0 then
    p.X = 0
  end
  if p.X > love.graphics.getWidth() - t_width then
    p.X = love.graphics.getWidth() - t_width
  end
  if p.Y < 0 then
    p.Y = 0
  end
  if p.Y > love.graphics.getHeight() - t_height then
    p.Y = love.graphics.getHeight() - t_height
  end
end

function Player.move(p)
  local x = p.X + (p.target_x/world.PLAYER_SPEED_X)
  local y = p.Y + (p.target_y/world.PLAYER_SPEED_Y)
  print(x, y)
  p.X = x
  p.Y = y

  if p.target_x > 0 then
    p.target_x = p.target_x - 10
  elseif p.target_x < 0 then
    p.target_x = p.target_x + 10
  end

  if p.target_y > 0 then
    p.target_y = p.target_y - 10
  elseif p.target_y < 0 then
    p.target_y = p.target_y + 10
  end

end
