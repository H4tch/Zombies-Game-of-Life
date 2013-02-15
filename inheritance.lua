
-- NewClass = deriving( BaseClass )
function deriving( baseClass )
  local class = {}
  local class_mt = { __index = class }

  -- Default implementation of create(), can be overridden
  function class:create()
    local newinst = {}
    setmetatable( newinst, class_mt )
    return newinst
  end

  if baseClass then
    setmetatable( class, { __index = baseClass } )
  end
return class
end


