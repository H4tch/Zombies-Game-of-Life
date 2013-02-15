
require("stage")

Title = deriving(Stage)
Title_mt = {__index = Title}

function Title:onKeyPress(key)
  print("Key press from Title Screen!")
  	if key[" "] then
        stage = "intro"
    elseif key["escape"] then
    	stage = "quit"
  	end
  	print(key.."pressed")
end

function Title:draw()
  love.graphics.setColor(0,0,0,255)
--  love.graphics.fill(0,0,800,600)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(h1_font)
  love.graphics.printf("Zombies: The Game of Life",0,48,800,"center")
  love.graphics.setColor(150,10,10,255)
  love.graphics.setFont(h3_font)
  love.graphics.printf("v0.1",-60,135,800,"right")
  love.graphics.setColor(255,255,255,255)
  love.graphics.printf("Press space!",0,600-72,800,"center")
  love.graphics.setColor(255,255,255,255)
end


Intro = deriving(Stage)
Intro_mt = {__index = Intro}

function Intro:onKeyPress(key)
  print("Key press from Intro Screen!")
  	if key[" "] then
        stage = "game"
    elseif key["escape"] then
      stage = "title"
  	end
end

function Intro:draw()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(text_font)
  love.graphics.printf("How To Play",0,96,800,"center")
  love.graphics.setFont(text_font)
  love.graphics.printf("Use the WASD keys move to move",0,232,800,"center")
  local key_x = 90
  local key_y = 350-17
  love.graphics.draw(img_key[1],64+key_x,key_y,0,.5)
  love.graphics.draw(img_key[1],key_x,64+key_y,0,.5)
  love.graphics.draw(img_key[1],64+key_x,64+key_y,0,.5)    
  love.graphics.draw(img_key[1],128+key_x,64+key_y,0,.5)
  love.graphics.draw(img_key[2],key_x,128+key_y,0,.5)
  
  love.graphics.setFont(text_font)
  love.graphics.setColor(0,0,0,255)
  love.graphics.printf("W",64+key_x,key_y,64,"center")
  love.graphics.printf("S",64+key_x,64+key_y,64,"center")
  love.graphics.printf("A",key_x,64+key_y,64,"center")
  love.graphics.printf("D",128+key_x,64+key_y,64,"center")
  love.graphics.printf("SPACE",key_x,128+key_y,192,"center")
  
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(img_mob,400,410,0,1,1,33,33)
  love.graphics.draw(img_deadmob,400,480,0,1,1,32,24)
  love.graphics.setColor(255,255,255,255)
  love.graphics.print("Zombie!",450,410-35)
  love.graphics.print("Dead Zombie!",450,480-25)
  love.graphics.setColor(255,255,255,255)
end

