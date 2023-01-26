function eventTextAreaCallback(textAreaID, playerName, callback)
    if callback == 'helpQuestionMark' then
        openHelpPopup(playerName)
    elseif callback == 'startGame' then
        startTimbermouseGame(playerName)
    end
end