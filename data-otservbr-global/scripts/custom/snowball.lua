local SnowBallEvent = {    
    started = false,    
    enqueued = false,    
    players = {},    
    lobby = {},    
    maxAmmo = 5,    
    increaseAmmoAfterSeconds = 2,    
        
    storages = {    
        Kill = 35709,    
        Death = 35710    
    },    
        
    winners = {    
        [1] = { item = {60094, 3} },    
        [2] = { item = {60094, 2} },    
        [3] = { item = {60094, 1} }    
    },    
        
    map = {    
        arena = Position(1052, 1047, 7),    
        arenaRange = { x = 21, y = 21 },    
        lobby = Position(1052, 1047, 6),    
        lobbyRange = { x = 3, y = 3 },    
        exitTo = Position(32360, 31782, 7)    
    },    
        
    teleport = {    
        position = Position(32373, 32239, 7)    
    },    
        
    schedule = {    
        startDelay = 2,    
        duration = 2    
    },  
  
    eventSpeed = 200,   
    playerOriginalSpeeds = {},  
}  
  
-- Funciones auxiliares (sin cambios)  
local function getFreeRandomPosition(centerPos, range)    
    for i = 1, 50 do    
        local randomPos = Position(    
            centerPos.x + math.random(-range, range),    
            centerPos.y + math.random(-range, range),    
            centerPos.z    
        )    
        local tile = Tile(randomPos)    
        if tile and tile:isWalkable(true, false, true, true, true) then    
            return randomPos    
        end    
    end    
    return centerPos    
end    
  
local function getPlayersInArea(pos, rangeX, rangeY)    
    local players = {}    
    for _, player in ipairs(Game.getSpectators(pos, false, true, rangeX, rangeX, rangeY, rangeY)) do    
        if player:isPlayer() then    
            table.insert(players, player)    
        end    
    end    
    return players    
end    
  
local function isPlayerInArea(playerId, pos, rangeX, rangeY)    
    for _, player in ipairs(getPlayersInArea(pos, rangeX, rangeY)) do    
        if player:getId() == playerId then    
            return true    
        end    
    end    
    return false    
end    
  
local function updatePlayerScore(killer, victim)    
    if not SnowBallEvent.lobby[killer:getId()] then    
        SnowBallEvent.lobby[killer:getId()] = {    
            id = killer:getId(),    
            name = killer:getName(),    
            kill = 0,    
            death = 0    
        }    
    end    
        
    if not SnowBallEvent.lobby[victim:getId()] then    
        SnowBallEvent.lobby[victim:getId()] = {    
            id = victim:getId(),    
            name = victim:getName(),    
            kill = 0,    
            death = 0    
        }    
    end    
        
    SnowBallEvent.lobby[killer:getId()].kill = SnowBallEvent.lobby[killer:getId()].kill + 1    
    SnowBallEvent.lobby[victim:getId()].death = SnowBallEvent.lobby[victim:getId()].death + 1    
        
    for _, data in pairs(SnowBallEvent.lobby) do    
        local player = Player(data.id)    
        if player then    
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE,     
                string.format('[Snow Ball] %s fue eliminado por %s!', victim:getName(), killer:getName()))    
        end    
    end    
        
    local kills = killer:getStorageValue(SnowBallEvent.storages.Kill)    
    killer:setStorageValue(SnowBallEvent.storages.Kill, math.max(0, kills) + 1)    
        
    local deaths = victim:getStorageValue(SnowBallEvent.storages.Death)    
    victim:setStorageValue(SnowBallEvent.storages.Death, math.max(0, deaths) + 1)    
end    
  
local function showRanking(player, eventResults)    
    if eventResults then    
        local score = SnowBallEvent.lobby[player:getId()]    
        if score then    
            player:popupFYI(string.format("Tu puntuacion: %d kills\n\nGanadores:\n%s", score.kill, eventResults))    
        end    
        return    
    end    
        
    local query = string.format([[    
        SELECT `players`.`name`, `value`     
        FROM `player_storage`     
        INNER JOIN `players` ON `player_storage`.`player_id` = `players`.`id`     
        WHERE `key` = %d     
        ORDER BY `value` DESC     
        LIMIT 10    
    ]], SnowBallEvent.storages.Kill)    
        
    local resultId = db.storeQuery(query)    
    if resultId then    
        local text = "Ranking SnowBall:\n"    
        local pos = 1    
        repeat    
            text = text .. string.format("%d. %s (%d kills)\n",     
                pos, result.getString(resultId, "name"), result.getNumber(resultId, "value"))    
            pos = pos + 1    
        until not result.next(resultId)    
        result.free(resultId)    
        player:popupFYI(text)    
    else    
        player:sendCancelMessage("No hay ranking disponible.")    
    end    
