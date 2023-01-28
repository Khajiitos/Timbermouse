function eventNewPlayer(playerName)
    tfm.exec.changePlayerSize(playerName, MOUSE_SIZE)
	initPlayer(playerName)
    tfm.exec.respawnPlayer(playerName)
    for player, _ in pairs(tfm.get.room.playerList) do
        if playerData[player].hidden then
            hideMouseFor(player, playerName)
        end
    end
end