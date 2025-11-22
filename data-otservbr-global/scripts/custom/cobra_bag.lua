local rewards = {
    { id = 30396, name = "cobra axe" },
    { id = 50167, name = "cobra bo" },
    { id = 30394, name = "cobra boots" },
    { id = 30395, name = "cobra club" },
    { id = 30393, name = "cobra crosbow" },
    { id = 30397, name = "cobra hood" },
    { id = 30400, name = "cobra rod" },
    { id = 30398, name = "cobra sword" },
    { id = 30399, name = "cobra wand" },
    { id = 31631, name = "the cobra amulet" }
}

local cobraBag = Action()

function cobraBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
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

cobraBag:id(60143)
cobraBag:register()