end    
  
local function calculateWinners()    
    local rankings = {}    
    for _, data in pairs(SnowBallEvent.lobby) do    
        table.insert(rankings, data)    
    end    
    table.sort(rankings, function(a, b) return a.kill > b.kill end)    
        
    local text = ""    
    local winners = {}    
    for i = 1, math.min(3, #rankings) do    
        text = text .. string.format("%d. %s (%d kills)\n", i, rankings[i].name, rankings[i].kill)    
        table.insert(winners, rankings[i])    
    end    
    return text, winners    
end    
  
local function rewardWinners(winners)    
    for pos, data in ipairs(winners) do    
        if pos <= 3 then    
            local player = Player(data.id)    
            if player and SnowBallEvent.winners[pos] then    
                local reward = SnowBallEvent.winners[pos].item    
                player:addItem(reward[1], reward[2])    
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE,     
                    string.format("Felicidades! Quedaste en #%d lugar", pos))    
            end    
        end    
    end    
end    
  
function increaseAmmoEvent()    
    if not SnowBallEvent.started then    
        return    
    end    
        
    for _, player in ipairs(getPlayersInArea(SnowBallEvent.map.arena,     
        SnowBallEvent.map.arenaRange.x, SnowBallEvent.map.arenaRange.y)) do    
        local pid = player:getId()    
        if not SnowBallEvent.players[pid] then    
            SnowBallEvent.players[pid] = SnowBallEvent.maxAmmo    
        elseif SnowBallEvent.players[pid] < SnowBallEvent.maxAmmo then    
            SnowBallEvent.players[pid] = SnowBallEvent.players[pid] + 1    
            player:sendCancelMessage('Bolas de nieve: ' .. SnowBallEvent.players[pid])  
        end    
    end    
        
    addEvent(increaseAmmoEvent, SnowBallEvent.increaseAmmoAfterSeconds * 1000)    
end    
  
local function setEventSpeed(player)  
    local pid = player:getId()  
      
    -- Guardar velocidad actual  
    SnowBallEvent.playerOriginalSpeeds[pid] = player:getSpeed()  
      
    -- Calcular delta necesario  
    local currentSpeed = player:getSpeed()  
    local targetSpeed = SnowBallEvent.eventSpeed  
    local speedDelta = targetSpeed - currentSpeed  
      
    -- CORREGIDO: Usar método de creature en lugar de Game  
    player:changeSpeed(speedDelta)  
end  
  
-- Función para restaurar velocidad original  
local function restoreOriginalSpeed(player)  
    local pid = player:getId()  
      
    if SnowBallEvent.playerOriginalSpeeds[pid] then  
        local currentSpeed = player:getSpeed()  
        local originalSpeed = SnowBallEvent.playerOriginalSpeeds[pid]  
        local speedDelta = originalSpeed - currentSpeed  
          
        -- CORREGIDO: Usar método de creature  
        player:changeSpeed(speedDelta)  
        SnowBallEvent.playerOriginalSpeeds[pid] = nil  
    end  
end
  
local function startEvent()    
    SnowBallEvent.enqueued = true    
        
    local teleport = Game.createItem(1949, 1, SnowBallEvent.teleport.position)    
    if teleport and teleport:isTeleport() then    
        teleport:setDestination(SnowBallEvent.map.lobby)    
    end    
        
    Game.broadcastMessage(string.format('SnowBall Event comenzara en %d minutos! Se creo un portal en el depot de Thais',       
        SnowBallEvent.schedule.startDelay), MESSAGE_STATUS_WARNING)     
        
    addEvent(function()    
        Game.broadcastMessage('SnowBall Event ha comenzado!', MESSAGE_STATUS_WARNING)    
        SnowBallEvent.lobby = {}    
        SnowBallEvent.started = true    
            
        for i, player in ipairs(getPlayersInArea(SnowBallEvent.map.lobby,     
            SnowBallEvent.map.lobbyRange.x, SnowBallEvent.map.lobbyRange.y)) do    
            addEvent(function()    
                if player then    
                    -- CORREGIDO: Usar la nueva función  
                    setEventSpeed(player)  
                      
                    player:teleportTo(getFreeRandomPosition(SnowBallEvent.map.arena, 10))    
                end    
            end, i * 100)    
        end   
            
        addEvent(increaseAmmoEvent, SnowBallEvent.increaseAmmoAfterSeconds * 1000)    
            
        addEvent(function()    
            SnowBallEvent.started = false    
            SnowBallEvent.enqueued = false    
                
            local tile = Tile(SnowBallEvent.teleport.position)    
            if tile then    
                local teleport = tile:getItemById(1949)    
                if teleport then    
                    teleport:remove()    
                end    
            end    
              
            local text, winners = calculateWinners()    
            rewardWinners(winners)     
                
            for i, player in ipairs(getPlayersInArea(SnowBallEvent.map.arena,     
                SnowBallEvent.map.arenaRange.x, SnowBallEvent.map.arenaRange.y)) do    
                addEvent(function()    
                    if player then    
                        -- CORREGIDO: Usar la nueva función  
                        restoreOriginalSpeed(player)  
                          
                        player:teleportTo(SnowBallEvent.map.exitTo)    
                        showRanking(player, text)    
                    end    
                end, i * 100)    
            end   
                
            Game.broadcastMessage('SnowBall Event finalizado!', MESSAGE_STATUS_WARNING)    
        end, SnowBallEvent.schedule.duration * 60 * 1000)    
            
    end, SnowBallEvent.schedule.startDelay * 60 * 1000)    
