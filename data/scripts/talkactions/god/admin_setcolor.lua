local ADMIN_COLOR_STORAGE = 50000  
  
local COLOR_NAMES = {  
    ["red"] = 1,  
    ["blue"] = 2,  
    ["green"] = 3,  
    ["yellow"] = 4,  
    ["orange"] = 5,  
    ["purple"] = 6,  
    ["cyan"] = 7,  
    ["pink"] = 8,  
    ["white"] = 9,  
    ["gold"] = 10, 
    ["gray"] = 11,
    ["darkblue"] = 12
}  

local ADMIN_COLORS = {  
    [1] = "#ff0000",  
    [2] = "#0000ff",  
    [3] = "#034F3B",  
    [4] = "#FFDF20",  
    [5] = "#ff8800",  
    [6] = "#6E11B0",  
    [7] = "#00ffff",  
    [8] = "#ff69b4",  
    [9] = "#ffffff",  
    [10] = "#ffd700",  
    [11] = "#6A7282",  
    [12] = "#193268ff"  
}  
  
local talkaction = TalkAction("/admincolor")  
  
function talkaction.onSay(player, words, param)  
    if not player:getGroup():getAccess() then  
        player:sendCancelMessage("You don't have permission to use this command.")  
        return true  
    end  
      
    if param == "" then  
        local colorList = "Available colors: "  
        for colorName, _ in pairs(COLOR_NAMES) do  
            colorList = colorList .. colorName .. ", "  
        end  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, colorList)  
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Usage: /admincolor <color>")  
        return true  
    end  
      
    local colorName = param:lower()  
      
    if not COLOR_NAMES[colorName] then  
        player:sendCancelMessage("Invalid color. Use /admincolor to see available colors.")  
        return true  
    end  
      
    local colorId = COLOR_NAMES[colorName]  
    player:setStorageValue(ADMIN_COLOR_STORAGE, colorId)  
      
    local colorCode = ADMIN_COLORS[colorId]  
    player:setDisplayName(string.format('<font color="%s">%s</font>', colorCode, player:getName()))  
      
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Your admin name color has been changed to %s!", colorName))  
      
    return true  
end  
  
talkaction:separator(" ")  
talkaction:groupType("god")  
talkaction:register()