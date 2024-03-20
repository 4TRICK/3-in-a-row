-- move.lua
function move(i, j, command)
    local movements = {
        l = {i = 0, j = -1},
        r = {i = 0, j = 1},
        u = {i = -1, j = 0},
        d = {i = 1, j = 0}
    }
     
    local movement = movements[command]
    if movement then
        local ni, nj = i + movement.i, j + movement.j
        -- Проверяем, что новые координаты в пределах поля
        if ni < 0 or ni >= size or nj < 0 or nj >= size then
            return false, "Stone goes out of bounds"
        else
            -- Обмен значениями
            local temp = board[i][j]
            board[i][j] = board[ni][nj]
            board[ni][nj] = temp

            -- Если в новой ячейке символ "-", заменяем его случайным символом
            if board[i][j] == '-' then
                repeat
                    board[i][j] = string.char(math.random(65, 70)) -- Случайный символ от A до F
                until not checkMatchesAtPosition(i, j, board[i][j]) -- Проверяем, что новый символ не создает совпадений
            end

            -- Проверка на совпадения и удаление камней
            local function checkAndClearMatches()
                local function clearMatches()
                    for i = 0, size - 1 do
                        for j = 0, size - 1 do
                            if board[i][j] ~= '-' then
                                local current = board[i][j]
                                local horizMatches = 1
                                local vertMatches = 1

                                -- Проверка горизонтальных совпадений
                                for k = j + 1, size - 1 do
                                    if board[i][k] == current then
                                        horizMatches = horizMatches + 1
                                    else
                                        break
                                    end
                                end

                                -- Проверка вертикальных совпадений
                                for k = i + 1, size - 1 do
                                    if board[k][j] == current then
                                        vertMatches = vertMatches + 1
                                    else
                                        break
                                    end
                                end

                                -- Удаление совпавших кристаллов
                                if horizMatches >= 3 or vertMatches >= 3 then
                                    if vertMatches >= 3 then
                                        -- Удаляем кристаллы в вертикальной линии
                                        for k = 0, vertMatches - 1 do
                                            board[i + k][j] = '-'
                                        end
                                    end
                                    if horizMatches >= 3 then
                                        -- Удаляем кристаллы в горизонтальной линии
                                        for k = 0, horizMatches - 1 do
                                            board[i][j + k] = '-'
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                -- Проверяем совпадения
                clearMatches()

                -- Смещаем кристаллы после удаления совпадений
                tick()
            end

            checkAndClearMatches() -- Проверка совпадений и очистка
            return true
        end
    else
        return false, "Invalid movement command"
    end
end
