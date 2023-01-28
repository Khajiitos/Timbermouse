function eventNewPlayer(playerName)
    tfm.exec.respawnPlayer(playerName)
	initPlayer(playerName)
    for player, _ in pairs(tfm.get.room.playerList) do
        if playerData[player].hidden then
            hideMouseFor(player, playerName)
        end
    end
end