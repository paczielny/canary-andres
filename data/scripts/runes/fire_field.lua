function onCreateFireField(creature, position)  
	local tile = Tile(position)  
	if not tile then  
		return false  
	end  
  
	local item = Game.createItem(ITEM_FIREFIELD_PVP_FULL, 1)  
	if item then  
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Casted by: %s", creature:getName()))  
		item:setOwner(creature)  
		  
		tile:addItemEx(item)  
        item:decay() 
	end  
	return true  
end  
  
local combat = Combat()  
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)  
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)  
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateFireField")  
  
local rune = Spell("rune")  
  
function rune.onCastSpell(creature, var, isHotkey)  
	return combat:execute(creature, var)  
end  
  
rune:id(28)  
rune:group("attack")  
rune:name("fire field rune")  
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)  
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIRE_FIELD_RUNE)  
rune:runeId(3188)  
rune:allowFarUse(true)  
rune:setPzLocked(true)  
rune:charges(3)  
rune:level(15)  
rune:magicLevel(1)  
rune:cooldown(2 * 1000)  
rune:groupCooldown(2 * 1000)  
rune:isBlocking(true)  
rune:register()