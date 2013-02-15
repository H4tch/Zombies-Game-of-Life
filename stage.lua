
Stage = {}
Stage_mt = { __index = Stage }

-- not used
function Stage:create(  )
  local stage = {}
  setmetatable( stage, Stage_mt )
  return stage
end

function Stage:keyPress(keys)
end

function Stage:mouseClick(x,y,button)
end

function Stage:test()
end


