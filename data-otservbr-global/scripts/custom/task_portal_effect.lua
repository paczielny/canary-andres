local portalEffects = {  
    -- Portal Easy (entrada libre)  
    {   
        position = Position(32158, 32301, 4),   
        text = "EASY",   
        interval = 5000   
    },  
    -- Portal Medium (requiere cofre easy)  
    {   
        position = Position(32158, 32298, 4),   
        text = "MEDIUM",   
        interval = 5000   
    },  
    -- Portal Hard (requiere cofre medium)  
    {   
        position = Position(32160, 32295, 4),   
        text = "HARD",   
        interval = 5000   
    },  
    -- Portal Challenge (requiere cofre hard)  
    {   
        position = Position(32163, 32295, 4),   
        text = "CHALLENGE",   
        interval = 5000   
    },  
}  
  
local portalEffectsEvent = GlobalEvent("TaskPortalEffects")  
  
function portalEffectsEvent.onThink(interval)  
    local now = os.time() * 1000  
      
    for _, entry in ipairs(portalEffects) do  
        if not entry.lastRun then  
            entry.lastRun = 0  
        end  
          
        local intervalMs = entry.interval or 5000  
        if now - entry.lastRun >= intervalMs then  
            -- Enviar efecto visual  
            if entry.effect and entry.position then  
                entry.position:sendMagicEffect(entry.effect)  
            end  
              
            -- Mostrar texto a jugadores cercanos  
            if entry.text and entry.text ~= "" and entry.position then  
                local spectators = Game.getSpectators(entry.position, true, false, 7, 7, 5, 5)  
                if #spectators > 0 then  
                    for _, spectator in ipairs(spectators) do  
                        spectator:say(entry.text, TALKTYPE_MONSTER_SAY, false, spectator, entry.position)  
                    end  
                end  
            end  
              
            entry.lastRun = now  
        end  
    end  
      
    return true  
end  
  
portalEffectsEvent:interval(1000)  
portalEffectsEvent:register()