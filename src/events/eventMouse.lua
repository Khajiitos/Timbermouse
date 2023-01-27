function eventMouse(playerName, xMousePosition, yMousePosition)
    if game(playerName) then
        game(playerName):onMouseClick(xMousePosition, yMousePosition)
    end
end