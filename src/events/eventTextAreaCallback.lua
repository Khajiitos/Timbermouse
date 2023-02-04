function eventTextAreaCallback(textAreaID, playerName, callback)
    if callback == 'helpQuestionMark' then
        openHelpPopup(playerName)
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
    end
end