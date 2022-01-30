game_state = "InGame" -- game state

require("code/libs") -- imports all relevant functions and variable declarations
require("code/particles")

g.loadSkin("default") -- load default skin

game.init()


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

    particle.update(dt)
end

function love.keypressed(key)
    core.checkInput(key)


end

