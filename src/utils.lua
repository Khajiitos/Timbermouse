scheduledFunctionCalls = {}

function doLater(callback, ticksLater)
    scheduledFunctionCalls[#scheduledFunctionCalls + 1] = {
        func = callback,
        tick = eventLoopTicks + ticksLater
    }
end

function addStartGameButton(playerName)
    ui.addTextArea(enum.textArea.START_GAME, '<a href="event:startGame"><p align="center"><b>Start game</b></p></a>', playerName, 350, 370, 100, 20, nil, nil, 0.9, true)
end

function removeStartGameButton(playerName)
    ui.removeTextArea(enum.textArea.START_GAME, playerName)
end

function addWoodCoinsCounter(playerName)
    ui.addTextArea(enum.textArea.WOOD_COINS, '<textformat indent="40"><p align="center">...</p></textformat>', playerName, 15, 35, 90, 25, 0x101010, 0x000000, 0.9, true)
    tfm.exec.addImage(images.wood_coin.name, '&69', 20, 37, playerName, 0.33, 0.33, 0.0, 1.0, 0.0, 0.0)
end

function updateWoodCoinsCounter(playerName)
    ui.updateTextArea(enum.textArea.WOOD_COINS, string.format('<textformat indent="40"><p align="center"><font color="#FFFFFF" size="16">%d</font></p></textformat>', playerData[playerName].woodCoins), playerName)
end

helpContent = {
    description =
[[
<p align='center'><font size='20' color='#BABD2F'><b>Timbermouse</b></font></p>
<font size="8"><b><D>Welcome to the module!</D></b>
        
This is a recreation of <b><O>Timberman</O></b>.
        
Click the <b>Start game</b> button to start a game.
        
A <CEP>tree</CEP> will appear in the middle of the map, and your goal is to cut it down.
To cut a block of <CS>wood</CS>, click <b><V>A/Left Arrow</V></b> to cut it from the left, and <b><V>D/Right Arrow</V></b> to cut it from the right.
        
If the bottommost <CS>wood</CS> block has a branch on its <D>side</D>, you have to cut it from the opposite <D>side</D>, otherwise the game will <R>end</R>.
        
There is a timer until the game <R>ends</R>, and you earn a bit of time by cutting <CS>wood</CS>.
        
The goal is to earn the highest score you can before the time runs out or you cut the <CS>wood</CS> from the <FC>wrong</FC> <D>side</D>.
        
<font color='#2ECF73' size='13'><b>Good luck!</b></font></font>]]
}

function changeHelpTab(playerName, tab)
    if playerData[playerName].openHelpTab == enum.helpTab.CLOSED and tab ~= enum.helpTab.CLOSED then
        createHelpPage(playerName)
    end

    if tab == enum.helpTab.CLOSED then
        removeHelpPage(playerName)
    elseif tab == enum.helpTab.DESCRIPTION then
        ui.updateTextArea(enum.textArea.HELP_CONTENT, helpContent.description, playerName)
    end
    playerData[playerName].openHelpTab = tab
end

function createHelpPage(playerName)
    ui.addTextArea(enum.textArea.HELP_CONTENT, '', playerName, 200, 50, 400, 250, 0x0F0F0F, 0x000000, 1.0, true)
    ui.addTextArea(enum.textArea.HELP_CLOSE, '<p align="center"><a href="event:helpClose"><font size="16" color="#FFFFFF">Close</font></a></p>', playerName, 300, 315, 200, 25, 0x0F0F0F, 0x000000, 1.0, true)
    ui.addTextArea(enum.textArea.HELP_TAB_DESCRIPTION, '<p align="center"><a href="event:helpTabDescription"><font size="14" color="#FFFFFF">Description</font></a></p>', playerName, 80, 50, 100, 25, 0x0F0F0F, 0x000000, 1.0, true)
end

function removeHelpPage(playerName)
    ui.removeTextArea(enum.textArea.HELP_CONTENT, playerName)
    ui.removeTextArea(enum.textArea.HELP_CLOSE, playerName)
    ui.removeTextArea(enum.textArea.HELP_TAB_DESCRIPTION, playerName)
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
    local id = tfm.exec.addImage(images.tombstone.name, '%'..playerName, 0, 0, hideFor, 0, 0, 0, 0, 0, 0)
    local images = playerData[playerName].imagesFromHide
    images[#images + 1] = id
end

function unhidePlayer(playerName)
    for i, imageID in ipairs(playerData[playerName].imagesFromHide) do
        tfm.exec.removeImage(imageID)
    end
    playerData[playerName].imagesFromHide = {}
end