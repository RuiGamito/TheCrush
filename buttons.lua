

function addButtons()

  local playAgainBtn = UIButton:new()
  local startGame = UIButton:new()
  local multiplayer = UIButton:new()
  local credits = UIButton:new()
  local howtoplay = UIButton:new()

  ---------------------------------- PLAY AGAIN
  playAgainBtn:setPos(love.graphics.getWidth()/4, love.graphics.getHeight()/2)
  playAgainBtn:setWidth(600)
  playAgainBtn:setHeight(90)
  playAgainBtn:setText("Play again")
  playAgainBtn:setAnchor(0, 0)
  playAgainBtn:setVisible(false)
  playAgainBtn.press = function()
    -- hide the button when pressed
    playAgainBtn:setVisible(false)
    world.play()
  end
  world.buttons["play_again"] = playAgainBtn

  ---------------------------------- START GAME
  startGame:setPos(love.graphics.getWidth()/5.8, love.graphics.getHeight()/1.58)
  startGame:setWidth(550)
  startGame:setHeight(120)
  --startGame:setText("Start game")
  startGame:setAnchor(0,0)
  startGame:setEnabled(true)
  startGame:setVisible(true)
  startGame:setUpColor({0,0,0,255})
  startGame:setDownColor({0,0,0,255})
  startGame.press = function()
    -- hide the button when pressed
    startGame:setVisible(false)
    credits:setVisible(false)
    multiplayer:setVisible(false)
    howtoplay:setVisible(false)
    world.play()
  end
  world.buttons["start_game"] = startGame

  ---------------------------------- MULTIPLAYER
  multiplayer:setPos(love.graphics.getWidth()/1.6, love.graphics.getHeight()/1.58)
  multiplayer:setWidth(550)
  multiplayer:setHeight(120)
  --startGame:setText("Start game")
  multiplayer:setAnchor(0,0)
  multiplayer:setEnabled(true)
  multiplayer:setVisible(true)
  multiplayer:setUpColor({0,0,0,255})
  multiplayer:setDownColor({0,0,0,255})
  multiplayer.press = function()
    -- hide the button when pressed
    startGame:setVisible(false)
    credits:setVisible(false)
    multiplayer:setVisible(false)
    GAME_STATE=MULTIPLAYER
  end
  world.buttons["multiplayer"] = multiplayer

  ---------------------------------- CREDITS
  credits:setPos(love.graphics.getWidth()/1.2, love.graphics.getHeight()/1.15)
  credits:setWidth(350)
  credits:setHeight(120)
  credits:setAnchor(0,0)
  credits:setEnabled(true)
  credits:setVisible(true)
  credits:setUpColor({0,0,0,255})
  credits:setDownColor({0,0,0,255})
  credits:setStroke(0)
  credits:setStrokeColor({0,0,0,255})
  credits.press = function()
    -- hide the button when pressed
    GAME_STATE=CREDITS
    credits:setVisible(false)
  end
  world.buttons["credits"] = credits

  ---------------------------------- HOW TO PLAY
  howtoplay:setPos(love.graphics.getWidth()/20, love.graphics.getHeight()/1.15)
  howtoplay:setWidth(350)
  howtoplay:setHeight(120)
  howtoplay:setAnchor(0,0)
  howtoplay:setEnabled(true)
  howtoplay:setVisible(true)
  howtoplay:setUpColor({0,0,0,255})
  howtoplay:setDownColor({0,0,0,255})
  howtoplay:setStroke(0)
  howtoplay:setStrokeColor({0,0,0,255})
  howtoplay.press = function()
    -- hide the button when pressed
    GAME_STATE=HOWTOPLAY
    howtoplay:setVisible(false)
  end
  world.buttons["howtoplay"] = howtoplay


end
