local rewards = {
    { id = 28486, name = "lemon cupcake" },
    { id = 28484, name = "blueberry cupcake" },
    { id = 28485, name = "strawberry cupcake" },
    { id = 9079, name = "rotworm stew" },
    { id = 9086, name = "blessed steak" },
    { id = 9080, name = "hydra tongue salad" }
}

local hotdog = Action()

function hotdog.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received a ' .. rewardItem.name .. '.')
	return true
end

hotdog:id(60105)
hotdog:register()
