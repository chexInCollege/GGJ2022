game_state = "Menu" -- game state

require("code/libs") -- imports all relevant functions and variable declarations
require("code/particles")

game.songPreview = 0

g.loadSkin("default") -- load default skin

if game_state == "InGame" then
    game.init()
end

function love.draw() -- Runs every time the game draws (MORE than 60 times/sec)
    g.render() -- render the base desktop

    if game_state == "InGame" then
        game.render()
    elseif game_state == "Menu" then
        menu.render()
    elseif game.state == "GameDone" then
        done.render()
    end

    --if game.currentSong then print(game.currentSong:tell()) end

end

function love.update(dt) -- runs about 60 times/sec

    if game_state == "InGame" then
        game.update(dt)
        print(game.beatCount, "/", game.totalBeats)
    elseif game_state == "Menu" then
        menu.update(dt)
    end

    particle.update(dt)
end

function love.keypressed(key)
    core.checkInput(key)


end

