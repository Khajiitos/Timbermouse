PlayerData = {
    playerName = nil,
    game = nil,
    bestScore = 0,
    hidden = false,
    imagesFromHide = {},
    openHelpTab = enum.helpTab.CLOSED,
    woodCoins = 6969420,
    shopInterfaceStatus = nil,
    equippedAxeID = 1,
    ownedAxes = {}
}

function PlayerData:new(playerName)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.playerName = playerName
    o.imagesFromHide = {}
    o.shopInterfaceStatus = ShopInterfaceStatus:new(playerName)
    o.ownedAxes = {1}
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