function initPlayer(playerName)
    playerData[playerName] = PlayerData:new(playerName)

    addStartGameButton(playerName)
    
    system.bindKeyboard(playerName, 0, true, true) -- left
    system.bindKeyboard(playerName, 2, true, true) -- right

    ui.addTextArea(enum.textArea.HELP, "<a href='event:helpQuestionMark'><p align='center'><font size='16'><b>?</b></font></p></a>", playerName, 760, 35, 25, 25, 0x111111, 0x111111, 1.0, true)
end

tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disablePhysicalConsumables(true)

tfm.exec.newGame(7925577)
tfm.exec.setGameTime(0, true)
ui.setMapName("Timbermouse");

for playerName in pairs(tfm.get.room.playerList) do
    initPlayer(playerName)
end