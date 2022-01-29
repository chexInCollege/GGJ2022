game_state = "InGame" -- game state

require("code/libs") -- imports all relevant functions and variable declarations

g.loadSkin("default") -- load default skin



function love.draw() -- Runs every time the game draws (MORE than 60 times/sec)
    g.render() -- render the base desktop

    if game_state == "InGame" then
        game.render()
    elseif game_state == "Menu" then
        menu.render()
    end


end

function love.update(dt) -- runs about 60 times/sec

    if game_state == "InGame" then
        game.update(dt)
    elseif game_state == "Menu" then
        menu.update(dt)
    end


    if math.random(1, 10) == 1 then
        local dirs = {"left", "right", "up", "down"}
        game.createBeat(1, 1.5, dirs[math.random(1,4)], math.random(2) == 1 and "red" or "blue", "outer", math.random(1,5))
    end

end



