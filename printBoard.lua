-- printBoard.lua
function printBoard()
    io.write("  ")
    for j = 0, size - 1 do
        io.write(j .. " ")
    end
    io.write("\n")
    
    for i = 0, size - 1 do
        io.write(i .. " ")
        for j = 0, size - 1 do
            io.write(board[i][j] .. " ")
        end
        io.write("\n")
    end
end
