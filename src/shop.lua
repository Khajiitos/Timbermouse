
ShopInterfaceStatus = {
    playerName = nil,
    opened = false,
    offset = 0,
    images = {}
}

function ShopInterfaceStatus:new(playerName)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.playerName = playerName
    o.images = {}
    return o
end

function ShopInterfaceStatus:onTextAreaCallback(callback)
    if callback == "shop" then 
        self:toggle()
    elseif callback == "shopForward" then
        if self.offset + 5 < #axes then
            self.offset = self.offset + 1
            self:close(true)
            self:open(true)
        end
    elseif callback == "shopBack" then
        if self.offset > 0 then
            self.offset = self.offset - 1
            self:close(true)
            self:open(true)
        end
    else
        for axeID in callback:gmatch('buyAxe(%d)') do
            axeID = tonumber(axeID)
            if playerData[self.playerName].woodCoins >= axes[axeID].price and not table.has(playerData[self.playerName].ownedAxes, axeID) then
                playerData[self.playerName].woodCoins = playerData[self.playerName].woodCoins - axes[axeID].price
                playerData[self.playerName].ownedAxes[#playerData[self.playerName].ownedAxes + 1] = axeID
                updateWoodCoinsCounter(self.playerName)
                self:close(true)
                self:open(true)
            end
            return true
        end
        for axeID in callback:gmatch('equipAxe(%d)') do
            axeID = tonumber(axeID)
            if table.has(playerData[self.playerName].ownedAxes, axeID) then
                playerData[self.playerName].equippedAxeID = axeID
                updateWoodCoinsCounter(self.playerName)
                self:close(true)
                self:open(true)
            end
            return true
        end
        return false
    end
    return true
end

function ShopInterfaceStatus:open(justUpdating)
    if not justUpdating then
        ui.addTextArea(enum.textArea.SHOP_BACKGROUND, '', self.playerName, 100, 120, 600, 200, 0x101010, 0x000000, 1.0, true)
        ui.addTextArea(enum.textArea.SHOP_BUTTON_CLOSE, '<p align="center"><a href="event:shop"><font size="16" color="#FFFFFF">Close</font></a></p>', self.playerName, 325, 330, 150, 25, 0x0F0F0F, 0x000000, 1.0, true)
    end

    if self.offset > 0 then
        ui.addTextArea(enum.textArea.SHOP_BUTTON_BACK, '<a href="event:shopBack"><p align="center"><font size="18" color="#FFFFFF"><b>&lt;</b></font></p></a>', self.playerName, 110, 280, 25, 25, 0x101010, 0x000000, 1.0, true)
    else 
        ui.addTextArea(enum.textArea.SHOP_BUTTON_BACK, '<p align="center"><font size="18" color="#AAAAAA"><b>&lt;</b></font></p>', self.playerName, 110, 280, 25, 25, 0x606060, 0x404040, 1.0, true)
    end

    if self.offset + 5 < #axes then
        ui.addTextArea(enum.textArea.SHOP_BUTTON_FORWARD, '<a href="event:shopForward"><p align="center"><font size="18" color="#FFFFFF"><b>&gt;</b></font></p></a>', self.playerName, 665, 280, 25, 25, 0x101010, 0x000000, 1.0, true)
    else
        ui.addTextArea(enum.textArea.SHOP_BUTTON_FORWARD, '<p align="center"><font size="18" color="#AAAAAA"><b>&gt;</b></font></p>', self.playerName, 665, 280, 25, 25, 0x606060, 0x404040, 1.0, true)
    end


    for i = 1 + self.offset, math.min(self.offset + 5, #axes) do
        local item = i - self.offset -- i is the index of the axe, this is the index in the gui (1-5)
        local size, between = 90, 13
        ui.addTextArea(enum.textArea.SHOP_AXE_NAME + item - 1, string.format('<p align="center"><font size="12">%s</font></p>', axes[i].name), self.playerName, 150 + ((item - 1) * (size + between)), 125, size, 20, nil, nil, 0.0, true)
        ui.addTextArea(enum.textArea.SHOP_AXE_IMAGE_FRAME + item - 1, '', self.playerName, 150 + ((item - 1) * (size + between)), 160, size, size, 0x101010, 0x000000, 1.0, true)
        ui.addTextArea(enum.textArea.SHOP_AXE_DESCRIPTION + item - 1, string.format('<p align="center"><font size="6">%s</font></p>', axes[i].description), self.playerName, 150 + ((item - 1) * (size + between)), 260, size, 30, nil, nil, 0.0, true)

        if table.has(playerData[self.playerName].ownedAxes, i) then
            if playerData[self.playerName].equippedAxeID == i then
                ui.addTextArea(enum.textArea.SHOP_AXE_BUTTON + item - 1, '<p align="center"><font size="10" color="#AAAAAA">Equipped</font></p>', self.playerName, 150 + ((item - 1) * (size + between)), 290, size, 15, 0x808080, 0x606060, 1.0, true)
            else
                ui.addTextArea(enum.textArea.SHOP_AXE_BUTTON + item - 1, string.format('<a href="event:equipAxe%d"><p align="center"><font size="10" color="#FFFFFF">Equip</font></p></a>', i), self.playerName, 150 + ((item - 1) * (size + between)), 290, size, 15, 0x10AA10, 0x108010, 1.0, true)
            end
        else
            if playerData[self.playerName].woodCoins >= axes[i].price then
                ui.addTextArea(enum.textArea.SHOP_AXE_BUTTON + item - 1, string.format('<a href="event:buyAxe%d"><textformat indent="20"><p align="center"><font size="10" color="#FFFFFF">%d</font></p></textformat></a>', i, axes[i].price), self.playerName, 150 + ((item - 1) * (size + between)), 290, size, 15, 0x10AA10, 0x108010, 1.0, true)
            else
                ui.addTextArea(enum.textArea.SHOP_AXE_BUTTON + item - 1, string.format('<textformat indent="20"><p align="center"><font size="10" color="#BBBBBB">%d</font></p></textformat>', axes[i].price), self.playerName, 150 + ((item - 1) * (size + between)), 290, size, 15, 0x808080, 0x606060, 1.0, true)
            end
            self.images[#self.images + 1] = tfm.exec.addImage(images.wood_coin.name, '&69', 150 + 15 + ((item - 1) * (size + between)), 300, self.playerName, 0.25, 0.25, 0.0, 1.0, 0.5, 0.5)
        end

        self.images[#self.images + 1] = tfm.exec.addImage(axes[i].image_right.name, '&69', 150 + 45 + ((item - 1) * (size + between)), 200, self.playerName, 0.5, 0.5, 0.0, 1.0, 0.5, 0.5)
    end

    self.opened = true
end

function ShopInterfaceStatus:close(justUpdating)
    if not justUpdating then
        ui.removeTextArea(enum.textArea.SHOP_BACKGROUND, self.playerName)
        ui.removeTextArea(enum.textArea.SHOP_BUTTON_CLOSE, self.playerName)
    end
    ui.removeTextArea(enum.textArea.SHOP_BUTTON_BACK, self.playerName)
    ui.removeTextArea(enum.textArea.SHOP_BUTTON_FORWARD, self.playerName)
    for i = 0, 4 do
        ui.removeTextArea(enum.textArea.SHOP_AXE_NAME + i, self.playerName)
        ui.removeTextArea(enum.textArea.SHOP_AXE_DESCRIPTION + i, self.playerName)
        ui.removeTextArea(enum.textArea.SHOP_AXE_IMAGE_FRAME + i, self.playerName)
        ui.removeTextArea(enum.textArea.SHOP_AXE_BUTTON + i, self.playerName)
    end
    for index, imageID in ipairs(self.images) do
        tfm.exec.removeImage(imageID)
        self.images[index] = nil
    end
    self.opened = false
end

function ShopInterfaceStatus:toggle()
    if self.opened then
        self:close()
    else
        self:open()
    end
end