local config = {    
    actionId = 34121,    
    requiredItem = {    
        itemId = 60095,  -- platinum token    
        count = 1    
    },    
    cooldownTime = 1,    
    spinTime = 8,    
    moveDelay = 40,  -- Delay inicial    
    spinSlowdownRamping = 3,  -- Incremento por ciclo    
    winChance = 100,  -- 30% de probabilidad de ganar algo    
    pendingRewardStorage = 48556,    
    pendingRewardCountStorage = 48557,    
    positions = {    
        {Position(33471, 32542, 12), Position(33472, 32542, 12), Position(33473, 32542, 12)},    
        {Position(33471, 32543, 12), Position(33472, 32543, 12), Position(33473, 32543, 12)},    
        {Position(33471, 32544, 12), Position(33472, 32544, 12), Position(33473, 32544, 12)}    
    },    
    prizePool = {    
        {itemId = 60139, chance = 5000},   -- gnome bag (0.5%)    
        {itemId = 60140, chance = 5000},   -- lion bag (0.5%)    
        {itemId = 60141, chance = 5000},   -- falcon bag (0.5%)    
        {itemId = 60142, chance = 5000},   -- ratmiral bag (0.5%)    
        {itemId = 60143, chance = 5000},   -- cobra bag (0.5%)    
        {itemId = 34109, chance = 1000},  -- bag you desire (1%)    
        {itemId = 39546, chance = 1500},  -- primal bag (1.5%)
    }    
}    
    
local isSpinning = false    
    
local function resetMachine()    
    isSpinning = false    
end    
    
local function selectRandomPrize()    
    local totalChance = 0    
    for i = 1, #config.prizePool do    
        totalChance = totalChance + config.prizePool[i].chance    
    end    
        
    local random = math.random(totalChance)    
    local currentChance = 0    
        
    for i = 1, #config.prizePool do    
        currentChance = currentChance + config.prizePool[i].chance    
        if random <= currentChance then    
            return config.prizePool[i].itemId    
        end    
    end    
        
    return nil    
end    
  
local function moveItems(columns, cycle, currentDelay, callback)    
    -- Verificar condición de salida    
    local stopColumn1 = cycle > (config.spinTime * 6)    
    local stopColumn2 = cycle > (config.spinTime * 8)    
    local stopColumn3 = cycle > (config.spinTime * 10)    
        
    if stopColumn1 and stopColumn2 and stopColumn3 then    
        if callback and type(callback) == "function" then    
            callback()    
        end    
        return    
    end    
          
    -- Mover solo las columnas que aún no se han detenido      
    for col = 1, #columns do      
        local shouldMove = true      
        if col == 1 and stopColumn1 then shouldMove = false end      
        if col == 2 and stopColumn2 then shouldMove = false end      
        if col == 3 and stopColumn3 then shouldMove = false end      
              
        if shouldMove then      
            local column = columns[col]      
            local tempItems = {}      
                  
            for row = 1, #column do      
                local tile = Tile(column[row])      
                if tile then      
                    local item = tile:getTopDownItem()      
                    if item then      
                        tempItems[#tempItems + 1] = item:getId()      
                        item:remove()      
                    end      
                end      
            end      
                  
            for row = #column, 2, -1 do      
                if tempItems[row - 1] then      
                    Game.createItem(tempItems[row - 1], 1, column[row])      
                end      
            end      
                  
            local prizeId = selectRandomPrize()      
            if prizeId then      
                Game.createItem(prizeId, 1, column[1])      
            end      
        end      
    end      
          
    local nextDelay = currentDelay + config.spinSlowdownRamping    
    addEvent(function()    
        moveItems(columns, cycle + 1, nextDelay, callback)    
    end, nextDelay)    
end  
    
local function clearGrid()    
    for col = 1, #config.positions do    
        for row = 1, #config.positions[col] do    
            local tile = Tile(config.positions[col][row])    
            if tile then    
                local item = tile:getTopDownItem()    
                if item then    
                    item:remove()    
                end    
            end    
        end    
    end    
end    
    
local function checkWin()  
    if math.random(100) > config.winChance then  
        return nil, nil  
    end  
      
    local grid = {}  
    for col = 1, 3 do  
        grid[col] = {}  
        for row = 1, 3 do  
            local tile = Tile(config.positions[col][row])  
            if tile then  
                local item = tile:getTopDownItem()  
                if item then  
                    grid[col][row] = item:getId()  
                end  
            end  
        end  
    end  
      
    -- Verificar filas horizontales  
    for row = 1, 3 do  
        if grid[1][row] and grid[1][row] == grid[2][row] and grid[2][row] == grid[3][row] then  
            local winningLine = {  
                config.positions[1][row],  
                config.positions[2][row],  
                config.positions[3][row]  
            }  
            return grid[1][row], winningLine  
        end  
    end  
      
    -- Verificar columnas verticales  
    for col = 1, 3 do  
        if grid[col][1] and grid[col][1] == grid[col][2] and grid[col][2] == grid[col][3] then  
            local winningLine = {  
                config.positions[col][1],  
                config.positions[col][2],  
                config.positions[col][3]  
            }  
            return grid[col][1], winningLine  
        end  
    end  
      
    -- Verificar diagonal principal  
    if grid[1][1] and grid[1][1] == grid[2][2] and grid[2][2] == grid[3][3] then  
        local winningLine = {  
            config.positions[1][1],  
            config.positions[2][2],  
            config.positions[3][3]  
        }  
        return grid[1][1], winningLine  
    end  
      
    -- Verificar diagonal secundaria  
    if grid[1][3] and grid[1][3] == grid[2][2] and grid[2][2] == grid[3][1] then  
        local winningLine = {  
            config.positions[1][3],  
            config.positions[2][2],  
            config.positions[3][1]  
        }  
        return grid[1][3], winningLine  
    end  
      
    return nil, nil  
end
    
local function rewardPlayer(playerId)      
    local player = Player(playerId)      
          
    if not player then      
        resetMachine()      
        return      
    end      
          
    local wonItem, winningLine = checkWin()  -- Modificado para recibir también la línea ganadora  
          
    if not wonItem then      
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You didn't win this time. Try again!")      
        player:setStorageValue(config.pendingRewardStorage, -1)      
        player:setStorageValue(config.pendingRewardCountStorage, -1)      
        resetMachine()      
        return      
    end      
          
    -- Enviar efectos visuales en la línea ganadora  
    if winningLine then  
        for _, position in ipairs(winningLine) do  
            position:sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  
        end  
    end  
          
    local itemType = ItemType(wonItem)      
    local inbox = player:getStoreInbox()      
          
    -- Intentar enviar al Store Inbox si no hay capacidad      
    if player:getFreeCapacity() < itemType:getWeight() or not player:getSlotItem(CONST_SLOT_BACKPACK) or player:getSlotItem(CONST_SLOT_BACKPACK):getEmptySlots(true) < 1 then      
        if inbox and inbox:getItemHoldingCount() < inbox:getMaxCapacity() then      
            local inboxItem = inbox:addItem(wonItem, 1)      
            if inboxItem then      
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You won " .. itemType:getName() .. "! It was sent to your store inbox!")      
                player:setStorageValue(config.pendingRewardStorage, -1)      
                player:setStorageValue(config.pendingRewardCountStorage, -1)      
                      
                -- Broadcast para bags temáticas      
                if wonItem >= 60139 and wonItem <= 60143 then      
                    Game.broadcastMessage("The player " .. player:getName() .. " has won " .. itemType:getName() .. " from the slot machine!", MESSAGE_EVENT_ADVANCE)      
                    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)      
                end      
                      
                resetMachine()      
                return      
            end      
        end      
              
        -- Fallback a storage si inbox está lleno      
        player:setStorageValue(config.pendingRewardStorage, wonItem)      
        player:setStorageValue(config.pendingRewardCountStorage, 1)      
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your store inbox is full! The reward has been saved and will be delivered when you have space.")      
        resetMachine()      
        return      
    end      
          
    -- Entregar normalmente      
    player:addItem(wonItem, 1)      
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You won " .. itemType:getName() .. "!")      
    player:setStorageValue(config.pendingRewardStorage, -1)      
    player:setStorageValue(config.pendingRewardCountStorage, -1)      
          
    -- Broadcast para bags temáticas      
    if wonItem >= 60139 and wonItem <= 60143 then      
        Game.broadcastMessage("The player " .. player:getName() .. " has won " .. itemType:getName() .. " from the slot machine!", MESSAGE_EVENT_ADVANCE)      
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)      
    end      
          
    resetMachine()      
