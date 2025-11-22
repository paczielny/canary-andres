local chestConfig = {  
    -- Cofre Easy  
    [1] = {  
        name = "Easy",  
        requiredStorage = Storage.Quest.U15_20.TaskRooms.Room1.Cyclops.quest,  
        chestStorage = 68024,  
        position = Position(953, 1054, 5),
        rewards = {  
            { itemId = 3035, count = 100 }, -- 100 platinum coins  
            { itemId = 3031, count = 50 },  -- 50 gold coins  
        }  
    },  
    -- Cofre Medium  
    [2] = {  
        name = "Medium",  
        requiredStorage = Storage.Quest.U15_20.TaskRooms.Room2.Lizard.quest,  
        chestStorage = 68049,  
        position = Position(899, 1054, 5),
        rewards = {  
            { itemId = 3035, count = 200 },  
            { itemId = 3029, count = 10 }, -- 10 small sapphires  
        }  
    },  
    -- Cofre Hard  
    [3] = {  
        name = "Hard",  
        requiredStorage = Storage.Quest.U15_20.TaskRooms.Room3.Goanna.quest,  
        chestStorage = 68074,  
        position = Position(916, 1004, 5),
        rewards = {  
        { itemId = 3035, count = 300 },  
            { itemId = 3030, count = 5 }, -- 5 small rubies  
        }  
    },  
    -- Cofre Challenge  
    [4] = {  
        name = "Challenge",  
        requiredStorage = Storage.Quest.U15_20.TaskRooms.Room4.DarklightCore.quest,  
        chestStorage = 68099,  
        position = Position(914, 955, 5),
        rewards = {  
            { itemId = 3035, count = 500 },  
            { itemId = 3028, count = 3 }, -- 3 small diamonds  
        }  
    }
}  
  
local taskRoomsChests = Action()  
  
function taskRoomsChests.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
    -- Buscar qué cofre corresponde a esta posición  
    local chestData = nil  
      
    for _, chest in ipairs(chestConfig) do  
        if toPosition == chest.position then  
            chestData = chest  
            break  
        end  
    end  
      
    if not chestData then  
        return false  
    end  
      
    -- Verificar si ya abrió este cofre  
    if player:getStorageValue(chestData.chestStorage) == 1 then  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")  
        return true  
    end  
      
    -- Verificar si completó la última task del room  
    if player:getStorageValue(chestData.requiredStorage) < 2 then  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,   
            "You need to complete all tasks in the " .. chestData.name .. " room before opening this chest.")  
        return true  
    end  
      
    -- Entregar recompensas  
    local rewardText = "You have found: "  
    for i, reward in ipairs(chestData.rewards) do  
        player:addItem(reward.itemId, reward.count, true)  
        local itemType = ItemType(reward.itemId)  
        if i > 1 then  
            rewardText = rewardText .. ", "  
        end  
        rewardText = rewardText .. reward.count .. " " .. itemType:getPluralName()  
    end  
      
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, rewardText .. ".")  
    player:setStorageValue(chestData.chestStorage, 1)  
      
    return true  
end  
  
-- Registrar todas las posiciones de cofres  
for _, chest in ipairs(chestConfig) do  
    taskRoomsChests:position(chest.position)  
end  
  
taskRoomsChests:register()