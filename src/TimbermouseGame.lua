TimbermouseGame = {
    playerName = nil,
    treeBlocks = {},
    treeImages = {},
    score = 0,
    timeLeft = 10.0,
    timeTotal = 10.0,
    started = false
}

function TimbermouseGame:new(playerName)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.playerName = playerName
    o.treeBlocks = {}
    o.treeImages = {}

    o.treeBlocks[1] = enum.treeBlocks.TREE
    for i = 2, 8 do
        o.treeBlocks[i] = math.random(1, 3)
    end

    o:updateTimeBar()
    return o
end

function TimbermouseGame:updateScoreCounter()
    ui.updateTextArea(enum.textArea.SCORE, string.format('<p align="center"><font size="32" color="#FFFFFF" face="serif"><b>%d</b></font></p>', self.score), self.playerName)
end

function TimbermouseGame:endGame()
    if playerData[self.playerName]:onScore(self.score) then
        tfm.exec.playSound('transformice/son/victoire.mp3', nil, nil, nil, self.playerName)
    else
        tfm.exec.playSound('tfmadv/disparition.mp3', nil, nil, nil, self.playerName)
    end

    self.treeBlocks = {}
    for i, imageID in ipairs(self.treeImages) do
        tfm.exec.removeImage(imageID)
    end

    tfm.exec.freezePlayer(self.playerName, false)
    tfm.exec.stopMusic('musique', self.playerName)
    ui.removeTextArea(enum.textArea.SCORE, self.playerName)
    self:removeTimeBar()
    self:showGameover()
    unhidePlayer(self.playerName)
    addStartGameButton(self.playerName)

    playerData[self.playerName].game = nil
end

function TimbermouseGame:showGameover()
    local text = '<p align="center"><font color="#fcf1d2" size="24" face="serif"><b>GAME OVER</b></font></p>'
    text = text .. string.format('<p align="center"><font size="20" color="#825727">SCORE</font><br><font size="24" color="#FFFFFF"><b>%d</b></font></p>', self.score)
    text = text .. string.format('<p align="center"><font size="18" color="#825727">BEST</font><br><font size="22" color="#FFFFFF"><b>%d</b></font></p>', playerData[self.playerName].bestScore)
    ui.addTextArea(enum.textArea.GAME_OVER, text, self.playerName, 275, 150, 250, 150, 0xf0bb69, 0x825727, 1.0, true)
end

function TimbermouseGame:renderTree()
    for i, imageID in ipairs(self.treeImages) do
        tfm.exec.removeImage(imageID)
    end
    self.treeImages = {}
    for i, treeBlock in ipairs(self.treeBlocks) do
        self.treeImages[#self.treeImages + 1] = tfm.exec.addImage(IMAGE_WOOD, '?69', 400, 400 - (i * 50) - GROUND_OFFSET, self.playerName, 0.5, 0.5, 0, 1.0, 0.5, 0)
        if treeBlock == enum.treeBlocks.TREE_LEFT then
            self.treeImages[#self.treeImages + 1] = tfm.exec.addImage(IMAGE_LEFT_BRANCH, '?69', 350, 400 - (i * 50) - GROUND_OFFSET, self.playerName, 0.5, 0.5, 0, 1.0, 0.5, 0)
        elseif treeBlock == enum.treeBlocks.TREE_RIGHT then
            self.treeImages[#self.treeImages + 1] = tfm.exec.addImage(IMAGE_RIGHT_BRANCH, '?69', 450, 400 - (i * 50) - GROUND_OFFSET, self.playerName, 0.5, 0.5, 0, 1.0, 0.5, 0)
        end
    end
end

function TimbermouseGame:cutTreeBlock(left)
    if not self.started then
        self:start()
        self.started = true
    end

    table.remove(self.treeBlocks, 1)
    self.treeBlocks[#self.treeBlocks + 1] = math.random(1, 3)
    self:renderTree()

    if left then
        tfm.exec.movePlayer(self.playerName, 350, 400 - GROUND_OFFSET - 2, false, 0, 0, false)
        tfm.exec.displayParticle(tfm.enum.particle.ghostSpirit, 375, 400 - GROUND_OFFSET - 25, 5, 1, 0.25, 0.1, self.playerName)
    else
        tfm.exec.movePlayer(self.playerName, 450, 400 - GROUND_OFFSET - 2, false, 0, 0, false)
        tfm.exec.displayParticle(tfm.enum.particle.ghostSpirit, 425, 400 - GROUND_OFFSET - 25, -5, 1, -0.25, 0.1, self.playerName)
    end

    self.score = self.score + 1
    self:updateScoreCounter()
    tfm.exec.displayParticle(tfm.enum.particle.projection, 400, 400 - GROUND_OFFSET - 5, 0, 0, 0, 0, self.playerName)

    tfm.exec.playSound(string.format('tfmadv/tranchant%d.mp3', math.random(1, 4)), nil, nil, nil, self.playerName)

    self.timeLeft = math.min(self.timeLeft + 0.15, self.timeTotal)
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
    self:removeTimeBar()

    local timeLeftR = 255 - (255 * (self.timeLeft / self.timeTotal))
    local timeLeftG = 255 - timeLeftR
    local color = tonumber(string.format("%02X%02X00", timeLeftR, timeLeftG), 16)

    local timeLeftWidth = 200 * (self.timeLeft / self.timeTotal)

    ui.addTextArea(enum.textArea.TIME_TOTAL, '', self.playerName, 300, 25, 200, 25, nil, nil, 1.0, true)
    ui.addTextArea(enum.textArea.TIME_LEFT, '', self.playerName, 300, 25, timeLeftWidth, 25, color, color, 1.0, true)
end

function TimbermouseGame:onMouseClick(x, y)
    if x > 400 then
        if self.treeBlocks[1] ~= enum.treeBlocks.TREE_RIGHT then
            self:cutTreeBlock(false)
        else
            self:endGame()
        end
    else
        if self.treeBlocks[1] ~= enum.treeBlocks.TREE_LEFT then
            self:cutTreeBlock(true)
        else
            self:endGame()
        end
    end
end

function startTimbermouseGame(playerName)
    local game = TimbermouseGame:new(playerName)
    playerData[playerName].game = game
    tfm.exec.freezePlayer(playerName, true, false)
    game:renderTree(playerName)
    removeStartGameButton(playerName)
    ui.addTextArea(enum.textArea.SCORE, '', playerName, 300, 70, 200, 50, nil, nil, 0, true)
    game:updateScoreCounter()
    tfm.exec.stopMusic('musique', playerName)
    hideMouseForOthers(playerName)
    ui.removeTextArea(enum.textArea.GAME_OVER, playerName)
end