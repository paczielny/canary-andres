local rewards = {
    { id = 28724, name = "falcon battleaxe" },
    { id = 28718, name = "falcon bow" },
    { id = 28714, name = "falcon circlet" },
    { id = 28715, name = "falcon coif" },
    { id = 28722, name = "falcon escutcheon" },
    { id = 28720, name = "falcon greaves" },
    { id = 28723, name = "falcon longsword" },
    { id = 28725, name = "falcon mace" },
    { id = 28719, name = "falcon plate" },	
    { id = 28716, name = "falcon rod" },
    { id = 50161, name = "falcon sai" },
    { id = 28721, name = "falcon shield" },
    { id = 28717, name = "falcon wand" }
}

local falconBag = Action()

function falconBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
	local randId = math.random(1, #rewards)  
	local rewardItem = rewards[randId]  
  
	if fromPosition.x == CONTAINER_POSITION then  
		fromPosition = player:getPosition()  
	end
  
	player:addItem(rewardItem.id, 1)  
	item:remove(1)  
	  
	fromPosition:sendMagicEffect(75)   
	  
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received a ' .. rewardItem.name .. '.')  
	return true  
end

falconBag:id(60141)
falconBag:register()
