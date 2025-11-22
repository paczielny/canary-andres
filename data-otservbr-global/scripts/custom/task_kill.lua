local taskKill = CreatureEvent("TaskRoomsKill")    
    
function taskKill.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)    
    if not creature or not creature:isMonster() then    
        return true    
    end    
        
    local targetName = creature:getName():lower()    
        
    onDeathForParty(creature, mostDamageKiller, function(creature, player)    
        for roomId = 1, #TaskRooms do    
            for _, task in ipairs(TaskRooms[roomId]) do    
                local questStatus = player:getStorageValue(task.storage.quest)    
                    
                -- Solo procesar si la task está activa (valor 1)    
                if questStatus == 1 then    
                    if table.contains(task.creatures, targetName) then    
                        local currentKills = player:getStorageValue(task.storage.counter)    
                            
                        if currentKills < 0 then    
                            currentKills = 0    
                        end    
                            
                        local newKills = currentKills + 1    
                        player:setStorageValue(task.storage.counter, newKills)    
                            
                        -- CORRECCIÓN: Actualizar storage a 2 cuando se completa  
                        if newKills >= task.killsRequired then    
                            -- Marcar task como completada (storage = 2)  
                            player:setStorageValue(task.storage.quest, 2)  
                              
                            player:sendTextMessage(    
                                MESSAGE_EVENT_ADVANCE,    
                                string.format(    
                                    "[Task System] You have finished the %s task! Return to the quest board to claim your reward.",    
                                    task.name    
                                )    
                            )    
                        else  
                            -- Mostrar progreso  
                            player:sendTextMessage(      
                                MESSAGE_EVENT_ADVANCE,      
                                string.format("Task: %s - [%d/%d]", task.name, newKills, task.killsRequired)      
                            )   
                        end    
                            
                        return true    
                    end    
                end    
            end    
        end    
    end)    
        
    return true    
end    
    
taskKill:register()    
    
local taskKillStartup = GlobalEvent("TaskRoomsKillStartup")    
    
function taskKillStartup.onStartup()    
    local monsters = {}    
        
    for roomId = 1, #TaskRooms do    
        for _, task in ipairs(TaskRooms[roomId]) do    
            for _, creatureName in ipairs(task.creatures) do    
                if not table.contains(monsters, creatureName) then    
                    table.insert(monsters, creatureName)    
                end    
            end    
        end    
    end    
        
    for _, monsterName in ipairs(monsters) do    
        local mType = MonsterType(monsterName)    
        if not mType then    
            logger.error("[TaskRoomsKillStartup] monster with name {} is not a valid MonsterType", monsterName)    
        else    
            mType:registerEvent("TaskRoomsKill")    
        end    
    end    
        
    logger.info("[TaskRoomsKillStartup] Registered TaskRoomsKill event for {} monster types", #monsters)    
end    
    
taskKillStartup:register()