Background={
  x=0
}

local images = {}
local speed = 5
local loaded_images = {}
local squares = {}

function Background.load()

   images_fs = {
     "img/teste.png"
   }

   for id,im in ipairs(images_fs) do
     loaded_images[id] = love.graphics.newImage(im)
   end

   Background.reset()

   local i = 10
   while i > 0 do
     local square = {
       x = love.math.random(0,love.graphics.getWidth()),
       y = love.graphics.getHeight()*0.1*i
     }
     table.insert(squares,square)
     i = i - 1
   end

end

function Background.reset()
  last_x = 0
  next_image = 1
end

function Background.loadNewImage()
  local image = {
    img = loaded_images[next_image],
    x = last_x,
    y = 0
  }
  table.insert(images, image)
  last_x = last_x + image.img:getWidth()

  --print("Loaded images:", #loaded_images)
  --print("Current Image", next_image)
  next_image = next_image % #loaded_images + 1
  --print("Next Image", next_image)
end

function Background.startStuff()
  bgX1 = love.graphics.getHeight()*0
  bgX2 = love.graphics.getHeight()*0.1
  bgX3 = love.graphics.getHeight()*0.2
  bgX4 = love.graphics.getHeight()*0.3
  bgX5 = love.graphics.getHeight()*0.4
  bgX6 = love.graphics.getHeight()*0.5
  bgX7 = love.graphics.getHeight()*0.6
  bgX8 = love.graphics.getHeight()*0.7
  bgX9 = love.graphics.getHeight()*0.8
  bgX10 = love.graphics.getHeight()*0.9
  bgX11 = love.graphics.getHeight()*1.0
  bgX12 = love.graphics.getHeight()*1.1
  bgX13 = love.graphics.getHeight()*1.2
  bgX14 = love.graphics.getHeight()*1.3
  bgX15 = love.graphics.getHeight()*1.4
  bgX16 = love.graphics.getHeight()*1.5
  bgX17 = love.graphics.getHeight()*1.6
  bgX18 = love.graphics.getHeight()*1.7
  --bgX19 = love.graphics.getHeight()*1.8
  --bgX20 = love.graphics.getHeight()*1.9
end

function Background.draw()

  if bgX1 == nil then Background.startStuff() end

  if GAME_STATE == PLAYING then

    love.graphics.setColor(32,17,72)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())


    love.graphics.setColor(251,60,178,100)

    local increment = love.graphics.getHeight()*0.1
    --x
    love.graphics.rectangle("fill",0,increment*0,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*1,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*2,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*3,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*4,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*5,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*6,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*7,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*8,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*9,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*10,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*11,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*12,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*13,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*14,love.graphics.getWidth(),4)
    love.graphics.rectangle("fill",0,increment*15,love.graphics.getWidth(),4)
    --y

    love.graphics.rectangle("fill",bgX1,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX2,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX3,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX4,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX5,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX6,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX7,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX8,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX9,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX10,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX11,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX12,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX13,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX14,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX15,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX16,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX17,0,4,love.graphics.getHeight())
    love.graphics.rectangle("fill",bgX18,0,4,love.graphics.getHeight())
    --love.graphics.rectangle("fill",bgX19,0,4,love.graphics.getHeight())
    --love.graphics.rectangle("fill",bgX20,0,4,love.graphics.getHeight())

    --for _,image in ipairs(images) do
    --  love.graphics.draw(image.img, image.x, 0, 0, 1, 1)
    --end
    bgX1 = bgX1 - speed
    bgX2 = bgX2 - speed
    bgX3 = bgX3 - speed
    bgX4 = bgX4 - speed
    bgX5 = bgX5 - speed
    bgX6 = bgX6 - speed
    bgX7 = bgX7 - speed
    bgX8 = bgX8 - speed
    bgX9 = bgX9 - speed
    bgX10 = bgX10 - speed
    bgX11 = bgX11 - speed
    bgX12 = bgX12 - speed
    bgX13 = bgX13 - speed
    bgX14 = bgX14 - speed
    bgX15 = bgX15 - speed
    bgX16 = bgX16 - speed
    bgX17 = bgX17 - speed
    bgX18 = bgX18 - speed
    --bgX19 = bgX19 - 5
    --bgX20 = bgX20 - 5

    if bgX1 < 0 then bgX1 = love.graphics.getHeight()*1.5 end
    if bgX2 < 0 then bgX2 = love.graphics.getHeight()*1.5 end
    if bgX3 < 0 then bgX3 = love.graphics.getHeight()*1.5 end
    if bgX4 < 0 then bgX4 = love.graphics.getHeight()*1.5 end
    if bgX5 < 0 then bgX5 = love.graphics.getHeight()*1.5 end
    if bgX6 < 0 then bgX6 = love.graphics.getHeight()*1.5 end
    if bgX7 < 0 then bgX7 = love.graphics.getHeight()*1.5 end
    if bgX8 < 0 then bgX8 = love.graphics.getHeight()*1.5 end
    if bgX9 < 0 then bgX9 = love.graphics.getHeight()*1.5 end
    if bgX10 < 0 then bgX10 = love.graphics.getHeight()*1.5 end
    if bgX11 < 0 then bgX11 = love.graphics.getHeight()*1.5 end
    if bgX12 < 0 then bgX12 = love.graphics.getHeight()*1.5 end
    if bgX13 < 0 then bgX13 = love.graphics.getHeight()*1.5 end
    if bgX14 < 0 then bgX14 = love.graphics.getHeight()*1.5 end
    if bgX15 < 0 then bgX15 = love.graphics.getHeight()*1.5 end
    if bgX16 < 0 then bgX16 = love.graphics.getHeight()*1.5 end
    if bgX17 < 0 then bgX17 = love.graphics.getHeight()*1.5 end
    if bgX18 < 0 then bgX18 = love.graphics.getHeight()*1.5 end
    --if bgX19 < 0 then bgX19 = love.graphics.getHeight()*1.5 end
    --if bgX20 < 0 then bgX20 = love.graphics.getHeight()*1.5 end

    for _,square in ipairs(squares) do
      love.graphics.setColor(251,60,178,150)
      love.graphics.rectangle("fill",square.x,square.y-2,4,4)
      love.graphics.setColor(251,60,178,75)
      love.graphics.rectangle("fill",square.x-6,square.y-6,16,16)
    end
  end
end

function Background.update()
  if GAME_STATE == PLAYING then

    for _,square in ipairs(squares) do
      if square.x<0 or square.x>love.graphics.getWidth() then
        line = math.floor(love.math.random(0,10))
        square.x = love.graphics.getWidth()
        square.y = love.graphics.getHeight()*0.1*line
      end
      square.x = square.x - 10
    end

    --if  last_x < love.graphics.getWidth() then
    --  Background.loadNewImage()
    --end

    --for _,image in ipairs(images) do
    --  image.x = image.x - speed
    --end

    --last_x = last_x - speed
  end
end
