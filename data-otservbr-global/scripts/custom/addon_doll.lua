local outfits = {  
    dollID = 60110,  
    mainTitle = "Choose an outfit",  
    mainMsg = "You will receive both addons as well as the outfit you choose.",  
    ownedTitle = "Whoops!",  
    ownedMsg = "You already have this outfit. Please choose another.",  
    dollTitle = "Whoops!",  
    dollMsg = "The addon doll must be in your backpack.",  
      
    [1] = {name = "Citizen", male = 128, female = 136},  
    [2] = {name = "Hunter", male = 129, female = 137},  
    [3] = {name = "Knight", male = 131, female = 139},  
    [4] = {name = "Noble", male = 132, female = 140},  
    [5] = {name = "Summoner Male - Mage Female", male = 133, female = 138},  
    [6] = {name = "Warrior", male = 134, female = 142},  
    [7] = {name = "Barbarian", male = 143, female = 147},  
    [8] = {name = "Druid", male = 144, female = 148},  
    [9] = {name = "Wizard", male = 145, female = 149},  
    [10] = {name = "Oriental", male = 146, female = 150},  
    [11] = {name = "Pirate", male = 151, female = 155},  
    [12] = {name = "Assassin", male = 152, female = 156},  
    [13] = {name = "Beggar", male = 153, female = 157},  
    [14] = {name = "Shaman", male = 154, female = 158},  
    [15] = {name = "Norse", male = 251, female = 252},  
    [16] = {name = "Nightmare", male = 268, female = 269},  
    [17] = {name = "Jester", male = 273, female = 270},  
    [18] = {name = "Brotherhood", male = 278, female = 279},  
    [19] = {name = "Demonhunter", male = 289, female = 288},  
    [20] = {name = "Yalaharian", male = 325, female = 324},  
    [21] = {name = "Warmaster", male = 335, female = 336},  
    [22] = {name = "Wayfarer", male = 367, female = 366},  
    [23] = {name = "Afflicted", male = 430, female = 431},  
    [24] = {name = "Elementalist", male = 432, female = 433},  
    [25] = {name = "Deepling", male = 463, female = 464},  
    [26] = {name = "Insectoid", male = 465, female = 466},  
    [27] = {name = "Entrepreneur", male = 472, female = 471},  
    [28] = {name = "Crystal Warlord", male = 512, female = 513},  
    [29] = {name = "Soil Guardian", male = 516, female = 514},  
    [30] = {name = "Demon", male = 541, female = 542},  
    [31] = {name = "Cave Explorer", male = 574, female = 575},  
    [32] = {name = "Dream Warden", male = 577, female = 578},  
    [33] = {name = "Recruiter", male = 746, female = 745},  
    [34] = {name = "Battle Mage", male = 1069, female = 1070},  
    [35] = {name = "Makeshift Warrior", male = 1042, female = 1043},  
    [36] = {name = "Festive", male = 931, female = 929},  
    [37] = {name = "Glooth Engineer", male = 610, female = 618},  
    [38] = {name = "Percht Raider", male = 1161, female = 1162},  
    [39] = {name = "Rift Warrior", male = 846, female = 845},  
    [40] = {name = "Orcsoberfest Garb", male = 1251, female = 1252},  
    [41] = {name = "Formal Dress", male = 1460, female = 1461},  
}  
  
function Player:sendAddonWindow(outfits)  
    local choiceToOutfitMap = {}  
      
    -- El callback DEBE recibir (player, button, choice) en ese orden  
    local function buttonCallback(player, button, choice)  
        if button.name == "Confirm" then  
            local outfitIndex = choiceToOutfitMap[choice.id]  
            if not outfitIndex then  
                return false  
            end  
              
            local outfit = outfits[outfitIndex]  
            if not outfit then  
                return false  
            end  
              
            local lookType = player:getSex() == PLAYERSEX_FEMALE and outfit.female or outfit.male  
              
            if player:hasOutfit(lookType, 3) then  
                player:sendAddonWindow_owned(outfits)  
                return false  
            end  
              
            if player:getItemCount(outfits.dollID) == 0 then  
                player:sendAddonWindow_noDoll(outfits)  
                return false  
            end  
              
            player:addOutfitAddon(lookType, 3)  
            player:removeItem(outfits.dollID, 1)  
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can now wear the " .. outfit.name .. " outfit and addons!")  
        end  
    end  
      
    local window = ModalWindow({  
        title = outfits.mainTitle,  
        message = outfits.mainMsg,  
    })  
      
    window:addButton("Confirm", buttonCallback)  
    window:addButton("Cancel")  
    window:setDefaultEnterButton("Confirm")  
    window:setDefaultEscapeButton("Cancel")  
      
    local choiceIndex = 1  
    for i = 1, #outfits do  
        local outfit = outfits[i]  
        local lookType = self:getSex() == PLAYERSEX_FEMALE and outfit.female or outfit.male  
        local o = outfit.name  
          
        if o == "Noble" or o == "Norse" then  
            if self:getSex() == PLAYERSEX_FEMALE then  
                o = o .. "woman"  
            else  
                o = o .. "man"  
            end  
        end  
          
        if not self:hasOutfit(lookType, 3) then  
            window:addChoice(o)  
            choiceToOutfitMap[choiceIndex] = i  
            choiceIndex = choiceIndex + 1  
        else  
            window:addChoice(o .. " [Owned]")  
            choiceToOutfitMap[choiceIndex] = i  
            choiceIndex = choiceIndex + 1  
        end  
    end  
      
    window:sendToPlayer(self)  
end  
  
function Player:sendAddonWindow_owned(outfits)  
    local function buttonCallback(player, button, choice)  
        if button.name == "Back" then  
            player:sendAddonWindow(outfits)  
        end  
    end  
      
    local window = ModalWindow({  
        title = outfits.ownedTitle,  
        message = outfits.ownedMsg,  
    })  
      
    window:addButton("Back", buttonCallback)  
    window:setDefaultEnterButton("Back")  
    window:setDefaultEscapeButton("Back")  
      
    window:sendToPlayer(self)  
end  
  
function Player:sendAddonWindow_noDoll(outfits)  
    local function buttonCallback(player, button, choice)  
        if button.name == "Back" then  
            player:sendAddonWindow(outfits)  
        end  
    end  
      
    local window = ModalWindow({  
        title = outfits.dollTitle,  
        message = outfits.dollMsg,  
    })  
      
    window:addButton("Back", buttonCallback)  
    window:setDefaultEnterButton("Back")  
    window:setDefaultEscapeButton("Back")  
      
    window:sendToPlayer(self)  
end  
  
local addonDoll = Action()  
  
function addonDoll.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
    player:sendAddonWindow(outfits)  
    return true  
end  
  
addonDoll:id(60111)  
addonDoll:register()