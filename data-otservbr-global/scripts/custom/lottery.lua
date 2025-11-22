local lotteryItem = Action()  
  
function lotteryItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)  

	local amount = math.random(50, 100)  

	player:addItem(3043, amount)

	if fromPosition.x == CONTAINER_POSITION then  
		fromPosition = player:getPosition()  
	end  

	fromPosition:sendMagicEffect(CONST_ME_FIREWORK_YELLOW)  

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Your price of lottery is ' .. amount .. ' crystal coins.')  

	item:remove(1)  
	  
	return true  
end  
  
lotteryItem:id(60106)  
lotteryItem:register()