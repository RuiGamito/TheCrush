

function addButtons()

  local playAgainBtn = UIButton:new()
  local startGame = UIButton:new()
  local credits = UIButton:new()

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
  startGame:setPos(love.graphics.getWidth()/4.2, love.graphics.getHeight()/1.6)
  startGame:setWidth(450)
  startGame:setHeight(120)
  --startGame:setText("Start game")
  startGame:setAnchor(0,0)
  startGame:setEnabled(true)
  startGame:setVisible(true)
  startGame:setUpColor({0,0,0,0})
  startGame.press = function()
    -- hide the button when pressed
    startGame:setVisible(false)
    credits:setVisible(false)
    world.play()
  end
  world.buttons["start_game"] = startGame

  ---------------------------------- CREDITS
  credits:setPos(love.graphics.getWidth()/2.1, love.graphics.getHeight()/1.15)
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


end
