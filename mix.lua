-- mix.lua
function mix()
    for i = 0, size - 1 do
        for j = 0, size - 1 do
            board[i][j] = string.char(65 + math.random(0, 5))
        end
    end
end
