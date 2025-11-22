local rewards = {
    { id = 16112, name = "prismatic boots" },
    { id = 16111, name = "prismatic legs" },
    { id = 16110, name = "prismatic armor" },
    { id = 16109, name = "prismatic helmet" },
    { id = 16105, name = "gill coat" },
    { id = 16104, name = "gill gugel" },
    { id = 16106, name = "gill legs" },
    { id = 16114, name = "prismatic ring" },
    { id = 50276, name = "gnomish cuirass" },
    { id = 16107, name = "spellbook of vigilance" }	
}

local primaticBag = Action()

function primaticBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received a ' .. rewardItem.name .. '.')
	return true
end

primaticBag:id(60112)
primaticBag:register()
