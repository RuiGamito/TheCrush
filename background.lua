Background={
  x=0
}

local images = {}
local speed = 5
local loaded_images = {}

function Background.load()

   images_fs = {
     "img/teste.png"
   }

   for id,im in ipairs(images_fs) do
     loaded_images[id] = love.graphics.newImage(im)
   end

   Background.reset()
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
end

function Background.draw()

  if bgX1 == nil then Background.startStuff() end

  if GAME_STATE == PLAYING then
    love.graphics.setColor(255,255,255)
    love.graphics.clear()
    love.graphics.setColor(8,36,114)
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

    --for _,image in ipairs(images) do
    --  love.graphics.draw(image.img, image.x, 0, 0, 1, 1)
    --end
    bgX1 = bgX1 - 5
    bgX2 = bgX2 - 5
    bgX3 = bgX3 - 5
    bgX4 = bgX4 - 5
    bgX5 = bgX5 - 5
    bgX6 = bgX6 - 5
    bgX7 = bgX7 - 5
    bgX8 = bgX8 - 5
    bgX9 = bgX9 - 5
    bgX10 = bgX10 - 5
    bgX11 = bgX11 - 5
    bgX12 = bgX12 - 5
    bgX13 = bgX13 - 5
    bgX14 = bgX14 - 5
    bgX15 = bgX15 - 5
    bgX16 = bgX16 - 5

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


  end
end

function Background.update()
  if GAME_STATE == PLAYING then

    if  last_x < love.graphics.getWidth()  then
      Background.loadNewImage()
    end

    for _,image in ipairs(images) do
      image.x = image.x - speed
      descrement = decrement - speed
    end

    last_x = last_x - speed
  end
end
