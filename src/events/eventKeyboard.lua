function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)
    if game(playerName) then
        game(playerName):onKeyboard(keyCode)
    end
end