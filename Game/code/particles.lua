--- LOVE2D Basic Particle Library
--- Created by chex#5880.
--- DateTime: 1/29/2022 2:37 PM
---

particleList = {}
particle = {}

function particle.update(dt)
    for index, object in pairs(particleList) do
        if object.velocity and object.position and object.position[1] and object.position[2] then
            object.position[1] = object.position[1] + (object.velocity[1] * 60 * dt)
            object.position[2] = object.position[2] + (object.velocity[2] * 60 * dt)
        end

        object.scale = object.scale and object.scale or {1,1}


        if object.rotVelocity then
            object.rotation = object.rotation + (object.rotVelocity * 60 * dt)
        end

        if object.opacityDelta then
            object.opacity = object.opacity + (object.opacityDelta * 60 * dt)
        end

        if object.friction and object.velocity then
            object.velocity[1] = object.velocity[1] / (object.friction[1] * 60 * game.dt)
            object.velocity[2] = object.velocity[2] / (object.friction[2] * 60 * game.dt)
        end

        if object.acceleration then
            object.velocity[1] = object.velocity[1] + object.acceleration[1]
            object.velocity[2] = object.velocity[2] + object.acceleration[2]
        end

        if object.scaleDelta then
            object.scale[1] = object.scale[1] + (object.scaleDelta[1] * 60 * dt)
            object.scale[2] = object.scale[2] + (object.scaleDelta[2] * 60 * dt)
        end

        if object.scale[1] < 0 then object.scale[1] = 0 end
        if object.scale[2] < 0 then object.scale[2] = 0 end

        if object.lifetime then
            local oldLifetime = object.lifetime
            object.lifetime = object.lifetime - dt

            if object.lifetimeMapping then
                for _, item in pairs(object.lifetimeMapping) do
                    local time = item[1]

                    if oldLifetime >= time and object.lifetime < time then
                        for ind, val in pairs(item[2]) do
                            object[ind] = val
                        end
                    end
                end
            end

            if object.lifetime < 0 then
                particleList[index] = nil
            end
        end
    end
end

function particle.draw(layer)
    local cnt = 0
    for _, object in pairs(particleList) do
        cnt = cnt + 1
        local bx = 0
        local by = 0
        if object.bumpPosition then
            bx = game.bumpX
            by = game.bumpY
        end

        if not object.scaleOffset then
            object.scaleOffset = {0,0}
        end

        if not object.color then
            object.color = {1,1,1}
        end

        if not object.position then
            object.position = {0,0}
        end

        if not object.scale then
            object.scale = {1,1}
        end

        if not object.rotation then
            object.rotation = 0
        end

        if not object.opacity then
            object.opacity = 1
        end

        if (not object.layer and layer == 3) or object.layer == layer or not layer then
            love.graphics.push()
            love.graphics.setColor(object.color[1], object.color[2], object.color[3], object.opacity)
            if object.img then
                love.graphics.draw(object.img, object.position[1] + bx, object.position[2] + by, object.rotation, object.scale[1], object.scale[2], object.scaleOffset[1], object.scaleOffset[2])
            elseif object.text then
                love.graphics.print(object.text, object.position[1] + bx, object.position[2] + by, object.rotation, object.scale[1], object.scale[2], object.scaleOffset[1], object.scaleOffset[2])
            end
            love.graphics.pop()
        end
    end
end

--[[
particle.create({particle})
particle.create("name", {particle})
]]

function particle.create(particleData, particleData2) -- particleName is optional
    if particleName then
        particleList[particleData2] = particleData
    else
        table.insert(particleList, particleData)
    end
end

function particle.alter(particleName, particleData)
    for property, value in pairs(particleData) do
        particleList[particleName][property] = particleData
    end
end

function particle.delete(particleName)
    particleList[particleName] = nil
end
