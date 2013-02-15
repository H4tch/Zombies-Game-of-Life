
-- Defines the Game's grid.

Grid = {}
Grid_mt = { __index = Grid }

function Grid:create( width, height, cellSize, x, y, columns, rows )
  local grid = {}
    grid.cellSize = cellSize or 80
    grid.columns = 0
    grid.rows = 0

    if width then
      grid.columns = columns or math.floor(width / cellSize)
      if x then grid.xOffset = x + ( width - (grid.columns * grid.cellSize) ) / 2
      else
        grid.xOffset = ( width - (grid.columns * grid.cellSize) ) / 2
      end
    else
      grid.columns = columns
      grid.xOffset = x or 0
    end
    
    if height then
      grid.rows = rows or math.floor(height / cellSize) 
      if y then grid.yOffset = y + ( height - (grid.rows * grid.cellSize) ) / 2
      else
        grid.yOffset = ( height - (grid.rows * grid.cellSize) ) / 2
      end
    else
      grid.rows = rows
      grid.yOffset = y or 0
    end

    grid.cell = {}
    -- Iterate and create empty arrays
    for c = 1,grid.columns do
      grid.cell[c] = {}
      for r = 1,grid.rows do
        grid.cell[c][r] = 0
      end
    end
    setmetatable( grid, Grid_mt )

  function Grid:insert( cellColumn, cellRow, object )
    grid.cell[col][row] = object
  end

  function Grid:getCellFromRelativePixel( x, y )
    local column = 1 + math.floor( (x - grid.xOffset) / (grid.cellSize) )
    local row = 1 + math.floor( (y - grid.yOffset) / (grid.cellSize) )
    return column, row
  end

  function Grid:getRelativePixelFromCell( x, y )
    local newX = (grid.cellSize * x) + grid.xOffset - grid.cellSize
    local newY = (grid.cellSize * y) + grid.yOffset - grid.cellSize
    return newX, newY
  end

  function Grid:isWithin( x, y)
    if x > 0 and x <= grid.columns and
      y > 0 and y <= grid.rows
    then return true
    else return false
    end
  end
  
  -- 8-neighbors
  function Grid:numberOfNeighbors(x,y)
    if Grid:isWithin(x,y) then else return end
    local neighbors = 0 
      if grid.cell[x-1] then
        if grid.cell[x-1][y] and grid.cell[x-1][y] > 0 then neighbors = neighbors + 1 end
        if grid.cell[x-1][y-1] and grid.cell[x-1][y-1] > 0 then neighbors = neighbors + 1 end
        if grid.cell[x-1][y+1] and grid.cell[x-1][y+1] > 0 then neighbors = neighbors + 1 end
      end
      if grid.cell[x+1] then
        if grid.cell[x+1][y] and grid.cell[x+1][y] > 0 then neighbors = neighbors + 1 end
        if grid.cell[x+1][y-1] and grid.cell[x+1][y-1] > 0 then neighbors = neighbors + 1 end
        if grid.cell[x+1][y+1] and grid.cell[x+1][y+1] > 0 then neighbors = neighbors + 1 end
      end
      if grid.cell[x][y-1] and grid.cell[x][y-1] > 0 then neighbors = neighbors + 1 end
      if grid.cell[x][y+1] and grid.cell[x][y+1] > 0 then neighbors = neighbors + 1 end
   -- print(neighbors)
    return neighbors
  end


  function Grid:draw( state )
    love.graphics.setLineWidth(1)
    love.graphics.setColor(255,255,255,100)

    local x1 = grid.xOffset
    local y1 = grid.yOffset
    local x2 = grid.columns*grid.cellSize + x1
    local y2 = grid.rows*grid.cellSize + y1
    
    -- Draw Frame
    for xn = 0,grid.cellSize*grid.columns,grid.cellSize do
      love.graphics.line( xn+x1, y1, xn+x1, y2 )
    end
    for yn = 0,grid.cellSize*grid.rows,grid.cellSize do
      love.graphics.line( x1, yn+y1, x2, yn+y1 )
    end
  end

  return grid
end

