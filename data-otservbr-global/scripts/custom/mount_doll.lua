local mounts = {  
    dollID = 60111,  -- ID del item mount doll  
    mainTitle = "Choose a mount",  
    mainMsg = "Select a mount to unlock.",  
    ownedTitle = "Whoops!",  
    ownedMsg = "You already have this mount. Please choose another.",  
    dollTitle = "Whoops!",  
    dollMsg = "The mount doll must be in your backpack.",  
      
    [1] = {name = "Widow Queen", ID = 1},  
    [2] = {name = "Racing Bird", ID = 2},  
    [3] = {name = "War Bear", ID = 3},  
    [4] = {name = "Black Sheep", ID = 4},  
    [5] = {name = "Midnight Panther", ID = 5},  
    [6] = {name = "Draptor", ID = 6},  
    [7] = {name = "Titanica", ID = 7},  
    [8] = {name = "Tin Lizzard", ID = 8},  
    [9] = {name = "Blazebringer", ID = 9},  
    [10] = {name = "Rapid Boar", ID = 10},  
    [11] = {name = "Stampor", ID = 11},  
    [12] = {name = "Undead Cavebear", ID = 12},  
    [13] = {name = "Donkey", ID = 13},  
    [14] = {name = "Tiger Slug", ID = 14},  
    [15] = {name = "Uniwheel", ID = 15},  
    [16] = {name = "Crystal Wolf", ID = 16},  
    [17] = {name = "War Horse", ID = 17},  
    [18] = {name = "Kingly Deer", ID = 18},  
    [19] = {name = "Tamed Panda", ID = 19},  
    [20] = {name = "Dromedary", ID = 20},  
    [21] = {name = "King Scorpion", ID =21},
    [22] = {name = "Armoured War Horse", ID = 23},
    [23] = {name = "Shadow Draptor", ID =24},
    [24] = {name = "Ladybug", ID = 27},
    [25] = {name = "Manta Ray", ID = 28},
    [26] = {name = "Ironblight", ID =29},
    [27] = {name = "Magma Crawler", ID = 30},
    [28] = {name = "Dragonling", ID = 31},
    [29] = {name = "Gnarlhound", ID = 32},
    [30] = {name = "Water Buffalo", ID = 35},
    [31] = {name = "Ursagrodon", ID = 38},
    [32] = {name = "The Hellgrip", ID = 39},
    [33] = {name = "Noble Lion", ID = 40},
    [34] = {name = "Walker", ID = 43},
    [35] = {name = "Glooth Glider", ID = 71},
    [36] = {name = "Sparkion", ID = 94},
    [37] = {name = "Stone Rhino", ID = 106},
    [38] = {name = "Mole", ID = 119},
    [39] = {name = "Lacewing Moth", ID = 130},
    [40] = {name = "Hibernal Moth", ID = 131},
    [41] = {name = "Gryphon", ID = 144},
    [42] = {name = "Cold Percht Sleigh Final", ID = 150},
    [43] = {name = "Bright Percht Sleigh Final", ID = 151},
    [44] = {name = "Dark Percht Sleigh Final", ID = 152},
    [45] = {name = "Blue Rolling Barrel", ID = 156},
    [46] = {name = "Red Rolling Barrel", ID = 157},
    [47] = {name = "Green Rolling Barrel", ID = 158},
    [48] = {name = "White Lion", ID = 174},
    [49] = {name = "Giant Beaver", ID = 201},
    [50] = {name = "Mutated Abomination", ID = 206},
    [51] = {name = "Gloothomotive", ID = 194},
    [52] = {name = "Foxmouse", ID = 216},
	[53] = {name = "Phant", ID = 182},
}  
  
function Player:sendMountWindow(mounts)  
    local choiceToMountMap = {}  
      
    -- El callback DEBE recibir (player, button, choice) en ese orden  
    local function buttonCallback(player, button, choice)  
        if button.name == "Confirm" then  
            local mountIndex = choiceToMountMap[choice.id]  
            if not mountIndex then  
                return false  
            end  
              
            local mount = mounts[mountIndex]  
            if not mount then  
                return false  
            end  
              
            if player:hasMount(mount.ID) then  
                player:sendMountWindow_owned(mounts)  
                return false  
            end  
              
            if player:getItemCount(mounts.dollID) == 0 then  
                player:sendMountWindow_noDoll(mounts)  
                return false  
            end  
              
            player:addMount(mount.ID)  
            player:removeItem(mounts.dollID, 1)  
            player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can now use the " .. mount.name .. " mount!")  
        end  
    end  
      
    local window = ModalWindow({  
        title = mounts.mainTitle,  
        message = mounts.mainMsg,  
    })  
      
    window:addButton("Confirm", buttonCallback)  
    window:addButton("Cancel")  
    window:setDefaultEnterButton("Confirm")  
    window:setDefaultEscapeButton("Cancel")  
      
    local choiceIndex = 1  
    for i = 1, #mounts do  
        local mount = mounts[i]  
          
        if not self:hasMount(mount.ID) then  
            window:addChoice(mount.name)  
            choiceToMountMap[choiceIndex] = i  
            choiceIndex = choiceIndex + 1  
        else  
            window:addChoice(mount.name .. " [Owned]")  
            choiceToMountMap[choiceIndex] = i  
            choiceIndex = choiceIndex + 1  
        end  
    end  
      
    window:sendToPlayer(self)  
end  
  
function Player:sendMountWindow_owned(mounts)  
    local function buttonCallback(player, button, choice)  
        if button.name == "Back" then  
            player:sendMountWindow(mounts)  
        end  
    end  
      
    local window = ModalWindow({  
        title = mounts.ownedTitle,  
        message = mounts.ownedMsg,  
    })  
      
    window:addButton("Back", buttonCallback)  
    window:setDefaultEnterButton("Back")  
    window:setDefaultEscapeButton("Back")  
      
    window:sendToPlayer(self)  
end  
  
function Player:sendMountWindow_noDoll(mounts)  
    local function buttonCallback(player, button, choice)  
        if button.name == "Back" then  
            player:sendMountWindow(mounts)  
        end  
    end  
      
    local window = ModalWindow({  
        title = mounts.dollTitle,  
        message = mounts.dollMsg,  
    })  
      
    window:addButton("Back", buttonCallback)  
    window:setDefaultEnterButton("Back")  
    window:setDefaultEscapeButton("Back")  
      
    window:sendToPlayer(self)  
end  
  
local mountDoll = Action()  
  
function mountDoll.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
    player:sendMountWindow(mounts)  
    return true  
end  
  
mountDoll:id(60110)  
mountDoll:register()