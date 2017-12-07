Player = {}

local t_width = 50
local t_height = 50
local t_x = (love.graphics.getWidth()) / 2
local t_y = love.graphics.getHeight() - t_height

function Player.create()
  print("---> ", t_x, t_y, t_height, t_width)
  return {X=t_x, Y=t_y, HEIGHT=t_height, WIDTH=t_width, TILE=nil}
end

function Player.setPosition(p, xx, yy)
  p.X = xx
  p.Y = yy
end

function Player.setHeight(p, h)
  p.HEIGHT = h
end

function Player.setWidth(p, w)
  p.WIDTH = w
end
