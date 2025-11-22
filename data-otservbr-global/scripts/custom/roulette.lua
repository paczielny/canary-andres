local config = {  
    actionId = 18562,  
    lever = {  
        left = 2772,  
        right = 2773  
    },  
    playItem = {  
        itemId = 60094,  
        count = 1  
    },  
    rouletteOptions = {  
        rareItemChance_broadcastThreshold = 900,  
        ignoredItems = {1617},  
        winEffects = {CONST_ANI_FIRE, CONST_ME_SOUND_YELLOW, CONST_ME_SOUND_PURPLE, CONST_ME_SOUND_BLUE, CONST_ME_SOUND_WHITE},  
        effectDelay = 450,  
        spinTime = {min = 8, max = 12},  
        spinSlowdownRamping = 8,  
        rouletteStorage = 48550  
    },  
    pendingRewardStorage = 48551,  -- Storage para itemId del premio pendiente  
    pendingRewardCountStorage = 48552,  -- Storage para cantidad del premio pendiente  
    prizePool = {  
        {itemId = 60112, count = {1, 1}, chance = 6000 },  --prismatic bag
        {itemId = 60113, count = {1, 1}, chance = 3000 },  --ornate bag
        {itemId = 60114, count = {1, 1}, chance = 3000 },  --ornate bag
        {itemId = 60115, count = {1, 1}, chance = 4000 },  -- concotion box
        {itemId = 60105, count = {1, 1}, chance = 5000 },  -- food
        {itemId = 60106, count = {1, 1}, chance = 6000 },  -- lottery
        {itemId = 60116, count = {1, 1}, chance = 4000 },  -- concotion res
        {itemId = 60117, count = {1, 1}, chance = 4000 },  -- concotion amp
        {itemId = 60094, count = {5, 5}, chance = 8000 },  -- roulette token
        {itemId = 22516, count = {5, 5}, chance = 8000 },  -- silver token
        {itemId = 22721, count = {5, 5}, chance = 8000 },  -- gold token
        {itemId = 60110, count = {1, 1}, chance = 2000 },  -- mountdoll
        {itemId = 60111, count = {1, 1}, chance = 2000 },  -- addondoll
        {itemId = 34109, count = {1, 1}, chance = 300 },  -- bag you desire
        {itemId = 43895, count = {1, 1}, chance = 100 },  -- bag you covet
        {itemId = 39546, count = {1, 1}, chance = 200 }  -- primal bag
    },  
    roulettePositions = {  
        Position(33469, 32533, 10),  
        Position(33470, 32533, 10),  
        Position(33471, 32533, 10),  
        Position(33472, 32533, 10),  
        Position(33473, 32533, 10),  
        Position(33474, 32533, 10),  
        Position(33475, 32533, 10)  
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
    local positions = config.roulettePositions  
    for i = #positions, 1, -1 do  
        local item = Tile(positions[i]):getTopVisibleThing()  
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then  
            if i ~= 7 then  
                item:moveTo(positions[i + 1])  
            else  
                item:remove()  
            end  
        end  
    end  
    Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[1])  
end  
  
local function clearRoulette(newItemInfo)  
    local positions = config.roulettePositions  
    for i = #positions, 1, -1 do  
        local item = Tile(positions[i]):getTopVisibleThing()  
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then  
            item:remove()  
        end  
        if newItemInfo == nil then  
            positions[i]:sendMagicEffect(CONST_ME_POFF)  
        else  
            Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[i])  
        end  
    end  
end  
  
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
            config.roulettePositions[1]:sendDistanceEffect(config.roulettePositions[4], config.rouletteOptions.winEffects[1])  
            config.roulettePositions[7]:sendDistanceEffect(config.roulettePositions[4], config.rouletteOptions.winEffects[1])  
        else  
            for i = 1, #config.roulettePositions do  
                config.roulettePositions[i]:sendMagicEffect(config.rouletteOptions.winEffects[effectCounter])  
            end  
        end  
        if effectCounter == 2 then  
            local item = Tile(config.roulettePositions[4]):getTopVisibleThing()  
            local newItemInfo = {itemId = item:getId(), count = item:getCount()}  
            clearRoulette(newItemInfo)  
        end  
        addEvent(initiateReward, config.rouletteOptions.effectDelay, leverPosition, effectCounter)  
        return  
    end  
    resetLever(leverPosition)  
end  
  
