local config = {  
    actionId = 18564,  
    lever = {  
        left = 2772,  
        right = 2773  
    },  
    playItem = {  
        itemId = 3043,  
        count = 100  
    },  
    rouletteOptions = {  
        rareItemChance_broadcastThreshold = 500,  
        ignoredItems = {1617},  
        winEffects = {CONST_ANI_FIRE, CONST_ME_SOUND_YELLOW, CONST_ME_SOUND_PURPLE, CONST_ME_SOUND_BLUE, CONST_ME_SOUND_WHITE},  
        effectDelay = 333,  
        spinTime = {min = 8, max = 12},  
        spinSlowdownRamping = 5,  
        rouletteStorageDoll = 48553  -- Cambiado para no conflictuar con la otra ruleta  
    },  
    pendingRewardStorage = 48554,  -- Storage para itemId del premio pendiente  
    pendingRewardCountStorage = 48555,  -- Storage para cantidad del premio pendiente  
    prizePool = {  
        {itemId = 32076, count = {1, 1}, chance = 10000 },  
        {itemId = 32077, count = {1, 1}, chance = 10000 },  
        {itemId = 30317, count = {1, 1}, chance = 10000 },  
        {itemId = 32075, count = {1, 1}, chance = 10000 },  
        {itemId = 32074, count = {1, 1}, chance = 10000 },  
        {itemId = 32765, count = {1, 1}, chance = 10000 },  
        {itemId = 32764, count = {1, 1}, chance = 10000 }  
    },  
    roulettedollPositions = {  
        Position(33468, 32535, 11),  
        Position(33469, 32535, 11),  
        Position(33470, 32535, 11),  
        Position(33471, 32535, 11),  
        Position(33472, 32535, 11),  -- Posición 5 es el premio  
        Position(33473, 32535, 11),  
        Position(33474, 32535, 11),  
        Position(33475, 32535, 11),  
        Position(33476, 32535, 11)  
    }  
}  
  
local chancedItems = {}  
  
local function resetLever(position)  
    local lever = Tile(position):getItemById(config.lever.right)  
    if lever then  
        lever:transform(config.lever.left)  
    end  
end  
  
local function updateRoulette(newItemInfo)  
    local positions = config.roulettedollPositions  
    for i = #positions, 1, -1 do  
        local item = Tile(positions[i]):getTopVisibleThing()  
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then  
            if i ~= 9 then  
                item:moveTo(positions[i + 1])  
            else  
                item:remove()  
            end  
        end  
    end  
      
    if ItemType(newItemInfo.itemId):getCharges() then  
        local item = Game.createItem(newItemInfo.itemId, 1, positions[1])  
        item:setAttribute("charges", newItemInfo.count)  
    else  
        Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[1])  
    end  
end  
  
local function clearRoulette(newItemInfo)  
    local positions = config.roulettedollPositions  
    for i = #positions, 1, -1 do  
        local item = Tile(positions[i]):getTopVisibleThing()  
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then  
            item:remove()  
        end  
        if newItemInfo == nil then  
            positions[i]:sendMagicEffect(CONST_ME_POFF)  
        else  
            if ItemType(newItemInfo.itemId):getCharges() then  
                local item = Game.createItem(newItemInfo.itemId, 1, positions[i])  
                item:setAttribute("charges", newItemInfo.count)  
            else  
                Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[i])  
            end  
        end  
    end  
end  
  
