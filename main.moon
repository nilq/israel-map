love.graphics.setBackgroundColor 1, 1, 1


lerp = (a, b, t) ->
  a + (b - a) * t


land = love.graphics.newImage "land.png"

states = {
  {"yellow", -2000, -1500, "Før Kaaananit-æra"}
  {"yellow", -1500, -1200, "Egyptisk Herredømme"}
  {"yellow", -1200, -1000, "Jebusit Kaananisk"}
  {"blue", -1000, -750, "Bibelsk Israel-Judah"}
  {"yellow", -750, -625, "Ny-Syrisk"}
  {"yellow", -625, -500, "Ny Babelonsk"}
  {"yellow", -500, -350, "Persien"}
  {"yellow", -350, -180, "Ptolemæisk Makedonsk"}
  {"blue", -180, -70, "Judah"}
  {"yellow", -70, 300, "Romersk"}
  {"red", 300, 600, "Byzantinsk"}
  {"yellow", 600, 610, "Persisk"}
  {"red", 610, 617, "Byzantinsk"}
  {"green", 617, 640, "Rashidun Kalifat"}
  {"green", 640, 690, "Urnayyad Kalifat"}
  {"green", 690, 950, "Abbasid Kalifat"}
  {"green", 950, 1050, "Fatimid Kalifat"}
  {"green", 1050, 1080, "Seljuk Imperiet"}
  {"red", 1080, 1187, "Kongeriget Jerusalem"}
  {"green", 1187, 1229, "Det ayyubiske sultanat"}
  {"red", 1229, 1244, "Kongeriget Jerusalem"}
  {"green", 1244, 1260, "Det ayyubiske sultanat"}
  {"green", 1260, 1500, "Mamluk sultanatet"}
  {"green", 1500, 1917, "Osmanner-riget"}
  {"red", 1917, 1947, "Britisk Mandat"}
  {"blue", 1947, 2018, "Israel"}
}

color_str = (name) ->
  switch states[state][1]
    when "yellow"
      { 1, 1, 0 }
    when "red"
      { 1, 0, 0 }
    when "green"
      { 0, 1, 0 }
    when "blue"
      { 0, 0, 1 }

export timer = 0
export state = 1
export color = color_str states[state][1]
export new_color = color

export use_time = false

change_state = (a) ->
  timer = 0
  state += a
  
  if state > #states
    state = #states
  
  if state < 1
    state = 1

  new_color = color_str states[state][1]

with love
  .load = ->
    timer = 0
    state = 1

  .update = (dt) ->
    if use_time
      timer += dt

    color[1] = lerp color[1], new_color[1], dt
    color[2] = lerp color[2], new_color[2], dt
    color[3] = lerp color[3], new_color[3], dt

    if timer > (states[state][3] - states[state][2]) / 50

      change_state 1

  .draw = ->
    with love.graphics
      .setColor 0, 0, 0

      .push!
      .scale 1.3, 1.3

      .print states[state][4] .. ": fra #{states[state][2]} til #{states[state][3]}", 10, 10
      .print "År: " .. (math.floor states[state][2] + timer * 50), 10, 25
      .print "Pause", 10, 60 unless use_time

      .pop!

      .setColor color
      
      .draw land, 0, 0, 0, .getWidth! / land\getWidth!, .getHeight! / land\getHeight!

  .keypressed = (key) ->
    switch key
      when "space"
        use_time = not use_time
      when "left"
        change_state -1
      when "right"
        change_state 1
    