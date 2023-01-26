function eventLoop(currentTime, timeRemaining)
    for playerName, playerData in pairs(tfm.get.room.playerList) do
        if game(playerName) and game(playerName).started then
            game(playerName).timeLeft = game(playerName).timeLeft - 0.5
            if game(playerName).timeLeft <= 0.0 then
                game(playerName):endGame()
            else
                game(playerName):updateTimeBar()
            end
        end
    end
end