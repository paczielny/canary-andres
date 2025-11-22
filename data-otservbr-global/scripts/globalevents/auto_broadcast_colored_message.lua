local AutoBroadCast = GlobalEvent("texto")  
local interval = 5 -- Minutes   

local currentMessageIndex = 1  
  

function Player:sendColoredMessage(message)  
    local grey = 3003  
    local blue = 3043  
    local green = 3415  
    local purple = 36792  
    local yellow = 34021  
  
    local msg = message:gsub("{grey|", "{" .. grey .. "|")  
                       :gsub("{blue|", "{" .. blue .. "|")  
                       :gsub("{green|", "{" .. green .. "|")  
                       :gsub("{purple|", "{" .. purple .. "|")  
                       :gsub("{yellow|", "{" .. yellow .. "|")  
    return self:sendTextMessage(MESSAGE_LOOT, msg)  
end  
  
function AutoBroadCast.onThink(interval, lastExecution)  
    local players = Game.getPlayers()  
    if not players or #players == 0 then  
        return true  
    end  
  
    local messages = {  
        "{purple|[REWARD]}: digite !reward para receber seu reward diario",  
        "{blue|[DISCORD]}: Nao se esqueca de conferir os eventos ativos em nosso discord, voce pode ganhar otimos premios",  
        "{green|[SEGURANCA]}: Nunca Utilize o mesmo e email e senha de outros OTS",  
        "{yellow|[VIP]}: torne-se vip e receba bonus adicionais, alem de ganhar uma nova montaria",  
        "{blue|[COMANDOS]}: digite !commands para ver a lista de comandos",  
        "{yellow|[FLASK SYSTEM]}: Utilize o comando !vials on/off para manter ou remover os vials!"  
    }  

    for _, player in ipairs(players) do  
        player:sendColoredMessage(messages[currentMessageIndex])  
    end  

    currentMessageIndex = currentMessageIndex + 1  
    if currentMessageIndex > #messages then  
        currentMessageIndex = 1  
    end  
      
    return true  
end  

AutoBroadCast:interval(interval * 60 * 1000)  
AutoBroadCast:register()