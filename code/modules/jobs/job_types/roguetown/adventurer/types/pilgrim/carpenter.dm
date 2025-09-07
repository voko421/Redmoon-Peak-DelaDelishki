/datum/advclass/carpenter
	name = "Carpenter"
	tutorial = "A skilled carpenter, able to manipulate wood to suit their needs \
	building forts and stores, carpenting floors, putting up crosses. You can do it all with enough logs"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/carpenter
	
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	subclass_stats = list(
		STATKEY_WIL = 2,
		STATKEY_STR = 1,
		STATKEY_CON = 1,
		STATKEY_INT = 1,
		STATKEY_SPD = -1
	)
	subclass_skills = list(
		/datum/skill/combat/axes = 2, // They use hammers, sawes and axes all day.
		/datum/skill/combat/maces = 2, 
		/datum/skill/misc/athletics = 4, 
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/knives = 2,
		/datum/skill/combat/polearms = 2, 
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 3, // They work at great heights.
		/datum/skill/craft/crafting = 3,
		/datum/skill/craft/carpentry = 4,
		/datum/skill/craft/masonry = 1,
		/datum/skill/craft/engineering = 3,
		/datum/skill/misc/reading = 2,
		/datum/skill/craft/traps = 1,
		/datum/skill/labor/lumberjacking = 3,
		/datum/skill/misc/medicine = 1,
	)

/datum/outfit/job/roguetown/adventurer/carpenter/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/armor/workervest
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/hammer/steel
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/rogueweapon/huntingknife = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/handsaw = 1,
						/obj/item/dye_brush = 1,
						/obj/item/recipe_book/builder = 1,
						/obj/item/recipe_book/survival = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)
