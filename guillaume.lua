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

local rows = #array
local cols = #array[1]

local temp = {}
for i = 1, rows do
    temp[i] = {}
    for j = 1, cols do
        temp[i][j] = 0
    end
end

local maxSquareSize = 0
local maxSquareRow = 0
local maxSquareCol = 0

for i = 1, rows do
    for j = 1, cols do
        if i == 1 or j == 1 then
            temp[i][j] = array[i][j]
        elseif array[i][j] == 1 then
            temp[i][j] = math.min(temp[i-1][j], temp[i][j-1], temp[i-1][j-1]) + 1
        end

        if temp[i][j] > maxSquareSize then
            maxSquareSize = temp[i][j]
            maxSquareRow = i - maxSquareSize + 1
            maxSquareCol = j - maxSquareSize + 1
        end
    end
end

if maxSquareSize > 0 then
    print("Coordinates of the largest square:")
    print("Top-left corner: (" .. maxSquareRow + 1 .. ", " .. maxSquareCol .. ")")
    print("Bottom-right corner: (" .. (maxSquareRow + maxSquareSize) .. ", " .. (maxSquareCol + maxSquareSize - 1) .. ")")
end

