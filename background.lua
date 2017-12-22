Background={
  x=0
}

local next_image = 1
local last_x = 0
--local width = 2650
local loaded_images = {}
local images = {}
local speed = 5

function Background.create()
  local self = setmetatable({}, Background)
  self.x = love.graphics.getWidth()
  self.image = love.graphics.newImage("img/start_copy.jpg")
  return self
end

function Background.load()
   -- other things
   images_fs = {
     "img/001.png",
     "img/002.png",
     "img/003.png",
     "img/004.png",
     "img/005.png",
     "img/006.png",
     "img/007.png",
     "img/008.png",
     "img/009.png",
     "img/010.png",
     "img/011.png",
     "img/012.png",
     "img/013.png",
     "img/014.png"
   }

   for id,im in ipairs(images_fs) do
     loaded_images[id] = love.graphics.newImage(im)
   end
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

function Background.draw()
  if GAME_STATE == PLAYING then
    love.graphics.setColor(100,100,100)
    love.graphics.clear()
    for _,image in ipairs(images) do
      love.graphics.draw(image.img, image.x, 0, 0, 1, 1)
    end
  end
end

function Background.update()
  if GAME_STATE == PLAYING then
    if  last_x < love.graphics.getWidth()  then
      Background.loadNewImage()
    end

    for _,image in ipairs(images) do
      image.x = image.x - speed
    end

    last_x = last_x - speed
  end
end
