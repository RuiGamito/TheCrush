

function addButtons()

  ---------------------------------- PLAY AGAIN
  local playAgainBtn = UIButton:new()
  playAgainBtn:setPos(200, 300)
  playAgainBtn:setWidth(600)
  playAgainBtn:setHeight(90)
  playAgainBtn:setText("Press to play again")
  playAgainBtn:setAnchor(0, 0)
  --playAgainBtn:setEnabled(true)
  playAgainBtn:setVisible(false)
  playAgainBtn.press = function()
    -- hide the button when pressed
    playAgainBtn:setVisible(false)
    world.play()
  end
  world.buttons["play_again"] = playAgainBtn


  ---------------------------------- START GAME
  local startGame = UIButton:new()
  startGame:setPos(200, 300)
  startGame:setWidth(400)
  startGame:setHeight(90)
  startGame:setText("Start game")
  startGame:setAnchor(0, 0)
  startGame:setEnabled(true)
  startGame:setVisible(true)
  startGame.press = function()
    -- hide the button when pressed
    startGame:setVisible(false)
    world.play()
  end
  world.buttons["start_game"] = startGame

end