end    
  
local snowball = TalkAction("!snowball")    
function snowball.onSay(player, words, param)    
    if param == 'start' then    
        if player:getGroup():getAccess() and player:getAccountType() >= ACCOUNT_TYPE_GOD then    
            startEvent()    
        end    
        return false    
    end    
        
    if param == 'rank' then    
        showRanking(player)    
        return false    
    end    
        
    if not SnowBallEvent.started then    
        player:sendCancelMessage('El evento no esta activo.')    
        return false    
    end    
        
    if not isPlayerInArea(player:getId(), SnowBallEvent.map.arena,     
        SnowBallEvent.map.arenaRange.x, SnowBallEvent.map.arenaRange.y) then    
        return false    
    end    
        
    local pid = player:getId()    
    if not SnowBallEvent.players[pid] or SnowBallEvent.players[pid] <= 0 then    
        player:getPosition():sendMagicEffect(CONST_ME_POFF)    
        player:sendCancelMessage('No tienes bolas de nieve!')    
        return false    
    end    
        
    local startPos = player:getPosition()    
    local targetPos = Position(startPos.x, startPos.y, startPos.z)    
        
    for dist = 1, 7 do    
        targetPos:getNextPosition(player:getDirection())    
        local tile = Tile(targetPos)    
            
        if not tile or not tile:isWalkable(true, false, true, true, true) then    
            break    
        end    
            
        addEvent(function()    
            local checkTile = Tile(Position(targetPos.x, targetPos.y, targetPos.z))    
            if checkTile and checkTile:getCreatureCount() > 0 then    
                local target = checkTile:getCreatures()[1]  
                if target and target:isPlayer() and target ~= player then    
                    targetPos:sendMagicEffect(CONST_ME_POFF)    
                    -- Game.sendAnimatedText('DEAD', targetPos, TEXTCOLOR_RED) -- Comentado porque no existe  
                    target:teleportTo(getFreeRandomPosition(SnowBallEvent.map.arena, 10))    
                    updatePlayerScore(player, target)    
                end    
            end    
        end, 60 * dist)    
            
        if tile:getCreatureCount() > 0 then    
            break    
        end    
    end    
        
    startPos:sendDistanceEffect(targetPos, CONST_ANI_SNOWBALL)    
    SnowBallEvent.players[pid] = SnowBallEvent.players[pid] - 1    
    player:sendCancelMessage('Bolas de nieve: ' .. SnowBallEvent.players[pid])  
        
    return false    
end    
    
snowball:separator(" ")    
snowball:groupType("normal")   
snowball:register()    
    
-- Comando admin rápido    
local quickStart = TalkAction("/sb")    
function quickStart.onSay(player, words, param)    
    if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then    
        return true    
    end    
        
    if not SnowBallEvent.started then    
        startEvent()    
    end    
    return false    
end    
quickStart:groupType("god")  
quickStart:register()    
    
-- MoveEvent para el teleport    
local teleportMove = MoveEvent()    
function teleportMove.onStepIn(creature, item, position, fromPosition)    
    if not creature:isPlayer() then    
        creature:teleportTo(fromPosition)    
        return true    
    end    
        
    if SnowBallEvent.started or not SnowBallEvent.enqueued then    
        creature:teleportTo(fromPosition)    
        return true    
    end    
        
    creature:teleportTo(SnowBallEvent.map.lobby)    
    creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Bienvenido! Espera a que comience el evento.')    
    return true    
end    
    
teleportMove:position(SnowBallEvent.teleport.position)    
teleportMove:register()
  