PlayerData = {
    playerName = nil,
    game = nil,
    bestScore = 0,
    hidden = false,
    imagesFromHide = {}
}

function PlayerData:new(playerName)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.playerName = playerName
    o.imagesFromHide = {}
    return o
end

function PlayerData:onScore(score)
    if score > self.bestScore then
        self.bestScore = score
        tfm.exec.setPlayerScore(self.playerName, score, false)
        return true
    end
    return false
end