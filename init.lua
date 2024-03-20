-- init.lua
function init()
    -- Загрузка необходимых функций
    require("checkMatches") -- Загрузка файла checkMatches.lua

    -- Инициализация поля
    size = 10
    board = {}

    -- Заполнение поля, избегая совпадающих символов
    for i = 0, size - 1 do
        board[i] = {}
        for j = 0, size - 1 do
            local new_char
            repeat
                new_char = string.char(math.random(65, 70)) -- Случайный символ от A до F
            until not checkMatchesAtPosition(i, j, new_char)
            board[i][j] = new_char
        end
    end
end
