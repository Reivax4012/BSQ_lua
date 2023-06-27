local filename = arg[1]
if not filename then
    print("Please provide a filename as a command-line argument.")
    return
end

local file = io.open(filename, "r")
if not file then
    print("Failed to open the file.")
    return
end

local numLines = tonumber(file:read("*line"))
local array = {}

for _ = 1, numLines do
    local line = file:read("*line")
    local lineArray = {}

    for char in line:gmatch(".") do
        local value = char == '.' and 0 or 1
        table.insert(lineArray, value)
    end

    table.insert(array, lineArray)
end

file:close()

local line = array[1]
for _, value in ipairs(line) do
    io.write(value .. " ")
end
io.write("\n")