end  
    
local slotmachine = Action()    
    
function slotmachine.onUse(player, item, fromPosition, target, toPosition, isHotkey)    
    if isSpinning then    
        player:sendCancelMessage("The slot machine is in use. Please wait for it to finish spinning.")    
        return true    
    end    
    
    if player:getStorageValue(34121) > os.time() then    
        player:sendCancelMessage("You must wait before playing again.")    
        return true    
    end    
    
    if player:getItemCount(config.requiredItem.itemId) < config.requiredItem.count then    
        player:sendCancelMessage("You need " .. config.requiredItem.count .. " " .. ItemType(config.requiredItem.itemId):getName() .. " to play.")    
        return true    
    end    
    
    player:removeItem(config.requiredItem.itemId, config.requiredItem.count)    
    player:setStorageValue(config.pendingRewardStorage, 1)    
    isSpinning = true    
    
    clearGrid()    
        
    -- CORRECCIÓN: Solo 4 parámetros, sin el {} extra  
    moveItems(config.positions, 0, config.moveDelay, function()    
        rewardPlayer(player:getId())    
        player:setStorageValue(34121, os.time() + config.cooldownTime)    
    end)    
    
    return true    
end  
    
slotmachine:aid(config.actionId)    
slotmachine:register()    
    
-- Sistema de recuperación de premios al login    
local slotMachineLogin = CreatureEvent("SlotMachineRewardLogin")    
    
function slotMachineLogin.onLogin(player)    
    local pendingItemId = player:getStorageValue(config.pendingRewardStorage)    
    local pendingCount = player:getStorageValue(config.pendingRewardCountStorage)    
        
    if pendingItemId > 0 and pendingCount > 0 then    
        local inbox = player:getStoreInbox()    
            
        if inbox and inbox:getItemHoldingCount() < inbox:getMaxCapacity() then    
            local inboxItem = inbox:addItem(pendingItemId, pendingCount)    
            if inboxItem then    
                local itemType = ItemType(pendingItemId)    
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received your pending slot machine reward: " .. itemType:getName() .. " in your store inbox!")    
                    
                player:setStorageValue(config.pendingRewardStorage, -1)    
                player:setStorageValue(config.pendingRewardCountStorage, -1)    
            else    
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your pending slot machine reward couldn't be delivered. Please make sure you have space in your store inbox.")    
            end    
        else    
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your store inbox is full! Please make space to receive your pending slot machine reward.")    
        end    
    end    
        
    return true    
end    
    
slotMachineLogin:register()