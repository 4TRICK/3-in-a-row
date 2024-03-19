#include <iostream>
#include <lua.hpp>

int main() {
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);

    // Загрузка файла с логикой игры
    luaL_dofile(L, "game_logic.lua");

    // Инициализация поля
    lua_getglobal(L, "init");
    lua_call(L, 0, 0);

    // Вывод начального состояния поля
    std::cout << "Initial board state:\n";
    lua_getglobal(L, "printBoard");
    lua_call(L, 0, 0);

    // Получение и обработка ввода пользователя
    std::cout << "Enter your move (m x y d), or 'q' to quit: ";
    char command[4];
    while (std::cin >> command) {
        if (command[0] == 'q') {
            break;
        }

        lua_getglobal(L, "move");
        lua_pushinteger(L, command[1] - '0' + 1); // +1 для приведения к Lua-стилю индексации (начинается с 1)
        lua_pushinteger(L, command[2] - '0' + 1); // +1 для приведения к Lua-стилю индексации (начинается с 1)
        lua_pushstring(L, &command[3]);
        lua_call(L, 3, 0);

        // Вывод состояния поля после хода
        std::cout << "Current board state:\n";
        lua_getglobal(L, "printBoard");
        lua_call(L, 0, 0);

        std::cout << "Enter your move (m x y d), or 'q' to quit: ";
    }

    lua_close(L);
    return 0;
}
