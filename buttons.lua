

function addButtons()

  ---------------------------------- PLAY AGAIN
  local playAgainBtn = UIButton:new()
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
  local startGame = UIButton:new()
  startGame:setPos(love.graphics.getWidth()/4, love.graphics.getHeight()/1.6)
  startGame:setWidth(450)
  startGame:setHeight(120)
  --startGame:setText("Start game")
  startGame:setAnchor(0,0)
  startGame:setEnabled(true)
  startGame:setVisible(true)
  startGame.press = function()
    -- hide the button when pressed
    startGame:setVisible(false)
    world.play()
  end
  world.buttons["start_game"] = startGame


end
