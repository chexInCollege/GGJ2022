---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by chex.
--- DateTime: 1/28/2022 7:56 PM
---


--- global game tables
core = {} -- basic libraries and functions (core.draw, etc)
g = {}    -- holds all GLOBAL data (independent of game state)
game = {} -- holds all functions/vars relative to the game
menu = {} -- holds all functions/vars relative to the menu

--- love2d constants
lfs = love.filesystem
lg = love.graphics
ls = love.system
lw = love.window
lk = love.keyboard


------------------------ 'core' variables
-- determine the window size
core.sWidth, core.sHeight = lg.getDimensions()

-- determine the "bump" values
core.bumpX = (core.sWidth-800)/2
core.bumpY = (core.sHeight-600)/2

core.keyMaps = {
    left = "leftR",
    right = "rightR",
    up = "upR",
    down = "downR",

    a = "leftL",
    d = "rightL",
    w = "upL",
    s = "downL",

    ["return"] = "confirm",
    escape = "cancel"
}
------------------------ 'g' variables

-- stores all images used in the game
g.img = {}
g.imagePointers = {
    desktop = "desktop.png",
    playAreaBg = "playAreaBg.png",
    playAreaWindow = "playAreaWindow.png",
    playAreaForeground = "playAreaForeground.png",
    progressWindow = "progressWindow.png",
    menuTask = "task.png",
    menuTaskSelected = "taskSelected.png",
    menuStart = "start.png",
    menuStartSelected = "startSelected.png",
    taskbar = "taskbar.png",
    terminal = "terminal.png",
    hitZone = "hitZone.png",
    hitZoneForeground = "hitZoneForeground.png",
    beatInnerX = "beatInnerX.png",
    beatOuterX = "beatOuterX.png",
    beatInnerY = "beatInnerY.png",
    beatOuterY = "beatOuterY.png",
}

------------------------ 'game' variables

game.fieldOffset = {x = 50, y = 40}

game.beats = {}

game.mapDirectory = "assets/maps/"
game.currentSong = false
game.currentMap = {}

------------------------ 'menu' variables

menu.current = 1
menu.taskList = {
    start = { "exit" },
    play = { "jazzJackrabbit" },
    settings = { "song volume", "sfx volume" },
    credits = { "code", "graphics", "songs", "sfx" }
}
menu.taskOffsetX = {
    6, 77, 212, 348
}


---------------------------------------------------------------------
-------------------------CORE FUNCTIONS------------------------------

