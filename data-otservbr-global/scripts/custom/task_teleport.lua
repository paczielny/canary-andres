local roomTeleports = {  
    -- Teleport del Cuarto 1 al Cuarto 2  
    {  
        fromPosition = Position(1032, 1029, 8),  -- Posición del teleport en cuarto 1  
        toPosition = Position(1032, 1029, 9),    -- Destino en cuarto 2  
        requiredRoom = 1,                           -- Cuarto que debe estar completo  
        deniedMessage = "You haven't finished the previous room yet."  
    },  
    -- Teleport del Cuarto 2 al Cuarto 3  
    {  
        fromPosition = Position(1042, 1029, 8),  
        toPosition = Position(1044, 1030, 9),  
        requiredRoom = 2,  
        deniedMessage = "You haven't finished the previous room yet."  
    },  
    -- Teleport del Cuarto 3 al Cuarto 4  
    {  
        fromPosition = Position(1032, 1035, 8),  
        toPosition = Position(1033, 1035, 9),  
        requiredRoom = 3,  
        deniedMessage = "You haven't finished the previous room yet."  
    },  
}  
  
local taskRoomTeleport = MoveEvent()  
  
function taskRoomTeleport.onStepIn(creature, item, position, fromPosition)  
    local player = creature:getPlayer()  
    if not player then  
        return true  
    end  
      
    -- Buscar el teleport correspondiente a esta posición  
    local teleportConfig = nil  
    for _, config in ipairs(roomTeleports) do  
        if position == config.fromPosition then  
            teleportConfig = config  
            break  
        end  
    end  
      
    if not teleportConfig then  
        return true  
    end  
      
    -- Verificar si el jugador ha completado todas las tasks del cuarto requerido  
    local roomCompleted = player:hasCompletedRoom(teleportConfig.requiredRoom)  
      
    if roomCompleted then  
        -- Permitir el paso  
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)  
        player:teleportTo(teleportConfig.toPosition)  
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)  
    else  
        -- Denegar el paso  
        player:teleportTo(fromPosition)  
        player:getPosition():sendMagicEffect(CONST_ME_POFF)  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, teleportConfig.deniedMessage)  
    end  
      
    return true  
end  
  
-- Registrar todas las posiciones de teleport  
for _, config in ipairs(roomTeleports) do  
    taskRoomTeleport:position(config.fromPosition)  
end  
  
taskRoomTeleport:type("stepin")  
taskRoomTeleport:register()