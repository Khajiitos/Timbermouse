TimbermouseGame = {
    playerName = nil,
    treeBlocks = {},
    staticTreeImages = {}, -- root, wood
    dynamicTreeImages = {}, -- branches
    tombstoneImage = nil,
    axeImage = nil,
    score = 0,
    timeLeft = 10.0,
    timeTotal = 10.0,
    started = false,
    over = false,
    treeType = 'default'
}

function TimbermouseGame:new(playerName)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.playerName = playerName
    o.treeType = treeTypes[math.random(#treeTypes)]
    o.treeBlocks = {}
    o.staticTreeImages = {}
    o.dynamicTreeImages = {}

    o.treeBlocks[1] = enum.treeBlocks.TREE
    o.treeBlocks[2] = enum.treeBlocks.TREE
    for i = 3, 8 do
        o.treeBlocks[i] = o:generateTreeBlock()
    end
    
    ui.addTextArea(enum.textArea.SCORE, '', o.playerName, 300, 70, 200, 50, nil, nil, 0, true)
    ui.addTextArea(enum.textArea.TIME_TOTAL, '', self.playerName, 300, 25, 200, 25, nil, nil, 1.0, true)
    ui.removeTextArea(enum.textArea.GAME_OVER, o.playerName)
    ui.removeTextArea(enum.textArea.GAME_OVER_CLOSE, o.playerName)
    
    o:initStaticTreeImages()
    o:updateTree()
    o:updateTimeBar()
    o:updateScoreCounter()

    tfm.exec.freezePlayer(o.playerName, true, false)
    tfm.exec.movePlayer(o.playerName, 350, 400 - GROUND_OFFSET - 15, false, 0, 0, false)
    o.axeImage = tfm.exec.addImage(axe(o.playerName).image_right.name, '$'..o.playerName, 20, 0, o.playerName, 0.425, 0.425, 0.0, 1.0, 0.5, 0.5)
    tfm.exec.stopMusic('musique', o.playerName)

    removeStartGameButton(o.playerName)
    hideMouseForOthers(o.playerName)
    return o
end

function TimbermouseGame:initStaticTreeImages()
    local images = trees[self.treeType].images
    self.staticTreeImages[#self.staticTreeImages + 1] = tfm.exec.addImage(images.root.name, '?69', 400, 400 - GROUND_OFFSET, self.playerName, 0.5, 0.5, 0, 1.0, 0.5, 1)
    for i, _ in ipairs(self.treeBlocks) do
        self.staticTreeImages[#self.staticTreeImages + 1] = tfm.exec.addImage(images.wood.name, '?69', 400, 400 - (i * 50) - GROUND_OFFSET - (images.root.height * 0.5), self.playerName, 0.5, 0.5, 0, 1.0, 0.5, 0)
    end
end

function TimbermouseGame:generateTreeBlock()
    local rand = math.random(3)

    if rand == 1 then
        return enum.treeBlocks.TREE
    else
        if self.treeBlocks[#self.treeBlocks] ~= enum.treeBlocks.TREE then
            return enum.treeBlocks.TREE
        end
        if rand == 2 then
            return enum.treeBlocks.TREE_LEFT
        else
            return enum.treeBlocks.TREE_RIGHT
        end
    end
end

function TimbermouseGame:updateScoreCounter()
    ui.updateTextArea(enum.textArea.SCORE, string.format('<p align="center"><font size="32" color="%s" face="serif"><b>%d</b></font></p>', trees[self.treeType].scoreTextColor, self.score), self.playerName)
end

function TimbermouseGame:playerDeath(left)
    if playerData[self.playerName]:onScore(self.score) then
        tfm.exec.playSound('transformice/son/victoire.mp3', nil, nil, nil, self.playerName)
    else
        tfm.exec.playSound('tfmadv/disparition.mp3', nil, nil, nil, self.playerName)
    end
    tfm.exec.stopMusic('musique', self.playerName)
    tfm.exec.killPlayer(self.playerName)

    addStartGameButton(self.playerName)
    self:showGameover()
    self.over = true

    if left ~= nil then
        if left then
            self.tombstoneImage = tfm.exec.addImage(images.tombstone.name, '?420', 350, 400 - GROUND_OFFSET - 2, self.playerName, 0.075, 0.075, 0, 1.0, 0.5, 0.95)
        else
            self.tombstoneImage = tfm.exec.addImage(images.tombstone.name, '?420', 450, 400 - GROUND_OFFSET - 2, self.playerName, 0.075, 0.075, 0, 1.0, 0.5, 0.95)
        end
    else
        self:removeTimeBar()
    end

    local coins = math.floor(self.score / 10)
    if coins ~= 0 then
        playerData[self.playerName].woodCoins = playerData[self.playerName].woodCoins + coins
        updateWoodCoinsCounter(self.playerName)
    end

    doLater(function()
        if playerData[self.playerName].game == self then
            if self.gameOverCoinsImage then
                tfm.exec.removeImage(self.gameOverCoinsImage)
            end
            ui.removeTextArea(enum.textArea.GAME_OVER, playerName)
            ui.removeTextArea(enum.textArea.GAME_OVER_CLOSE, playerName)
            self:endGame()
        end
    end, 10)
end

function TimbermouseGame:endGame()
    self.treeBlocks = {}
    for i, imageID in ipairs(self.dynamicTreeImages) do
        tfm.exec.removeImage(imageID)
    end
    for i, imageID in ipairs(self.staticTreeImages) do
        tfm.exec.removeImage(imageID)
    end
    self:removeTimeBar()
    unhidePlayer(self.playerName)

    if self.tombstoneImage then
        tfm.exec.removeImage(self.tombstoneImage)
    end

    tfm.exec.freezePlayer(self.playerName, false)
    tfm.exec.respawnPlayer(self.playerName)
    
    ui.removeTextArea(enum.textArea.SCORE, self.playerName)
    playerData[self.playerName].game = nil
end

function TimbermouseGame:showGameover()
    local coins = math.floor(self.score / 10)
    local text = '<p align="center"><font color="#fcf1d2" size="24" face="serif"><b>GAME OVER</b></font></p>'
    text = text .. string.format('<p align="center"><font size="20" color="#825727">SCORE</font><br><font size="24" color="#FFFFFF"><b>%d</b></font></p>', self.score)
    text = text .. string.format('<p align="center"><font size="18" color="#825727">BEST</font><br><font size="22" color="#FFFFFF"><b>%d</b></font></p>', playerData[self.playerName].bestScore)
    local height, startY = 150, 150
    if coins ~= 0 then
        text = text .. string.format('<br><textformat indent="120"><font size="22" color="#825727">+ %d</font></textformat>', coins)
        height, startY = 200, 125
        self.gameOverCoinsImage = tfm.exec.addImage(images.wood_coin.name, '&69', 350, 280, self.playerName, 0.33, 0.33, 0.0, 1.0, 0.0, 0.0)
    end
    ui.addTextArea(enum.textArea.GAME_OVER, text, self.playerName, 275, startY, 250, height, 0xf0bb69, 0x825727, 1.0, true)
    ui.addTextArea(enum.textArea.GAME_OVER_CLOSE, '<a href="event:gameOverClose"><font size="11" color="#FCF1D2"><p align="center"><b>X</b></p></font></a>', self.playerName, 500, 160, 15, 15, 0x825727, 0x724717, 1.0, true)
end

function TimbermouseGame:updateTree()
    for i, imageID in ipairs(self.dynamicTreeImages) do
        tfm.exec.removeImage(imageID)
    end
    self.dynamicTreeImages = {}

    local images = trees[self.treeType].images
    for i, treeBlock in ipairs(self.treeBlocks) do
        if treeBlock == enum.treeBlocks.TREE_LEFT then
            self.dynamicTreeImages[#self.dynamicTreeImages + 1] = tfm.exec.addImage(images.branch_left.name, '?68', 350, 400 - (i * 50) - GROUND_OFFSET - (images.root.height * 0.5), self.playerName, 0.5, 0.5, 0, 1.0, 0.66, 0.0)
        elseif treeBlock == enum.treeBlocks.TREE_RIGHT then
            self.dynamicTreeImages[#self.dynamicTreeImages + 1] = tfm.exec.addImage(images.branch_right.name, '?68', 450, 400 - (i * 50) - GROUND_OFFSET - (images.root.height * 0.5), self.playerName, 0.5, 0.5, 0, 1.0, 0.33, 0.0)
        end
    end
end

function TimbermouseGame:cutTreeBlock(left)
    if self.over then
        return
    end
    if not self.started then
        self:start()
        self.started = true
    end

    table.remove(self.treeBlocks, 1)
    self.treeBlocks[#self.treeBlocks + 1] = self:generateTreeBlock()
    self:updateTree()

    if  left and self.treeBlocks[1] == enum.treeBlocks.TREE_LEFT or
        not left and self.treeBlocks[1] == enum.treeBlocks.TREE_RIGHT then
        
        self:playerDeath(left)
        return
    end

    tfm.exec.removeImage(self.axeImage)
    if left then
        tfm.exec.movePlayer(self.playerName, 350, 400 - GROUND_OFFSET - 15, false, 0, 0, false)
        tfm.exec.displayParticle(tfm.enum.particle.ghostSpirit, 375, 400 - GROUND_OFFSET - 25, 5, 1, 0.25, 0.1, self.playerName)
        self.axeImage = tfm.exec.addImage(axe(self.playerName).image_right.name, '$'..self.playerName, 20, 0, self.playerName, 0.425, 0.425, 0.0, 1.0, 0.5, 0.5)
    else
        tfm.exec.movePlayer(self.playerName, 450, 400 - GROUND_OFFSET - 15, false, 0, 0, false)
        tfm.exec.displayParticle(tfm.enum.particle.ghostSpirit, 425, 400 - GROUND_OFFSET - 25, -5, 1, -0.25, 0.1, self.playerName)
        self.axeImage = tfm.exec.addImage(axe(self.playerName).image_left.name, '$'..self.playerName, -20, 0, self.playerName, 0.425, 0.425, 0.0, 1.0, 0.5, 0.5)
    end

    self.score = self.score + 1
    self:updateScoreCounter()
    tfm.exec.displayParticle(tfm.enum.particle.projection, 400, 400 - GROUND_OFFSET - 5, 0, 0, 0, 0, self.playerName)

    tfm.exec.playSound(string.format('tfmadv/tranchant%d.mp3', math.random(1, 4)), nil, nil, nil, self.playerName)

    self.timeLeft = math.min(self.timeLeft + 0.20, self.timeTotal)
    self:updateTimeBar()
end

function TimbermouseGame:start()
    tfm.exec.playMusic(string.format('tfmadv/musique/tfmadv_combat%d.mp3', math.random(1, 4)), 'musique', nil, true, true, self.playerName)
end

function TimbermouseGame:removeTimeBar()
    ui.removeTextArea(enum.textArea.TIME_TOTAL, self.playerName)
    ui.removeTextArea(enum.textArea.TIME_LEFT, self.playerName)
end

function TimbermouseGame:updateTimeBar()
    ui.removeTextArea(enum.textArea.TIME_LEFT, self.playerName)

    local timeLeftR = 255 - (255 * (self.timeLeft / self.timeTotal))
    local timeLeftG = 255 - timeLeftR
    local color = tonumber(string.format("%02X%02X00", timeLeftR, timeLeftG), 16)

    local timeLeftWidth = 200 * (self.timeLeft / self.timeTotal)

    ui.addTextArea(enum.textArea.TIME_LEFT, '', self.playerName, 300, 25, timeLeftWidth, 25, color, color, 1.0, true)
end

function TimbermouseGame:onMouseClick(x, y)
    if x > 400 then
        self:cutTreeBlock(false)
    else
        self:cutTreeBlock(true)
    end
end

function TimbermouseGame:onKeyboard(keyCode)
    if keyCode == 0 then
        self:cutTreeBlock(true)
    elseif keyCode == 2 then
        self:cutTreeBlock(false)
    end
end

function startTimbermouseGame(playerName)
    local game = TimbermouseGame:new(playerName)
    playerData[playerName].game = game
end