function core.checkInput(key)
    local input = core.keyMaps[key] and core.keyMaps[key] or "unmapped"

    if game_state == "InGame" then

        print(input)

        local particleColor = {1,0,0}
        if string.sub(input, #input, #input) == "R" then
            particleColor = {0,0,1}
        end

        if input == "leftL" or input == "leftR" then
            particle.create({
                img = g.img.beatInnerX,
                position = {core.bumpX + game.fieldOffset.x + 150, core.bumpY + game.fieldOffset.y + 150},
                velocity = {-.35,0},
                scale = {70/g.img.beatInnerX:getWidth(), 200/g.img.beatInnerX:getHeight()},
                lifetime = .25,
                color = particleColor,
                opacity = .5
            })
        elseif input == "rightL" or input == "rightR" then
            particle.create({
                img = g.img.beatInnerX,
                position = {core.bumpX + game.fieldOffset.x + 343, core.bumpY + game.fieldOffset.y + 150},
                velocity = {.25,0},
                scale = {70/g.img.beatInnerX:getWidth(), 200/g.img.beatInnerX:getHeight()},
                lifetime = .35,
                color = particleColor,
                opacity = .5
            })
        elseif input == "upL" or input == "upR" then
            particle.create({
                img = g.img.beatInnerY,
                position = {core.bumpX + game.fieldOffset.x + 150, core.bumpY + game.fieldOffset.y + 150},
                velocity = {0,-.25},
                scale = {200/g.img.beatInnerY:getWidth(), 70/g.img.beatInnerY:getHeight()},
                lifetime = .35,
                color = particleColor,
                opacity = .5
            })
        elseif input == "downL" or input == "downR" then
            particle.create({
                img = g.img.beatInnerY,
                position = {core.bumpX + game.fieldOffset.x + 150, core.bumpY + game.fieldOffset.y + 343},
                velocity = {0,.25},
                scale = {200/g.img.beatInnerY:getWidth(), 70/g.img.beatInnerY:getHeight()},
                lifetime = .35,
                color = particleColor,
                opacity = .5
            })
        end
    elseif game_state == "Menu" then
        print(input)

        if input == "leftL" or input == "leftR" then
            menu.current = menu.current - 1;
        end
        if input == "rightL" or input == "rightR" then
            menu.current = menu.current + 1;
        end

        menu.current = core.clamp(menu.current, 1, 4)

    end

end

function core.clamp(number, numberMin, numberMax)
    if number < numberMin then
        number = numberMin
    elseif number > numberMax then
        number = numberMax
    end
    return number
end

 -- NOTE: for drawing within the bounds of the game window, use game.draw()
function core.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky ) -- in place of love.graphics.draw()

    if type(drawable) == "string" then -- use lg.print to draw if string
        lg.print( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
    else                               -- other drawable types use lg.draw
        -- converting the scale functionality to exact pixel measurements
        if sx then
            sx = (1 / drawable:getWidth()) * sx
        end

        if sy then
            sy = (1 / drawable:getHeight()) * sy
        end

        if ox then
            if ox == "left" then
                ox = 0
            elseif ox == "center" then
                ox = drawable:getWidth()/2
            elseif ox == "right" then
                ox = drawable:getWidth()
            end
        end

        if oy then
            if oy == "top" then
                oy = 0
            elseif oy == "center" then
                oy = drawable:getHeight()/2
            elseif oy == "bottom" then
                oy = drawable:getHeight()
            end
        end

        lg.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
    end

end


-- returns the aspect ratio of either a drawable or X and Y size
function core.aspectRatio(firstVal, secondVal)
    if secondVal then
        return (firstVal/secondVal)
    else
        return firstVal:getWidth()/firstVal:getHeight()
    end
end

function core.update(dt)

end


---------------------------------------------------------------------
-----------------------GLOBAL FUNCTIONS------------------------------

function g.render() -- the initial rendering function. handles rendering the desktop (and responsible for zoom)

    -- determine the window size
    core.sWidth, core.sHeight = lg.getDimensions()

    -- determine the "bump" values
    core.bumpX = (core.sWidth-800)/2
    core.bumpY = (core.sHeight-600)/2





    -------------------------------------screen zoom-----------------------------------
        local ratio
        if core.sWidth > core.sHeight then
            ratio = (core.sHeight/600)
        else
            ratio = (core.sWidth/800)
        end
        local wr = (ratio)-1
        local translateX = -(core.sWidth/(1/wr)/2)
        local translateY = -(core.sHeight/(1/wr)/2)

        lg.translate(translateX, translateY)
        lg.scale(ratio,ratio)
   ------------------------------------------------------------------------------------

    -- render desktop background
    lg.push()
    lg.setColor(1,1,1)
    core.draw(g.img.desktop,
            core.sWidth/2, core.sHeight/2,
            0,
            core.sHeight*core.aspectRatio(g.img.desktop), core.sHeight,
            "center", "center")


    -- render the taskbar
    core.draw(g.img.taskbar,
            0, core.bumpY + 600,
            0,
            core.sWidth,
            36,
            "left", "bottom"
    )

    ------------------------------------------------------------------------------------

    -- render the start bar on taskbar
    core.draw(g.img.menuStart,
            core.bumpX + 6, 582,
            0,
            65,
            20,
            "left", "center"
    )

    -- render tasks
    for i = 1, 3 do
        game.draw(g.img.menuTask,
                menu.taskOffsetX[i + 1], 582,
                0,
                130,
                20,
                "left", "center"
        )
    end


    lg.pop()
end



function g.loadSkin(skinName) -- loads a skin into memory
    for name, imagePath in pairs(g.imagePointers) do
        g.img[name] = lg.newImage("assets/skins/" .. skinName .. "/" .. imagePath)
    end
end




---------------------------------------------------------------------
-----------------------GAME FUNCTIONS--------------------------------

-- NOTE: for drawing outside the bounds of the game window, use core.draw()
function game.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky ) -- in place of love.graphics.draw()
    x = x and x or 0 -- set x to 0 if it doesn't exist
    y = y and y or 0 -- set y to 0 if it doesn't exist
    core.draw( drawable, x + core.bumpX, y + core.bumpY, r, sx, sy, ox, oy, kx, ky )
end


-- creates a beat and adds it to the beat table
function game.createBeat(startTime, endTime, direction, color, position, iterations)
    table.insert(game.beats, {
        currentTime = startTime,
        startTime = startTime,
        endTime = endTime,
        direction = direction,
        color = color,
        position = position,
        iterations = iterations
    })
end

-- function called to process and increase beat step
function game.processBeats(dt)
    for index, beat in pairs(game.beats) do
        beat.currentTime = beat.currentTime + dt
        if beat.currentTime >= beat.endTime then
            game.beats[index] = nil
        end
    end
end

