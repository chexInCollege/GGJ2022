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


------------------------ 'g' variables


------------------------ 'game' variables


------------------------ 'menu' variables



---------------------------------------------------------------------
-------------------------CORE FUNCTIONS------------------------------

 -- NOTE: for drawing within the bounds of the game window, use game.draw()
function core.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky ) -- in place of love.graphics.draw()
    if type(drawable) == "string" then -- use lg.print to draw if string
        lg.print( drawable, x, y + core.bumpY, r, sx, sy, ox, oy, kx, ky )
    else                               -- other drawable types use lg.draw
        lg.draw( drawable, x, y + core.bumpY, r, sx, sy, ox, oy, kx, ky )
    end
end

function core.update(dt)

end

function core.render()

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
end


---------------------------------------------------------------------
-----------------------GAME FUNCTIONS--------------------------------

-- NOTE: for drawing outside the bounds of the game window, use core.draw()

function game.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky ) -- in place of love.graphics.draw()
    if type(drawable) == "string" then -- use lg.print to draw if string
        lg.print( drawable, x + core.bumpX, y + core.bumpY, r, sx, sy, ox, oy, kx, ky )
    else                               -- other drawable types use lg.draw
        lg.draw( drawable, x + core.bumpY, y + core.bumpY, r, sx, sy, ox, oy, kx, ky )
    end
end

function game.render() -- this renders the game items (ex. play field, score, etc)

end

function game.update(dt)

end

---------------------------------------------------------------------
----------------------MENU FUNCTIONS---------------------------------

function menu.render() -- this renders the game items (ex. play field, score, etc)

end

function menu.update(dt)

end