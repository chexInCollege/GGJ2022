data = {}

data.initialData = {
    -- put any preliminary data here
    example = "test",
    example2 = 5

}

if not love.filesystem.getInfo("save_data.lua") then
    love.filesystem.write("save_data.lua", TSerial.pack(initialData))
    data.contents = initialData
else
    data.contents = TSerial.unpack(love.filesystem.read("save_data.lua"))

    -- fill in any missing data from initialData
    for index, value in pairs(data.initialData) do
        if not data.contents[index] then
            data.contents[index] = value
        end
    end

    -- fix any data structure inconsistencies between the standard initialData and the old data
    for index, value in pairs(data.contents) do
        if data.initialData[index] and type(data.initialData[index] ~= type(value)) then
            data.contents[index] = data.initialData[index]
        end
    end
end

function data.save(dataToSave)
    dataToSave = dataToSave and dataToSave or data.contents
    oldData = TSerial.unpack(love.filesystem.read("save_data.lua"))
    success, reason = love.filesystem.write(TSerial.pack(dataToSave, {}, true))

    if not success then
        love.filesystem.write(TSerial.pack(oldData, {}, true))
    end
end