-- function called to render all current beats to the screen
function game.renderBeats()

    for _, beat in pairs(game.beats) do

        if beat.position == "outer" or not beat.position then

            lg.push()
            if beat.color == "red" then
                lg.setColor(1,0,0)
            else
                lg.setColor(0,0,1)
            end

            local ratio = (beat.currentTime - beat.startTime) / (beat.endTime - beat.startTime)
            local inverseRatio = 1 - ratio

            local xPos, yPos, ySize, xSize, rot = 0

            --- CASE: IT IS LEFT
            if beat.direction == "left" then
                xPos = game.fieldOffset.x + (150 * ratio)
                yPos = game.fieldOffset.y + 250
                ySize = (300 * inverseRatio) + 200
                xSize = ySize * core.aspectRatio(g.img.beatOuterX)
            elseif beat.direction == "right" then
                xPos = game.fieldOffset.x + 500 - (150 * ratio)
                yPos = game.fieldOffset.y + 250
                ySize = -((300 * inverseRatio) + 200)
                xSize = ySize * core.aspectRatio(g.img.beatOuterX)
            elseif beat.direction == "up" then
                yPos = game.fieldOffset.y + (150 * ratio)
                xPos = game.fieldOffset.x + 250
                xSize = (300 * inverseRatio) + 200
                ySize = xSize * core.aspectRatio(g.img.beatOuterY)
            elseif beat.direction == "down" then
                yPos = game.fieldOffset.y + 500 - (150 * ratio)
                xPos = game.fieldOffset.x + 250
                xSize = -((300 * inverseRatio) + 200)
                ySize = xSize * core.aspectRatio(g.img.beatOuterY)
            end




            if beat.direction == "left" or beat.direction == "right" then
                game.draw(g.img.beatOuterX,
                        xPos, yPos,
                        rot,
                        xSize, ySize,
                        "left",
                        "center"
                )
            else
                game.draw(g.img.beatOuterY,
                        xPos, yPos,
                        rot,
                        xSize, ySize,
                        "center",
                        "top"
                )
            end
            lg.pop()
        end

    end

    lg.push()
    lg.setColor(1,1,1)
    lg.pop()
end

function game.loadMap(mapName)
    game.currentMap = {
        -- MAP DATA
    }

    game.currentSong = love.audio.newSource(game.mapDirectory .. "testMap/song.mp3", "stream")
end


function game.render() -- this renders the game items (ex. play field, score, etc)
    lg.push()
    game.draw(g.img.playAreaWindow,
            game.fieldOffset.x - 6, game.fieldOffset.y - 18,
            0,
            512, 524
    )




    -- draw the play area BG
    game.draw(g.img.playAreaBg,
            game.fieldOffset.x, game.fieldOffset.y,
            0,
            500, 500
    )
    lg.pop()


    -- render beats here

    game.renderBeats()


    -- draw the play area foreground
    game.draw(g.img.playAreaForeground,
            game.fieldOffset.x, game.fieldOffset.y,
            0,
            500, 500
    )



    -- draw the center hit box
    game.draw(g.img.hitZone,
            game.fieldOffset.x + 250, game.fieldOffset.y + 250,
            0,
            200, 200,
            "center", "center"
    )

    particle.draw()

    lg.push()
    lg.setColor(1,1,1)
    lg.pop()

    -- draw the hit zone foreground
    game.draw(g.img.hitZoneForeground,
            game.fieldOffset.x + 250, game.fieldOffset.y + 250,
            0,
            210, 210,
            "center", "center"
    )
    ---------------- render other windows
    -- draw the player status window
    game.draw(g.img.terminal,
            game.fieldOffset.x + 530, game.fieldOffset.y - 18,
            0,
            180, 320
    )



    -- draw the progress window
    game.draw(g.img.progressWindow,
            game.fieldOffset.x + 530, game.fieldOffset.y + 325,
            0,
            180, 100
    )
end

function game.update(dt)
    game.processBeats(dt)
end

---------------------------------------------------------------------
----------------------MENU FUNCTIONS---------------------------------

function menu.render()

    if menu.current == 1 then
        game.draw(g.img.menuStartSelected,
                menu.taskOffsetX[1], 582,
                0,
                65,
                20,
                "left", "center"
        )
        -- render contexts
        local currOffset = 0
        for _, selectedContext in pairs(menu.taskList.start) do
            game.draw(g.img.menuStart,
                    menu.taskOffsetX[1], 564 - currOffset,
                    0,
                    65,
                    20,
                    "left", "bottom"
            )
            currOffset = currOffset + 20
        end
    elseif menu.current == 2 then
        game.draw(g.img.menuTaskSelected,
                menu.taskOffsetX[2], 582,
                0,
                130,
                20,
                "left", "center"
        )
        -- render contexts
        local currOffset = 0
        for _, selectedContext in pairs(menu.taskList.play) do
            game.draw(g.img.menuTask,
                    menu.taskOffsetX[2], 564 - currOffset,
                    0,
                    130,
                    20,
                    "left", "bottom"
            )
            currOffset = currOffset + 20
        end
    elseif menu.current == 3 then
        game.draw(g.img.menuTaskSelected,
                menu.taskOffsetX[3], 582,
                0,
                130,
                20,
                "left", "center"
        )
        -- render contexts
        local currOffset = 0
        for _, selectedContext in pairs(menu.taskList.settings) do
            game.draw(g.img.menuTask,
                    menu.taskOffsetX[3], 564 - currOffset,
                    0,
                    130,
                    20,
                    "left", "bottom"
            )
            currOffset = currOffset + 20
        end
    elseif menu.current == 4 then
        game.draw(g.img.menuTaskSelected,
                menu.taskOffsetX[4], 582,
                0,
                130,
                20,
                "left", "center"
        )
        -- render contexts
        local currOffset = 0
        for _, selectedContext in pairs(menu.taskList.credits) do
            game.draw(g.img.menuTask,
                    menu.taskOffsetX[4], 564 - currOffset,
                    0,
                    130,
                    20,
                    "left", "bottom"
            )
            currOffset = currOffset + 20
        end
    end

end

function menu.update(dt)

end