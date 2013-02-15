
-- Holds the state of all keys, and whether they are pressed.
--  TODO: Add the "f#" keys and the keys with 'names' like
--  'return' 'escape' etc....

KeyState = {}
KeyState_mt = { __index = KeyState }

function KeyState:create()
  local empty_keys = {
   ["A"]=false, ["a"]=false
  ,["B"]=false, ["b"]=false
  ,["C"]=false, ["c"]=false
  ,["D"]=false, ["d"]=false
  ,["E"]=false, ["e"]=false
  ,["F"]=false, ["f"]=false
  ,["G"]=false, ["g"]=false
  ,["H"]=false, ["h"]=false
  ,["I"]=false, ["i"]=false
  ,["J"]=false, ["j"]=false
  ,["K"]=false, ["k"]=false
  ,["L"]=false, ["l"]=false
  ,["M"]=false, ["m"]=false
  ,["N"]=false, ["n"]=false
  ,["O"]=false, ["o"]=false
  ,["P"]=false, ["p"]=false
  ,["Q"]=false, ["q"]=false
  ,["R"]=false, ["r"]=false
  ,["S"]=false, ["s"]=false
  ,["T"]=false, ["t"]=false
  ,["U"]=false, ["u"]=false
  ,["V"]=false, ["v"]=false
  ,["W"]=false, ["w"]=false
  ,["X"]=false, ["x"]=false
  ,["Y"]=false, ["y"]=false
  ,["Z"]=false, ["z"]=false
  
  ,["1"]=false, ["2"]=false, ["3"]=false, ["4"]=false, ["5"]=false
  ,["6"]=false, ["7"]=false, ["8"]=false, ["9"]=false, ["0"]=false
  ,["!"]=false, ["@"]=false, ["#"]=false, ["$"]=false, ["%"]=false
  ,["^"]=false, ["&"]=false, ["*"]=false, ["("]=false, [")"]=false
  ,["~"]=false, ["`"]=false
  ,["-"]=false, ["_"]=false
  ,["="]=false, ["+"]=false
  ,["["]=false, ["]"]=false
  ,["{"]=false, ["}"]=false
  ,["\\"]=false,[ "|"]=false
  ,[";"]=false, [":"]=false
  ,["'"]=false, ["\""]=false
  ,[","]=false, ["."]=false
  ,["<"]=false, [">"]=false
  ,["/"]=false, ["?"]=false
  
  ,["f1"]=false, ["f2"]=false, ["f3"]=false, ["f4"]=false, ["f5"]=false, ["f6"]=false
  ,["f7"]=false, ["f8"]=false, ["f9"]=false, ["f10"]=false, ["f11"]=false, ["f12"]=false

  ,["left"]=false, ["right"]=false, ["up"]=false, ["down"]=false
  ,["return"]=false, ["escape"]=false, ["tab"]=false, ["backspace"]=false
  ,["home"]=false, ["pageup"]=false, ["pagedown"]=false, ["end"]=false  
  ,["rshift"]=false, ["lshift"]=false
  ,["rctrl"]=false, ["lctrl"]=false
  ,["ralt"]=false, ["lalt"]=false
  ,["rmeta"]=false, ["lmeta"]=false
  ,["delete"]=false, ["insert"]=false
  ,["menu"]=false,["pause"]=false
  }
  return empty_keys
end

