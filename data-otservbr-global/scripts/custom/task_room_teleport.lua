local portalConfig = {  
    -- Portal Easy - Entrada libre  
    {  
        name = "Easy",  
        position = Position(32158, 32301, 4),  
        destination = Position(952, 1042, 5), 
        requiredStorage = nil,
    },  
    -- Portal Medium - Requiere cofre easy  
    {  
        name = "Medium",  
        position = Position(32158, 32298, 4),  
        destination = Position(897, 1042, 5), 
        requiredStorage = 68024,
    },  
    -- Portal Hard - Requiere cofre medium  
    {  
        name = "Hard",  
        position = Position(32160, 32295, 4),  
        destination = Position(914, 992, 5),
        requiredStorage = 68049,
    },  
    -- Portal Challenge - Requiere cofre hard  
    {  
        name = "Challenge",  
        position = Position(32163, 32295, 4),  
        destination = Position(912, 943, 5),
        requiredStorage = 68074,
    }  
}  
  
local taskRoomsPortals = MoveEvent()  
  
function taskRoomsPortals.onStepIn(creature, item, position, fromPosition)  
    local player = creature:getPlayer()  
    if not player then  
        return true  
    end  
      
    -- Buscar qué portal corresponde a esta posición  
    local portalData = nil  
      
    for _, portal in ipairs(portalConfig) do  
        if position == portal.position then  
            portalData = portal  
            break  
        end  
    end  
      
    if not portalData then  
        return true  
    end  
      
    -- Si no requiere storage (portal easy), permitir acceso  
    if not portalData.requiredStorage then  
        player:teleportTo(portalData.destination)  
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)  
        return true  
    end  
      
    -- Verificar si abrió el cofre del nivel anterior  
    if player:getStorageValue(portalData.requiredStorage) < 1 then  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE,   
            "You need to open the previous chest before accessing the " .. portalData.name .. " room.")  
        player:teleportTo(fromPosition, true)  
        player:getPosition():sendMagicEffect(CONST_ME_POFF)  
        return true  
    end  
      
    -- Permitir acceso  
    player:teleportTo(portalData.destination)  
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)  
      
    return true  
end  
  
-- Registrar todas las posiciones de portales  
for _, portal in ipairs(portalConfig) do  
    taskRoomsPortals:position(portal.position)  
end  
  
taskRoomsPortals:register()