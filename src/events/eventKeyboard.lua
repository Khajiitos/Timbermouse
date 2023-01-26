function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)
    if keyCode == 0 then
        if game(playerName) then
            if game(playerName).treeBlocks[1] ~= enum.treeBlocks.TREE_LEFT then
                game(playerName):cutTreeBlock(true)
            else
                game(playerName):endGame()
            end
        end
    elseif keyCode == 2 then
        if game(playerName) then
            if game(playerName).treeBlocks[1] ~= enum.treeBlocks.TREE_RIGHT then
                game(playerName):cutTreeBlock(false)
            else
                game(playerName):endGame()
            end
        end
    end
end