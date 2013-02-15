
require("inheritance")
require("math")
--require("TEsound")

require("keys")
img_mob = love.graphics.newImage("assets/mob.png")
img_deadmob = love.graphics.newImage("assets/deadmob.png")
tileSize = 96

stage = "title"
require("stage")
keys = KeyState:create()
require("game")

stages["title"] = Title:create()
stages["intro"] = Intro:create()
stages["game"] = Game:create()

function love.load()
-- TEsound.playLooping("assets/.ogg", "music")
  love.mouse.setVisible( true )
  img_key = {}
  img_key[1] = love.graphics.newImage("assets/key_1.png")
  img_key[2] = love.graphics.newImage("assets/key_2.png")
  
  h1_font = love.graphics.newFont("assets/font.ttf",128)
  h2_font = love.graphics.newFont("assets/font.ttf",96)
  h3_font = love.graphics.newFont("assets/font.ttf",64)
  text_font = love.graphics.newFont("assets/font.ttf",48)  
  title_dt = 0
end


function love.draw()
  if stage == "gameover" then
    love.graphics.setColor(255,255,255,255)
    love.graphics.draw(bg[0],0,0)
    love.graphics.setColor(0,0,0,255)
    love.graphics.setFont(title_font)
    love.graphics.printf("Game Over!",0,48,800,"center")
    love.graphics.setFont(text_font)
    love.graphics.printf("Surviving Zombies: ".."TODO",0,136,800,"center")

  elseif stage == "quit" then
    love.graphics.setColor(255,255,255,255)
    love.graphics.setFont(text_font)
    --love.graphics.printf("Thanks for playing!\nsource: 0xff1d920e\nframework: love2d.org",420,20,360,"center")
  
  else stages[stage]:draw()
  end
end

function love.update(dt)
  --TEsound.cleanup()
  if stage == "game" then
    Game:update(dt)
  end
end

function love.mousepressed(x,y,button)
  stages[stage]:mouseClick(x, y)
end


function love.keypressed(key)
  keys[key] = true
  stages[stage]:keyPress(key)
  if keys[" "] then
    if stage == "title" then
      --stage = "intro"
      stage = "game"
      Game:init()
    elseif stage == "intro" then
      stage = "game"
      Game:init()
    elseif stage == "game" then
    elseif stage == "gameover" then
      stage = "title"
    end
  elseif keys["escape"] then
    if stage == "game" then
      stage = "title"
    elseif stage == "title" then
      --stage = "quit"
    elseif stage == "quit" then
    else
      --stage = "quit"
    end
  elseif keys["f11"] then
    keys[key] = false
    love.graphics.toggleFullscreen()
  end
end


function love.keyreleased(key)
  keys[key] = false
end


