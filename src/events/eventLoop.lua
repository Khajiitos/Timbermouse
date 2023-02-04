eventLoopTicks = 0

function eventLoop(currentTime, timeRemaining)

    for i, scheduledFunctionCall in ipairs(scheduledFunctionCalls) do
        if eventLoopTicks >= scheduledFunctionCall.tick then
            scheduledFunctionCall.func()
            table.remove(scheduledFunctionCalls, i)
        end
    end

    eventLoopTicks = eventLoopTicks + 1

    for playerName, playerData in pairs(tfm.get.room.playerList) do
        if game(playerName) and game(playerName).started and not game(playerName).over then
            game(playerName).timeLeft = game(playerName).timeLeft - 0.5
            if game(playerName).timeLeft <= 0.0 then
                game(playerName):playerDeath()
            else
                game(playerName):updateTimeBar()
            end
        end
    end
end