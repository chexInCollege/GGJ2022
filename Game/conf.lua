function love.conf(t)
    t.title = "GGJ2022"                  -- The title of the window the game is in (string)
    t.version = "11.4"                    -- The LÖVE version this game was made for (string)
    t.console = true                     -- Attach a console (boolean, Windows only)
    t.window.width = 800                 -- The window width (number)
    t.window.height = 600                 -- The window height (number)
    t.window.minwidth = 800                 -- The window width (number)
    t.window.minheight = 600                 -- The window height (number)
    t.window.resizable = true

    t.modules.physics = false
    t.window.icon = "assets/core/icon.png"    -- Filepath to an image to use as the window's icon (string)
    t.modules.timer = true              -- Enable the timer module (boolean), Disabling it will result 0 delta time in love.update

end
