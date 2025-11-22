local ADMIN_COLOR_STORAGE = 50000  
  
local ADMIN_COLORS = {  
    [1] = "#ff0000",  -- red  
    [2] = "#0000ff",  -- blue  
    [3] = "#00ff00",  -- green  
    [4] = "#ffff00",  -- yellow  
    [5] = "#ff8800",  -- orange  
    [6] = "#ff00ff",  -- purple  
    [7] = "#00ffff",  -- cyan  
    [8] = "#ff69b4",  -- pink  
    [9] = "#ffffff",  -- white  
    [10] = "#ffd700",  -- gold  
    [11] = "#6A7282",   -- gray 
    [12] = "#193268ff"  -- dark blue 
} 
  
local creatureevent = CreatureEvent("adminColorNameLogin")  
  
function creatureevent.onLogin(player)  
    if player:getGroup():getAccess() then  
        local colorId = player:getStorageValue(ADMIN_COLOR_STORAGE)  
        local colorCode = "#ff0000" -- Color por defecto (rojo)  
          
        if colorId > 0 and ADMIN_COLORS[colorId] then  
            colorCode = ADMIN_COLORS[colorId]  
        end  
          
        player:setDisplayName(string.format('<font color="%s">%s</font>', colorCode, player:getName()))  
    end  
      
    return true  
end  
  
creatureevent:register()