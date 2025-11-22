local rewards = {
    { id = 34158, name = "lion amulet" },
    { id = 34253, name = "lion axe" },
    { id = 50162, name = "lion claws" },
    { id = 34254, name = "lion hammer" },
    { id = 34150, name = "lion longbow" },
    { id = 34155, name = "lion longsword" },
    { id = 34157, name = "lion plate" },
    { id = 34151, name = "lion rod" },
    { id = 34156, name = "lion spangenhelm" },
    { id = 34154, name = "lion shield" },
    { id = 34153, name = "lion spellbook" },
    { id = 34152, name = "lion wand" }
}

local lionBag = Action()

function lionBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
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

lionBag:id(60140)
lionBag:register()
