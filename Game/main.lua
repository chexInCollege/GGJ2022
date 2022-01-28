i = 1

function love.update(dt)
    i = i + dt
    love.graphics.print("i've been waiting for " .. i .. " seconds")
end