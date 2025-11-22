local taskAction = Action()    
local scrollTransformations = {  
    [60144] = 60150,  
    [60150] = 60144,  
    [60145] = 60149,  
    [60149] = 60145,  
    [60146] = 60148,  
    [60148] = 60146,  
    [60147] = 60151,  
    [60151] = 60147,  
}  

local pendingReverts = {}  

local originalScrollIds = {  
    [60150] = 60144,  
    [60149] = 60145,  
    [60148] = 60146,  
    [60151] = 60147,  
} 

local REVERT_TIME = 3 * 1000  
  
local function revertScroll(position, transformedId, originalId)  
    local posKey = position.x .. ":" .. position.y .. ":" .. position.z  
      
    local tile = Tile(position)  
    if tile then  
        local item = tile:getItemById(transformedId)  
        if item then  
            item:transform(originalId)  
        end  
    end  

    pendingReverts[posKey] = nil  
end  

function taskAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)  

    local itemId = item:getId()  
    local transformTo = scrollTransformations[itemId]  
      
    if transformTo then  
        local posKey = fromPosition.x .. ":" .. fromPosition.y .. ":" .. fromPosition.z  

        if pendingReverts[posKey] then  
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This scroll is already being used.")  
            return true  
        end  

        pendingReverts[posKey] = true  
          
        item:transform(transformTo)  
        item:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)  

        addEvent(revertScroll, REVERT_TIME, fromPosition, transformTo, itemId)  
    end  

    local taskData = nil    
    local roomId = nil    
        
    for room = 1, #TaskRooms do      
        for _, task in ipairs(TaskRooms[room]) do      
            if fromPosition.x == task.position.x and       
               fromPosition.y == task.position.y and       
               fromPosition.z == task.position.z then      
                taskData = task      
                roomId = room      
                break      
            end      
        end      
        if taskData then break end      
    end   
        
    if not taskData then    
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Task not found.")    
        return true    
    end    
        
    local questStatus = player:getStorageValue(taskData.storage.quest)    
    local killCount = math.max(0, player:getStorageValue(taskData.storage.counter))    
        
    -- CASO 1: Task completada (storage = 2) - Mostrar modal con botón Claim Reward    
    if questStatus == 2 then  
        -- Construir mensaje de recompensas  
        local rewardMessage = string.format(  
            "Task: %s\nProgress: %d/%d kills (COMPLETED!)\n\nRewards:\n- Experience: %d\n- Gold: %d",  
            taskData.name,  
            taskData.killsRequired,  
            taskData.killsRequired,  
            taskData.rewards.exp,  
            taskData.rewards.gold  
        )  
          
        -- Agregar items al mensaje si existen  
        if taskData.rewards.items then  
            rewardMessage = rewardMessage .. "\n\nItems:"  
            for _, itemReward in ipairs(taskData.rewards.items) do  
                local itemType = ItemType(itemReward.id)  
                if itemType then  
                    rewardMessage = rewardMessage .. string.format(  
                        "\n- %dx %s",  
                        itemReward.count or 1,  
                        itemType:getName()  
                    )  
                end  
            end  
        end  
          
        local modal = ModalWindow({    
            title = taskData.name .. " Task",    
            message = rewardMessage  
        })    
            
        modal:addButton("Claim Reward", function(player, button, choice)  
            if player:getStorageValue(taskData.storage.quest) ~= 2 then  
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This task is not completed yet.")  
                return  
            end  
            
            -- Entregar recompensas  
            player:addExperience(taskData.rewards.exp, true)  
            player:addMoney(taskData.rewards.gold)  
            
            -- Entregar items directamente al inventario  
            if taskData.rewards.items then  
                for _, itemReward in ipairs(taskData.rewards.items) do  
                    player:addItem(itemReward.id, itemReward.count or 1)  
                end  
            end  
            
            player:setStorageValue(taskData.storage.quest, 3)  
            
            local rewardMsg = string.format(  
                "You have completed the %s task! You received %d experience and %d gold.",  
                taskData.name,  
                taskData.rewards.exp,  
                taskData.rewards.gold  
            )  
            
            if taskData.rewards.items then  
                rewardMsg = rewardMsg .. " Check your inventory for item rewards!"  
            end  
            
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, rewardMsg)  
        end)  
            
        modal:addButton("Cancel")    
        modal:setDefaultEscapeButton("Cancel")    
        modal:sendToPlayer(player)    
        return true    
    end   
        
    -- CASO 2: Task activa (storage = 1) - Mostrar progreso    
    if questStatus == 1 then    
        local modal = ModalWindow({    
            title = taskData.name .. " Task",    
            message = string.format(    
                "Task: %s\nProgress: %d/%d kills\n\nKeep hunting to complete this task!",    
                taskData.name,    
                killCount,    
                taskData.killsRequired    
            )    
        })    
            
        modal:addButton("Close")    
        modal:setDefaultEscapeButton("Close")    
        modal:sendToPlayer(player)    
        return true    
    end    
        
    -- CASO 3: Task no iniciada o recompensa ya reclamada (storage = -1 o 3)    
    if questStatus == 3 then    
        -- Buscar la siguiente tarea disponible en el mismo room    
        local nextTaskName = nil    
        local nextTaskPosition = nil    
          
        for room = 1, #TaskRooms do    
            for _, task in ipairs(TaskRooms[room]) do    
                if task.storage.quest == taskData.storage.quest then    
                    -- Encontramos la tarea actual, buscar la siguiente    
                    local currentIndex = _    
                    if TaskRooms[room][currentIndex + 1] then    
                        local nextTask = TaskRooms[room][currentIndex + 1]    
                        if player:getStorageValue(nextTask.storage.quest) < 2 then    
                            nextTaskName = nextTask.name    
                            nextTaskPosition = nextTask.position    
                            break    
                        end    
                    end    
                end    
            end    
            if nextTaskName then break end    
        end    
          
        local message = "You have already completed this task and claimed your reward."    
        if nextTaskName then    
            message = message .. string.format(    
                "\n\nThe next available task is: %s\nGo to the task island to start it!",    
                nextTaskName    
            )    
        else    
            message = message .. "\n\nYou have completed all available tasks in this sequence!"    
        end    
          
        local modal = ModalWindow({    
            title = "Task Already Completed",    
            message = message    
        })    
          
        modal:addButton("Close")    
        modal:setDefaultEscapeButton("Close")    
        modal:sendToPlayer(player)    
        return true    
    end  
          
    -- Verificar si ya tiene una task activa    
    if player:hasActiveTask() then    
        local modal = ModalWindow({    
            title = "Cannot Start Task",    
            message = "You already have an active task. Complete it or use !task clear to cancel it before starting a new one."    
        })    
            
        modal:addButton("Close")    
        modal:setDefaultEscapeButton("Close")    
        modal:sendToPlayer(player)    
        return true    
    end    
        
    -- Verificar prerequisitos    
    if taskData.prerequisite then    
        local prerequisiteStatus = player:getStorageValue(taskData.prerequisite)    
        if prerequisiteStatus < 2 then    
            -- Encontrar el nombre de la task prerequisito    
            local prerequisiteName = "the previous task"    
            for room = 1, #TaskRooms do    
                for _, task in ipairs(TaskRooms[room]) do    
                    if task.storage.quest == taskData.prerequisite then    
                        prerequisiteName = task.name    
                        break    
                    end    
                end    
            end    
                
            local modal = ModalWindow({    
                title = "For Your information",    
                message = string.format(    
                    "To activate the %s task, you need to complete the %s task first.\n\nPlease complete %s before attempting this task.",    
                    taskData.name,    
                    prerequisiteName,    
                    prerequisiteName    
                )    
            })    
                
            modal:addButton("Close")    
            modal:setDefaultEscapeButton("Close")    
            modal:sendToPlayer(player)    
            return true    
        end    
    end    
        
    -- Si llegamos aquí, puede iniciar la task - Mostrar modal de confirmación  
    -- Construir mensaje con items si existen  
    local acceptMessage = string.format(  
        "Task: %s\nKill %d creatures\n\nRewards:\n- Experience: %d\n- Gold: %d",  
        taskData.name,  
        taskData.killsRequired,  
        taskData.rewards.exp,  
        taskData.rewards.gold  
    )  
      
    if taskData.rewards.items then  
        acceptMessage = acceptMessage .. "\n\nItems:"  
        for _, itemReward in ipairs(taskData.rewards.items) do  
            local itemType = ItemType(itemReward.id)  
            if itemType then  
                acceptMessage = acceptMessage .. string.format(  
                    "\n- %dx %s",  
                    itemReward.count or 1,  
                    itemType:getName()  
                )  
            end  
        end  
    end  
      
    acceptMessage = acceptMessage .. "\n\nDo you want to accept this task?"  
      
    local modal = ModalWindow({    
        title = taskData.name .. " Task",    
        message = acceptMessage  
    })    
        
    modal:addButton("Accept", function(player, button, choice)    
        if player:hasActiveTask() then    
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have an active task.")    
            return    
        end    
            
        if taskData.prerequisite then    
            if player:getStorageValue(taskData.prerequisite) < 2 then    
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to complete the prerequisite task first.")    
                return    
            end    
        end    
            
        if player:startTask(taskData) then  
            -- Construir mensaje de confirmación  
            local confirmMessage = string.format(  
                "You have started the %s task!\n\nObjective: Kill %d creatures\n\nRewards:\n- Experience: %d\n- Gold: %d",  
                taskData.name,  
                taskData.killsRequired,  
                taskData.rewards.exp,  
                taskData.rewards.gold  
            )  
              
            if taskData.rewards.items then  
                confirmMessage = confirmMessage .. "\n\nItems:"  
                for _, itemReward in ipairs(taskData.rewards.items) do  
                    local itemType = ItemType(itemReward.id)  
                    if itemType then  
                        confirmMessage = confirmMessage .. string.format(  
                            "\n- %dx %s",  
                            itemReward.count or 1,  
                            itemType:getName()  
                        )  
                    end  
                end  
            end  
              
            confirmMessage = confirmMessage .. "\n\nGood luck!"  
              
            local confirmModal = ModalWindow({    
                title = "Task Started!",    
                message = confirmMessage  
            })    
              
            confirmModal:addButton("Close")    
            confirmModal:setDefaultEscapeButton("Close")    
            confirmModal:sendToPlayer(player)    
        else    
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Failed to start task.")    
        end    
    end)  
        
    modal:addButton("Cancel")    
    modal:setDefaultEscapeButton("Cancel")    
    modal:sendToPlayer(player)    
        
    return true    
end    
    
-- Registrar todas las posiciones de tasks    
for roomId, tasks in ipairs(TaskRooms) do    
    for _, task in ipairs(tasks) do    
        if task.position then    
            taskAction:position(task.position)    
        end    
    end    
end    

for itemId, _ in pairs(scrollTransformations) do  
    taskAction:id(itemId)  
end

taskAction:register()