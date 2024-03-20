#include <iostream>
#include <lua.hpp>

int main() {
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);

    // Загрузка каждого файла Lua
    luaL_dofile(L, "init.lua");
    luaL_dofile(L, "move.lua");
    luaL_dofile(L, "tick.lua");
    luaL_dofile(L, "mix.lua");
    luaL_dofile(L, "printBoard.lua");

    // Инициализация поля
    lua_getglobal(L, "init");
    lua_call(L, 0, 0);

    // Вывод начального состояния поля
    std::cout << "Initial board state:\n";
    lua_getglobal(L, "printBoard");
    lua_call(L, 0, 0);

    // Получение и обработка ввода пользователя
    std::cout << "Enter your move (m x y d), or 'q' to quit: ";
    char command[5];
    while (std::cin >> command) {
        if (command[0] == 'q') {
            break;
        }

        lua_getglobal(L, "move");
        lua_pushinteger(L, command[1] - '0'); // Приведение к Lua-стилю индексации (начинается с 0)
        lua_pushinteger(L, command[2] - '0'); // Приведение к Lua-стилю индексации (начинается с 0)
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
