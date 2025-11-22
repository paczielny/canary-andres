local taskDisplaySpawn = GlobalEvent("TaskDisplaySpawn")  
  
function taskDisplaySpawn.onStartup()  
    for roomId, tasks in ipairs(TaskRooms) do  
        for _, task in ipairs(tasks) do  
            if task.displayCreature and task.displayPosition then  
                local creature = Game.createMonster(  
                    task.displayCreature,   
                    task.displayPosition,   
                    false,   
                    true  
                )  
                if creature then  
                    creature:setDirection(task.displayDirection or DIRECTION_SOUTH)  
                    creature:setDirectionLocked(true)  
                    creature:setMoveLocked(true)  
                end  
            end  
        end  
    end  
    return true  
end  
  
taskDisplaySpawn:register()