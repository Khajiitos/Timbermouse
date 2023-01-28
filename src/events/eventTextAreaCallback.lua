function eventTextAreaCallback(textAreaID, playerName, callback)
    if callback == 'helpQuestionMark' then
        openHelpPopup(playerName)
    elseif callback == 'startGame' then
        startTimbermouseGame(playerName)
    elseif callback == 'gameOverClose' then
        ui.removeTextArea(enum.textArea.GAME_OVER, playerName)
        ui.removeTextArea(enum.textArea.GAME_OVER_CLOSE, playerName)
    end
end