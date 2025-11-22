local rewards = {
    { id = 35523, name = "exotic amulet" },
    { id = 35515, name = "throwing axe" },
    { id = 35517, name = "bast legs" },
    { id = 35516, name = "exotic legs" },
    { id = 35518, name = "jungle bow" },
    { id = 35524, name = "jungle quiver" },
    { id = 35514, name = "jungle flail" },
    { id = 35521, name = "jungle rod" },
    { id = 35522, name = "jungle wand" },
    { id = 35519, name = "makeshift boots" },
    { id = 35520, name = "make-do boots" },
    { id = 50186, name = "jungle survivor legs" },
    { id = 50270, name = "bambus jo" }	
}

local ratmiralBag = Action()

function ratmiralBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
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

ratmiralBag:id(60142)
ratmiralBag:register()
