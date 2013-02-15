

require("stage")
require("intro")
stages = {}
stage = "title"
require("grid")

require("player")

Game = deriving(Stage)
Game_mt = {__index = Game}

Game.gridStates = {}    -- Holds onto all the history

function Game:init()
  grid = Grid:create( 800, 600-45, 15, 0, 45 )
  tileScale = grid.cellSize / tileSize
  mobScale = grid.cellSize / 48
  
  Game.countdown = 16
  Game.updateInterval = 1
  Game.refTime = 0
  Game.centerMessage = "Start!"
  Game.state = "pre-game" -- "running","paused","replay"
  
  Game.initialMobs = math.random(grid.columns-math.floor(grid.columns/3), grid.columns)
  player1.currentMobs = Game.initialMobs
  player2.currentMobs = Game.initialMobs
  player1.x = math.floor(grid.columns/4)
  player1.y = math.floor(grid.rows/2)
  player2.x = player1.x + math.floor(grid.columns/2)
  player2.y = player1.y
end

function Game:update(dt)
  Game.refTime = Game.refTime + dt
  if Game.state == "pre-game" then
  	Game.countdown = Game.countdown - dt
    if Game.countdown < 0 then
      Game.centerMessage = "Vs"
      Game.state = "running"
      Game.refTime = 0
    else Game.centerMessage = math.floor( Game.countdown )
    end
  elseif Game.state == "running" then
  	if Game.refTime > Game.updateInterval then
  	  Game.refTime = 0
      Game:updateGrid()
    end
  --elseif Game.state == "paused" then Game:drawPaused()
  end
end

-- This function handles all the rules for 'updation'
function Game:updateGrid()
 if Game.state ~= "paused" then
  local newState = {}
  for c = 1,grid.columns do
  	newState[c] = {}
    for r = 1,grid.rows do
    	local neighbors = Grid:numberOfNeighbors(c,r)
    	local state = grid.cell[c][r]
    	
    	if state == -1 then newState[c][r] = 0  -- Reset dead Cell
--    	      grid.cell[c][r] = 0
    	end
    	if state > 0 then
    	  if neighbors < 2 or neighbors > 3 then
    	    newState[c][r] = -1  -- Cell died
--    	    grid.cell[c][r] = -1
          else newState[c][r] = grid.cell[c][r] -- Unchanged
    	  end
    	elseif neighbors == 3 then newState[c][r] = 1 -- Dead cell brought to life
--    	   grid.cell[c][r] = 1
    	else newState[c][r] = 0 -- Unchanged
    	end
    end
  end
  grid.cell = newState
 end
end


function Game:draw()
  grid:draw()
  Game:draw_mobs()
  love.graphics.setColor(255,10,10,255)
  Game:draw_player(player1)
  love.graphics.setColor(20,20,255,255)
  Game:draw_player(player2)
  love.graphics.setColor(255,255,255,255)
  Game:draw_hud()
end

function Game:draw_player(player)
  local x,y = Grid:getRelativePixelFromCell(player.x, player.y)
  love.graphics.draw(player.img, x+4, y+4, 0, tileScale, tileScale, 24,24)
end

function Game:draw_mobs()
  love.graphics.setColor(255,255,255,255)
  for c,col in ipairs(grid.cell) do
    for r,mob in ipairs(col) do
      if mob == 0 then else
        local x,y = Grid:getRelativePixelFromCell(c,r)
        if mob == -1 then
            love.graphics.draw( img_deadmob, x+(10*mobScale), y+(20*mobScale), 0, mobScale, mobScale,24,24 )
        elseif mob == 1 then
            love.graphics.draw( img_mob, x+(10*mobScale), y+(20*mobScale), 0,mobScale,mobScale,24,24 )
        end
      end
    end
  end
end


function Game:draw_hud()
  love.graphics.setColor(255,255,255,255)
  love.graphics.setFont(h2_font)
  love.graphics.printf(Game.centerMessage,400-20,-27,40,"center")
  
  love.graphics.setFont(h3_font)
  love.graphics.setColor(150,10,10,255)
  love.graphics.printf("Player One",15,-8,150,"left")
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(img_mob, 180, 25, 0,1,1,24,24)
  love.graphics.printf("x",218,-17,50,"left")
  love.graphics.printf(player1.currentMobs,240,-9,50,"left")
  
  love.graphics.setColor(20,20,120,255)
  love.graphics.printf("Player Two",800-295,-8,150,"right")
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(img_mob, 800-120, 25, 0,1,1,24,24)
  love.graphics.printf("x",800-82,-17,50,"left")
  love.graphics.printf(player2.currentMobs,800-60,-9,50,"left")
end

function Game:keyPress(key)
-- Player One
  if keys["tab"] then
    if player1.spawnLock then player1.spawnLock = false
      else player1.spawnLock = true; player1:spawnMob()
    end
  end
  if keys["lshift"] or keys["lalt"] then
    player1:spawnMob()
  end
  if keys["a"] then player1:moveTo( player1.x-1, player1.y )
  elseif keys["d"] then player1:moveTo( player1.x+1, player1.y )
  elseif keys["w"] then player1:moveTo( player1.x, player1.y-1 )
  elseif keys["s"] then player1:moveTo( player1.x, player1.y+1 )
  end

-- Player Two
  if keys["return"] then
    if player2.spawnLock then player2.spawnLock = false
      else player2.spawnLock = true; player2:spawnMob()
    end
  end
  if keys["rshift"] or keys["rctrl"] then
    player2:spawnMob()
  end
  if keys["left"] then player2:moveTo( player2.x-1, player2.y )
  elseif keys["right"] then player2:moveTo( player2.x+1, player2.y )
  elseif keys["up"] then player2:moveTo( player2.x, player2.y-1 )
  elseif keys["down"] then player2:moveTo( player2.x, player2.y+1 )
  end
 
  if keys["escape"] then
  	Game.state = "pre-game"
    stage = "title"
  end
  
  keys[key] = false

end

function Game:mouseClick( x, y )
  local col,row = Grid:getCellFromRelativePixel( x, y )
  if Grid:isWithin( col, row ) then
    if grid.cell[col][row] <= 0 then
--      if player1.currentMobs <= 0 then return end
--      player1.currentMobs = player1.currentMobs - 1
      grid.cell[col][row] = 1
    else
--      player1.currentMobs = player1.currentMobs + 1
      grid.cell[col][row] = 0
    end
  end
end


