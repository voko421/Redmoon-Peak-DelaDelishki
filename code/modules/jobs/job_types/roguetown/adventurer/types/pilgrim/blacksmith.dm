/datum/advclass/blacksmith
	name = "Blacksmith"
	tutorial = "A skilled blacksmith, able to forge capable weapons for warriors in the bog, \
	only after building a forge for themselves of course"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/blacksmith
	
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_TRAINED_SMITH)
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_CON = 2,
		STATKEY_STR = 1,
		STATKEY_LCK = 1,
		STATKEY_SPD = -1
	)
	subclass_skills = list(
		/datum/skill/combat/swords = 1,
		/datum/skill/combat/maces = 2,
		/datum/skill/combat/axes = 2,
		/datum/skill/combat/crossbows = 1,
		/datum/skill/misc/athletics = 2,
		/datum/skill/combat/bows = 1,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 3, // The strongest fists in the land.
		/datum/skill/combat/knives = 1,
		/datum/skill/craft/crafting = 2,
		/datum/skill/craft/engineering = 2,
		/datum/skill/misc/reading = 1,
		/datum/skill/craft/blacksmithing = 4,
		/datum/skill/craft/armorsmithing = 4,
		/datum/skill/craft/weaponsmithing = 4,
		/datum/skill/craft/smelting = 4,
	)

/datum/outfit/job/roguetown/adventurer/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/hammer/iron
	beltl = /obj/item/rogueweapon/tongs
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves/blacksmith
	cloak = /obj/item/clothing/cloak/apron/blacksmith
	mouth = /obj/item/rogueweapon/huntingknife
	pants = /obj/item/clothing/under/roguetown/trou
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/rogueore/coal=1,
						/obj/item/rogueore/iron=1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/recipe_book/blacksmithing = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
	if(H.pronouns == HE_HIM)
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
