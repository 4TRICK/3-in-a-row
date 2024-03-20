-- tick.lua
function tick()
    local moved = true
    while moved do
        moved = false
        for i = size - 2, 0, -1 do
            for j = 0, size - 1 do
                if board[i][j] ~= '-' and board[i + 1][j] == '-' then
                    board[i][j], board[i + 1][j] = board[i + 1][j], board[i][j]
                    moved = true
                end
            end
        end
    end

    -- После сдвига символов, заменяем пустые ячейки случайными символами от A до F
    for i = 0, size - 1 do
        for j = 0, size - 1 do
            if board[i][j] == '-' then
                repeat
                    board[i][j] = string.char(math.random(65, 70)) -- Случайный символ от A до F
                until not checkMatchesAtPosition(i, j, board[i][j]) -- Проверяем, что новый символ не создает совпадений
            end
        end
    end
end

-- Возвращаем модуль
return tick