-- MEJORA: Sistema de probabilidades acumulativas  
local function chanceNewReward()  
    local totalChance = 0  
    for i = 1, #config.prizePool do  
        totalChance = totalChance + config.prizePool[i].chance  
    end  
      
    local random = math.random(totalChance)  
    local currentChance = 0  
      
    for i = 1, #config.prizePool do  
        currentChance = currentChance + config.prizePool[i].chance  
        if random <= currentChance then  
            local selectedPrize = config.prizePool[i]  
            local newItemInfo = {  
                itemId = selectedPrize.itemId,  
                count = math.random(selectedPrize.count[1], selectedPrize.count[2])  
            }  
            chancedItems[#chancedItems + 1] = selectedPrize.chance  
            return newItemInfo  
        end  
    end  
      
    local selectedPrize = config.prizePool[1]  
    return {  
        itemId = selectedPrize.itemId,  
        count = math.random(selectedPrize.count[1], selectedPrize.count[2])  
    }  
end  
  
local function initiateReward(leverPosition, effectCounter)  
    if effectCounter < #config.rouletteOptions.winEffects then  
        effectCounter = effectCounter + 1  
        if effectCounter == 1 then  
            config.roulettedollPositions[1]:sendDistanceEffect(config.roulettedollPositions[5], config.rouletteOptions.winEffects[1])  
            config.roulettedollPositions[9]:sendDistanceEffect(config.roulettedollPositions[5], config.rouletteOptions.winEffects[1])  
        else  
            for i = 1, #config.roulettedollPositions do  
                config.roulettedollPositions[i]:sendMagicEffect(config.rouletteOptions.winEffects[effectCounter])  
            end  
        end  
        if effectCounter == 2 then  
            local item = Tile(config.roulettedollPositions[5]):getTopVisibleThing()  
            local newItemInfo = {itemId = item:getId(), count = item:getCount()}  
            clearRoulette(newItemInfo)  
        end  
        addEvent(initiateReward, config.rouletteOptions.effectDelay, leverPosition, effectCounter)  
        return  
    end  
    resetLever(leverPosition)  
end  
  
-- MEJORA: Sistema de recuperación de premios con Store Inbox  
local function rewardPlayer(playerId, leverPosition)  
    local player = Player(playerId)  
      
    local item = Tile(config.roulettedollPositions[5]):getTopVisibleThing()  
    if not item then  
        resetLever(leverPosition)  
        return  
    end  
      
    local newItemInfo = {itemId = item:getId(), count = item:getCount()}  
      
    if not player then  
        -- Guardar premio pendiente si el jugador se desconectó  
        db.asyncStoreQuery(string.format(  
            "INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES (%d, %d, %d), (%d, %d, %d) ON DUPLICATE KEY UPDATE `value` = VALUES(`value`)",  
            playerId, config.pendingRewardStorage, newItemInfo.itemId,  
            playerId, config.pendingRewardCountStorage, newItemInfo.count  
        ))  
        resetLever(leverPosition)  
        return  
    end  
      
    local itemType = ItemType(newItemInfo.itemId)  
    local weight = itemType:getWeight(newItemInfo.count)  
    local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)  
      
    -- Si no tiene capacidad o espacio, enviar al Store Inbox  
    if player:getFreeCapacity() < weight or not backpack or backpack:getEmptySlots(true) < 1 then  
        local inbox = player:getStoreInbox()  
          
        if inbox and inbox:getItemHoldingCount() < inbox:getMaxCapacity() then  
            local inboxItem  
            if ItemType(newItemInfo.itemId):getCharges() then  
                inboxItem = inbox:addItem(newItemInfo.itemId, 1)  
                if inboxItem then  
                    inboxItem:setAttribute("charges", newItemInfo.count)  
                end  
            else  
                inboxItem = inbox:addItem(newItemInfo.itemId, newItemInfo.count)  
            end  
              
            if inboxItem then  
                -- NO agregar ITEM_ATTRIBUTE_STORE para que sea movible  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your reward was sent to your store inbox!")  
                player:setStorageValue(config.rouletteOptions.rouletteStorageDoll, -1)  
                  
                if #chancedItems >= 4 and chancedItems[#chancedItems - 3] <= config.rouletteOptions.rareItemChance_broadcastThreshold then  
                    local itemName = newItemInfo.count > 1 and itemType:getPluralName() or itemType:getName()  
                    local article = newItemInfo.count > 1 and "" or (itemType:getArticle() ~= "" and itemType:getArticle() .. " " or "")  
                    Game.broadcastMessage("The player " .. player:getName() .. " has won " .. article .. newItemInfo.count .. " " .. itemName .. " from the doll roulette!", MESSAGE_EVENT_ADVANCE)  
                    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  
                end  
                  
                resetLever(leverPosition)  
                return  
            end  
        end  
          
        -- Fallback a storage si inbox está lleno  
        player:setStorageValue(config.pendingRewardStorage, newItemInfo.itemId)  
        player:setStorageValue(config.pendingRewardCountStorage, newItemInfo.count)  
        player:setStorageValue(config.rouletteOptions.rouletteStorageDoll, -1)  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your store inbox is full! The reward has been saved and will be delivered when you have space.")  
        resetLever(leverPosition)  
        return  
    end  
      
    -- Si tiene capacidad y espacio, entregar normalmente  
    if ItemType(newItemInfo.itemId):getCharges() then  
        local addedItem = player:addItem(newItemInfo.itemId, 1)  
        if addedItem then  
            addedItem:setAttribute("charges", newItemInfo.count)  
        end  
    else  
        player:addItem(newItemInfo.itemId, newItemInfo.count)  
    end  
      
    player:setStorageValue(config.rouletteOptions.rouletteStorageDoll, -1)  
      
    if #chancedItems >= 4 and chancedItems[#chancedItems - 3] <= config.rouletteOptions.rareItemChance_broadcastThreshold then  
        local itemName = newItemInfo.count > 1 and itemType:getPluralName() or itemType:getName()  
        local article = newItemInfo.count > 1 and "" or (itemType:getArticle() ~= "" and itemType:getArticle() .. " " or "")  
        Game.broadcastMessage("The player " .. player:getName() .. " has won " .. article .. newItemInfo.count .. " " .. itemName .. " from the doll roulette!", MESSAGE_EVENT_ADVANCE)  
        player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  
    end  
      
    resetLever(leverPosition)  
