function eventTextAreaCallback(textAreaID, playerName, callback)
    if callback == 'helpQuestionMark' then
        if playerData[playerName].openHelpTab == enum.helpTab.CLOSED then
            changeHelpTab(playerName, enum.helpTab.DESCRIPTION)
        else
            changeHelpTab(playerName, enum.helpTab.CLOSED)
        end
    elseif callback == 'startGame' then
        if game(playerName) then
            game(playerName):endGame()
        end
        startTimbermouseGame(playerName)
    elseif callback == 'gameOverClose' then
        if game(playerName) then
            game(playerName):endGame()
        end
        ui.removeTextArea(enum.textArea.GAME_OVER, playerName)
        ui.removeTextArea(enum.textArea.GAME_OVER_CLOSE, playerName)
    elseif callback == "helpClose" then
        changeHelpTab(playerName, enum.helpTab.CLOSED)
    elseif callback == "helpTabDescription" then 
        changeHelpTab(playerName, enum.helpTab.DESCRIPTION)
    elseif callback == "helpTabKeys" then 
        changeHelpTab(playerName, enum.helpTab.KEYS)
    elseif callback == "closeGameOver" then
        ui.removeTextArea(enum.textArea.GAME_OVER, playerName)
        ui.removeTextArea(enum.textArea.GAME_OVER_CLOSE, playerName)
    end
end