local function rewardPlayer(playerId, leverPosition)  
    local player = Player(playerId)  
      
    local item = Tile(config.roulettePositions[4]):getTopVisibleThing()  
    if not item then  
        resetLever(leverPosition)  
        return  
    end  
      
    local newItemInfo = {itemId = item:getId(), count = item:getCount()}  
      
    if not player then  
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
      
    -- Si no tiene capacidad o espacio, enviar al STORE INBOX sin atributo STORE  
    if player:getFreeCapacity() < weight or not backpack or backpack:getEmptySlots(true) < 1 then  
        local inbox = player:getStoreInbox()  
          
        -- Usar getItemHoldingCount() para verificar correctamente  
        if inbox and inbox:getItemHoldingCount() < inbox:getMaxCapacity() then  
            local inboxItem = inbox:addItem(newItemInfo.itemId, newItemInfo.count)  
            if inboxItem then  
                -- NO agregar ITEM_ATTRIBUTE_STORE - esto hace el ítem movible  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your reward was sent to your store inbox!")  
                player:setStorageValue(config.rouletteOptions.rouletteStorage, -1)  
                  
                if #chancedItems >= 4 and chancedItems[#chancedItems - 3] <= config.rouletteOptions.rareItemChance_broadcastThreshold then  
                    local itemName = newItemInfo.count > 1 and itemType:getPluralName() or itemType:getName()  
                    local article = newItemInfo.count > 1 and "" or (itemType:getArticle() ~= "" and itemType:getArticle() .. " " or "")  
                    Game.broadcastMessage("The player " .. player:getName() .. " has won " .. article .. newItemInfo.count .. " " .. itemName .. " from the roulette!", MESSAGE_EVENT_ADVANCE)  
                    player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  
                end  
                  
                resetLever(leverPosition)  
                return  
            end  
        end  
          
        -- Fallback a storage  
        player:setStorageValue(config.pendingRewardStorage, newItemInfo.itemId)  
        player:setStorageValue(config.pendingRewardCountStorage, newItemInfo.count)  
        player:setStorageValue(config.rouletteOptions.rouletteStorage, -1)  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your store inbox is full! The reward has been saved and will be delivered when you have space.")  
        resetLever(leverPosition)  
        return  
    end  
      
    player:addItem(newItemInfo.itemId, newItemInfo.count)  
    player:setStorageValue(config.rouletteOptions.rouletteStorage, -1)  
      
    if #chancedItems >= 4 and chancedItems[#chancedItems - 3] <= config.rouletteOptions.rareItemChance_broadcastThreshold then  
        local itemName = newItemInfo.count > 1 and itemType:getPluralName() or itemType:getName()  
        local article = newItemInfo.count > 1 and "" or (itemType:getArticle() ~= "" and itemType:getArticle() .. " " or "")  
        Game.broadcastMessage("The player " .. player:getName() .. " has won " .. article .. newItemInfo.count .. " " .. itemName .. " from the roulette!", MESSAGE_EVENT_ADVANCE)  
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
  
local casinoRoulette = Action()  
  
function casinoRoulette.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
    if item:getId() == config.lever.right then  
        player:sendTextMessage(MESSAGE_FAILURE, "Casino Roulette is currently in progress. Please wait.")  
        return true  
    end  
      
    if player:getItemCount(config.playItem.itemId) < config.playItem.count then  
        if player:getStorageValue(config.rouletteOptions.rouletteStorage) < 1 then  
            player:sendTextMessage(MESSAGE_FAILURE, "Casino Roulette requires " .. config.playItem.count .. " " .. ItemType(config.playItem.itemId):getName() .. " to use.")  
            return true  
        end  
    end  
      
    item:transform(config.lever.right)  
    clearRoulette()  
    chancedItems = {}  
      
    player:removeItem(config.playItem.itemId, config.playItem.count)  
    player:setStorageValue(config.rouletteOptions.rouletteStorage, 1)  
      
    local spinTimeRemaining = math.random((config.rouletteOptions.spinTime.min * 1000), (config.rouletteOptions.spinTime.max * 1000))  
    roulette(player:getId(), toPosition, spinTimeRemaining, 100)  
    return true  
end  
  
casinoRoulette:aid(config.actionId)  
casinoRoulette:register()  
  
local disableMovingItemsToRoulettePositions = MoveEvent()  
  
disableMovingItemsToRoulettePositions.onAddItem = function(moveitem, tileitem, position, item, count, fromPosition, toPosition)  
    for _, k in pairs(config.roulettePositions) do  
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
  
for _, pos in pairs(config.roulettePositions) do    
    disableMovingItemsToRoulettePositions:position(pos)    
end    
disableMovingItemsToRoulettePositions:register()  
  
local rouletteLogin = CreatureEvent("RouletteRewardLogin")  
  
function rouletteLogin.onLogin(player)  
    local pendingItemId = player:getStorageValue(config.pendingRewardStorage)  
    local pendingCount = player:getStorageValue(config.pendingRewardCountStorage)  
      
    if pendingItemId > 0 and pendingCount > 0 then  
        local inbox = player:getStoreInbox()  
          
        -- CORRECCIÓN: Usar getItemHoldingCount()  
        if inbox and inbox:getItemHoldingCount() < inbox:getMaxCapacity() then  
            local inboxItem = inbox:addItem(pendingItemId, pendingCount)  
            if inboxItem then  
                -- NO agregar ITEM_ATTRIBUTE_STORE  
                local itemType = ItemType(pendingItemId)  
                local itemName = pendingCount > 1 and itemType:getPluralName() or itemType:getName()  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received your pending roulette reward: " .. pendingCount .. " " .. itemName .. " in your store inbox!")  
                  
                player:setStorageValue(config.pendingRewardStorage, -1)  
                player:setStorageValue(config.pendingRewardCountStorage, -1)  
            else  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your pending roulette reward couldn't be delivered. Please make sure you have space in your store inbox.")  
            end  
        else  
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your store inbox is full! Please make space to receive your pending roulette reward.")  
        end  
    end  
      
    return true  
end  
  
rouletteLogin:register()