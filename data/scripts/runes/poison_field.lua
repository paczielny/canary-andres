function onCreatePoisonField(creature, position)  
	local tile = Tile(position)  
	if not tile then  
		return false  
	end  
  
	-- Crear el item SIN posición  
	local item = Game.createItem(ITEM_POISONFIELD_PVP, 1)  
	if item then  
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Casted by: %s", creature:getName()))  
		item:setOwner(creature)  
		  
		tile:addItemEx(item)  
        item:decay() 
	end  
	return true  
end  
  
local combat = Combat()  
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)  
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)  
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreatePoisonField")  
  
local rune = Spell("rune")  
  
function rune.onCastSpell(creature, var, isHotkey)  
	return combat:execute(creature, var)  
end  
  
rune:id(19)  
rune:group("attack")  
rune:name("poison field rune")  
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)  
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_POISON_FIELD_RUNE)  
rune:runeId(3172)  
rune:allowFarUse(true)  
rune:setPzLocked(true)  
rune:charges(3)  
rune:level(14)  
rune:magicLevel(0)  
rune:cooldown(2 * 1000)  
rune:groupCooldown(2 * 1000)  
rune:isBlocking(true)  
rune:register()