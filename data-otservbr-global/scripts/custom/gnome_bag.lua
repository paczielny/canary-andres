local rewards = {
    { id = 27648, name = "gnome armor" },
    { id = 27647, name = "gnome helmet" },
    { id = 27649, name = "gnome legs" },
    { id = 27650, name = "gnome shield" },
    { id = 27651, name = "gnome sword" },
    { id = 50290, name = "gnomish footwraps" }
}

local gnomeBag = Action()

function gnomeBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)  
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

gnomeBag:id(60139)
gnomeBag:register()