end  
  
local function roulette(playerId, leverPosition, spinTimeRemaining, spinDelay)  
    local player = Player(playerId)  
    if not player then  
        resetLever(leverPosition)  
        return  
    end  
      
    local newItemInfo = chanceNewReward()  
    updateRoulette(newItemInfo)  
      
    if spinTimeRemaining > 0 then  
        spinDelay = spinDelay + config.rouletteOptions.spinSlowdownRamping  
        addEvent(roulette, spinDelay, playerId, leverPosition, spinTimeRemaining - (spinDelay - config.rouletteOptions.spinSlowdownRamping), spinDelay)  
        return  
    end  
      
    initiateReward(leverPosition, 0)  
    rewardPlayer(playerId, leverPosition)  
end  
  
local dollRoulette = Action()  
  
function dollRoulette.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
    if item:getId() == config.lever.right then  
        player:sendTextMessage(MESSAGE_FAILURE, "Doll Roulette is currently in progress. Please wait.")  
        return true  
    end  
      
    if player:getItemCount(config.playItem.itemId) < config.playItem.count then  
        if player:getStorageValue(config.rouletteOptions.rouletteStorageDoll) < 1 then  
            player:sendTextMessage(MESSAGE_FAILURE, "Doll Roulette requires " .. config.playItem.count .. " " .. ItemType(config.playItem.itemId):getName() .. " to use.")  
            return true  
        end  
    end  
      
    item:transform(config.lever.right)  
    clearRoulette()  
    chancedItems = {}  
      
    player:removeItem(config.playItem.itemId, config.playItem.count)  
    player:setStorageValue(config.rouletteOptions.rouletteStorageDoll, 1)  
      
    local spinTimeRemaining = math.random((config.rouletteOptions.spinTime.min * 1000), (config.rouletteOptions.spinTime.max * 1000))  
    roulette(player:getId(), toPosition, spinTimeRemaining, 100)  
    return true  
end  
  
dollRoulette:aid(config.actionId)  
dollRoulette:register()  
  
local disableMovingDollssToroulettedollPositions = MoveEvent()  
  
disableMovingDollssToroulettedollPositions.onAddItem = function(moveitem, tileitem, position, item, count, fromPosition, toPosition)  
    for _, k in pairs(config.roulettedollPositions) do  
        if toPosition == k then  
            local player = Player(moveitem)  
            if player then  
                player:sendCancelMessage("You cannot place items on the roulette.")  
            end  
            return false  
        end  
    end  
    return true  
end  
  
for _, pos in pairs(config.roulettedollPositions) do  
    disableMovingDollssToroulettedollPositions:position(pos)  
end  
disableMovingDollssToroulettedollPositions:register()  

local dollRouletteLogin = CreatureEvent("DollRouletteRewardLogin")  
  
function dollRouletteLogin.onLogin(player)  
    local pendingItemId = player:getStorageValue(config.pendingRewardStorage)  
    local pendingCount = player:getStorageValue(config.pendingRewardCountStorage)  
      
    if pendingItemId > 0 and pendingCount > 0 then  
        local inbox = player:getStoreInbox()  
          
        -- CORRECCIÓN: Usar getItemHoldingCount()  
        if inbox and inbox:getItemHoldingCount() < inbox:getMaxCapacity() then  
            local inboxItem  
            if ItemType(pendingItemId):getCharges() then  
                inboxItem = inbox:addItem(pendingItemId, 1)  
                if inboxItem then  
                    inboxItem:setAttribute("charges", pendingCount)  
                end  
            else  
                inboxItem = inbox:addItem(pendingItemId, pendingCount)  
            end  
              
            if inboxItem then  
                -- NO agregar ITEM_ATTRIBUTE_STORE  
                local itemType = ItemType(pendingItemId)  
                local itemName = pendingCount > 1 and itemType:getPluralName() or itemType:getName()  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received your pending doll roulette reward: " .. pendingCount .. " " .. itemName .. " in your store inbox!")  
                  
                player:setStorageValue(config.pendingRewardStorage, -1)  
                player:setStorageValue(config.pendingRewardCountStorage, -1)  
            else  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your pending doll roulette reward couldn't be delivered. Please make sure you have space in your store inbox.")  
            end  
        else  
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your store inbox is full! Please make space to receive your pending doll roulette reward.")  
        end  
    end  
      
    return true  
end  
  
dollRouletteLogin:register()