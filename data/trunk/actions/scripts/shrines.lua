local HOTA_WEAK = 2342
local HOTA_FULL = 2343

local SHRINES = {

	-- Fire Shrine
	[SMALL_RUBY]	= {7504, 7505, 7506, 7507},

	-- Ice Shrine
	[SMALL_SAPPHIRE]= {7508, 7509, 7510, 7511},

	-- Energy Shrine
	[SMALL_AMETHYST]= {7512, 7513, 7514, 7515},

	-- Earth Shrine
	[SMALL_EMERALD]	= {7516, 7517, 7518, 7519}
}

local ENCHANTED_GEMS = {
	[SMALL_SAPPHIRE]= ENCHANTED_SMALL_SAPPHIRE,
	[SMALL_RUBY]	= ENCHANTED_SMALL_RUBY,
	[SMALL_EMERALD]	= ENCHANTED_SMALL_EMERALD,
	[SMALL_AMETHYST]= ENCHANTED_SMALL_AMETHYST
}

function onUse(cid, item, frompos, item2, topos)

	if(item2.itemid == HOTA_WEAK) then
		doRemoveItem(item.uid, 1)
		doTransformItem(item2.uid, HOTA_FULL)
		doSendMagicEffect(topos, CONST_ME_MAGIC_RED)
		return TRUE
	end

	if (isInArray(SHRINES[item.itemid], item2.itemid) == FALSE) then
		return FALSE
	end

	local count = item.type
	
	if (count == 0) then
		count = 1
	end

	local manaCost = 300 * count
	local soulCost = 2 * count

	local requiredLevel = 30

	if (getPlayerLevel(cid) < requiredLevel) then
		doPlayerSendCancel(cid, "You don't have the required level.")
		return TRUE
	end

	if (isPremium(cid) == FALSE) then
		doPlayerSendCancel(cid, "You need a premium account to do it.")
		return TRUE
	end

	if (getPlayerMana(cid) >= manaCost and getPlayerSoul(cid) >= soulCost) then
		doPlayerAddMana(cid, -manaCost)
		doPlayerAddSoul(cid, -soulCost)
		doTransformItem(item.uid, ENCHANTED_GEMS[item.itemid], count)
		return TRUE
	else
		doPlayerSendCancel(cid, "You don't have mana or soul points.")
	end
	
	return TRUE

end