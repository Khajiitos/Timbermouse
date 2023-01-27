scheduledFunctionCalls = {}

function doLater(callback, ticksLater, forgetAfterNewRound)
    scheduledFunctionCalls[#scheduledFunctionCalls + 1] = {
        func = callback,
        tick = eventLoopTicks + ticksLater,
        forgetAfterNewRound = forgetAfterNewRound
    }
end

function addStartGameButton(playerName)
    ui.addTextArea(enum.textArea.START_GAME, '<a href="event:startGame"><p align="center"><b>Start game</b></p></a>', playerName, 350, 370, 100, 20, nil, nil, 0.9, true)
end

function removeStartGameButton(playerName)
    ui.removeTextArea(enum.textArea.START_GAME, playerName)
end

function openHelpPopup(playerName)
    local text = [[
<p align='center'><font size='20' color='#BABD2F'><b>Timbermouse</b></font></p>
<b>Welcome to the module!</b>

This is a recreation of Timberman.

Click the <b>Start game</b> button to start a game.

A tree will appear in the middle of the map, and your goal is to cut it down.
To cut a block of wood, click <b>A/Left Arrow</b> to cut it from the left, and <b>D/Right Arrow</b> to cut it from the right.

If the bottommost wood block has a branch on its side, you have to cut it from the opposite site, otherwise the game will end.

There is a timer until the game ends, and you earn a bit of time by cutting wood.

The goal is to earn the highest score you can before the time runs out or you cut the wood from the wrong side.

<font color='#2ECF73' size='13'><b>Good luck!</b></font>
<p align='right'><font color='#606090' size='10'><b><i>Made by Khajiitos#0000</i><b></font></p>]]
    ui.addPopup(1, 0, text, playerName, 150, 30, 500, true)
end

function game(playerName)
    if playerData[playerName] then
        return playerData[playerName].game
    end
    return nil
end

function hideMouseForOthers(playerName)
    for player, _ in pairs(tfm.get.room.playerList) do
        if player ~= playerName then
            hideMouseFor(playerName, player)
        end
    end
    playerData[playerName].hidden = true
end

function hideMouseFor(playerName, hideFor)
    local id = tfm.exec.addImage(IMAGE_WOOD, '%'..playerName, 0, 0, hideFor, 0, 0, 0, 0, 0, 0)
    local images = playerData[playerName].imagesFromHide
    images[#images + 1] = id
end

function unhidePlayer(playerName)
    for i, imageID in ipairs(playerData[playerName].imagesFromHide) do
        tfm.exec.removeImage(imageID)
    end
    playerData[playerName].imagesFromHide = {}
    tfm.exec.killPlayer(playerName)
    tfm.exec.respawnPlayer(playerName)
end