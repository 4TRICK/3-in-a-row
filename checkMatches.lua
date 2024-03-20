-- checkMatches.lua
function checkMatchesAtPosition(i, j, new_char)
    -- Проверка по горизонтали
    if j >= 2 and new_char == board[i][j - 1] and new_char == board[i][j - 2] then
        return true
    end
    -- Проверка по вертикали
    if i >= 2 and new_char == board[i - 1][j] and new_char == board[i - 2][j] then
        return true
    end
    return false
end
