local taskClear = TalkAction("!task")  
  
function taskClear.onSay(player, words, param)  
    -- Verificar que el parámetro sea "clear"  
    if param ~= "clear" then  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: !task clear")  
        return false  
    end  
      
    -- Buscar si el jugador tiene alguna task activa  
    local hasActiveTask = false  
    local clearedTask = nil  
      
    for roomId = 1, #TaskRooms do  
        for _, task in ipairs(TaskRooms[roomId]) do  
            local questStatus = player:getStorageValue(task.storage.quest)  
            local currentKills = player:getStorageValue(task.storage.counter)  

            if questStatus == 1 then
                hasActiveTask = true  
                clearedTask = task  
                  
                -- Resetear los storages de la task  
                player:setStorageValue(task.storage.quest, -1)  
                player:setStorageValue(task.storage.counter, 0)  
                  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,   
                    "You have cleared the " .. task.name .. " task. Your progress has been reset.")  
                return false  
            end  
        end  
    end  
      
    if not hasActiveTask then  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have any active task to clear.")  
    end  
      
    return false  
end  
  
taskClear:separator(" ")  
taskClear:groupType("normal")   
taskClear:register()