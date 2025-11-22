local rewards = {
    { id = 14000, name = "ornate shield" },
    { id = 13993, name = "ornate chestplate" },
    { id = 13999, name = "ornate legs" },
    { id = 13995, name = "depth galea" },
    { id = 13997, name = "depth calcei" },
    { id = 13994, name = "depth lorica" }
}

local ornateBag = Action()

function ornateBag.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local randId = math.random(1, #rewards)
	local rewardItem = rewards[randId]

	player:addItem(rewardItem.id, 1)
	item:remove(1)

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received a ' .. rewardItem.name .. '.')
	return true
end

ornateBag:id(60113)
ornateBag:register()
