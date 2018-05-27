love.graphics.setBackgroundColor(1, 1, 1)
local lerp
lerp = function(a, b, t)
  return a + (b - a) * t
end
local land = love.graphics.newImage("land.png")
local states = {
  {
    "yellow",
    -2000,
    -1500,
    "Før Kaaananit-æra"
  },
  {
    "yellow",
    -1500,
    -1200,
    "Egyptisk Herredømme"
  },
  {
    "yellow",
    -1200,
    -1000,
    "Jebusit Kaananisk"
  },
  {
    "blue",
    -1000,
    -750,
    "Bibelsk Israel-Judah"
  },
  {
    "yellow",
    -750,
    -625,
    "Ny-Syrisk"
  },
  {
    "yellow",
    -625,
    -500,
    "Ny Babelonsk"
  },
  {
    "yellow",
    -500,
    -350,
    "Persien"
  },
  {
    "yellow",
    -350,
    -180,
    "Ptolemæisk Makedonsk"
  },
  {
    "blue",
    -180,
    -70,
    "Judah"
  },
  {
    "yellow",
    -70,
    300,
    "Romersk"
  },
  {
    "red",
    300,
    600,
    "Byzantinsk"
  },
  {
    "yellow",
    600,
    610,
    "Persisk"
  },
  {
    "red",
    610,
    617,
    "Byzantinsk"
  },
  {
    "green",
    617,
    640,
    "Rashidun Kalifat"
  },
  {
    "green",
    640,
    690,
    "Urnayyad Kalifat"
  },
  {
    "green",
    690,
    950,
    "Abbasid Kalifat"
  },
  {
    "green",
    950,
    1050,
    "Fatimid Kalifat"
  },
  {
    "green",
    1050,
    1080,
    "Seljuk Imperiet"
  },
  {
    "red",
    1080,
    1187,
    "Kongeriget Jerusalem"
  },
  {
    "green",
    1187,
    1229,
    "Det ayyubiske sultanat"
  },
  {
    "red",
    1229,
    1244,
    "Kongeriget Jerusalem"
  },
  {
    "green",
    1244,
    1260,
    "Det ayyubiske sultanat"
  },
  {
    "green",
    1260,
    1500,
    "Mamluk sultanatet"
  },
  {
    "green",
    1500,
    1917,
    "Osmanner-riget"
  },
  {
    "red",
    1917,
    1947,
    "Britisk Mandat"
  },
  {
    "blue",
    1947,
    2018,
    "Israel"
  }
}
local color_str
color_str = function(name)
  local _exp_0 = states[state][1]
  if "yellow" == _exp_0 then
    return {
      1,
      1,
      0
    }
  elseif "red" == _exp_0 then
    return {
      1,
      0,
      0
    }
  elseif "green" == _exp_0 then
    return {
      0,
      1,
      0
    }
  elseif "blue" == _exp_0 then
    return {
      0,
      0,
      1
    }
  end
end
timer = 0
state = 1
color = color_str(states[state][1])
new_color = color
use_time = false
local change_state
change_state = function(a)
  timer = 0
  state = state + a
  if state > #states then
    state = #states
  end
  if state < 1 then
    state = 1
  end
  new_color = color_str(states[state][1])
end
do
  local _with_0 = love
  _with_0.load = function()
    timer = 0
    state = 1
  end
  _with_0.update = function(dt)
    if use_time then
      timer = timer + dt
    end
    color[1] = lerp(color[1], new_color[1], dt)
    color[2] = lerp(color[2], new_color[2], dt)
    color[3] = lerp(color[3], new_color[3], dt)
    if timer > (states[state][3] - states[state][2]) / 50 then
      return change_state(1)
    end
  end
  _with_0.draw = function()
    do
      local _with_1 = love.graphics
      _with_1.setColor(0, 0, 0)
      _with_1.push()
      _with_1.scale(1.3, 1.3)
      _with_1.print(states[state][4] .. ": fra " .. tostring(states[state][2]) .. " til " .. tostring(states[state][3]), 10, 10)
      _with_1.print("År: " .. (math.floor(states[state][2] + timer * 50)), 10, 25)
      if not (use_time) then
        _with_1.print("Pause", 10, 60)
      end
      _with_1.pop()
      _with_1.setColor(color)
      _with_1.draw(land, 0, 0, 0, _with_1.getWidth() / land:getWidth(), _with_1.getHeight() / land:getHeight())
      return _with_1
    end
  end
  _with_0.keypressed = function(key)
    local _exp_0 = key
    if "space" == _exp_0 then
      use_time = not use_time
    elseif "left" == _exp_0 then
      return change_state(-1)
    elseif "right" == _exp_0 then
      return change_state(1)
    end
  end
  return _with_0
end
