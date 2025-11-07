function onCreateEnergyWall(creature, position)  
	local tile = Tile(position)  
	if not tile then  
		return false  
	end  
  
	local item = Game.createItem(ITEM_ENERGYFIELD_PVP, 1)  
	if item then  
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Casted by: %s", creature:getName()))  
		item:setOwner(creature)  
		  
		tile:addItemEx(item)  
        item:decay() 
	end  
	return true  
end  
  
local combat = Combat()  
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)  
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)  
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)  
combat:setArea(createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD))  
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateEnergyWall")  
  
local rune = Spell("rune")  
  
function rune.onCastSpell(creature, var, isHotkey)  
	return combat:execute(creature, var)  
end  
  
rune:id(85)  
rune:group("attack")  
rune:name("energy wall rune")  
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)  
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ENERGY_WALL_RUNE)  
rune:runeId(3166)  
rune:allowFarUse(true)  
rune:setPzLocked(true)  
rune:charges(4)  
rune:level(41)  
rune:magicLevel(9)  
rune:cooldown(2 * 1000)  
rune:groupCooldown(2 * 1000)  
rune:isBlocking(false)  
rune:register()