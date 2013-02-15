
Player = {}
Player_mt = {__index = Player}

function Player:moveTo(x,y)
  if Grid:isWithin( x, y ) then self.x = x; self.y = y end
  if self.spawnLock then self:spawnMob() return end
end

function Player:spawnMob()
  if Grid:isWithin( self.x, self.y ) then
    if grid.cell[self.x][self.y] <= 0 then
      if self.currentMobs <= 0 then return end
      self.currentMobs = self.currentMobs - 1
      grid.cell[self.x][self.y] = 1
    else if self.spawnLock then return end
      self.currentMobs = self.currentMobs + 1
      grid.cell[self.x][self.y] = 0
    end
  end
end

function Player:create( width, height, cellSize, x, y, columns, rows )
  local player = {}
  --player.currentMobs = 5
  player.x = 1
  player.y = 1
  player.number = 1
  player.spawnLock = false  -- Causes an auto placement of mobs if enabled.
  player.img = love.graphics.newImage("assets/grid_selection.png")
  setmetatable( player, Player_mt )
  return player
end


player1 = Player:create()
player1.number = 1
--player1.img = love.graphics.newImage("assets/p1_select2.png")

player2 = Player:create()
player2.number = 2
--player2.img = love.graphics.newImage("assets/p2_select.png")
