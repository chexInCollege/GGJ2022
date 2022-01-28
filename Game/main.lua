i = 1

function love.draw()
    love.graphics.print("i've been waiting for " .. i .. " seconds")
end

function love.update(dt)
    i = i + dt
end