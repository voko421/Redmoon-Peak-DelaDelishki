//human master carpenter

/datum/advclass/mastercarpenter
	name = "Master Carpenter"
	tutorial = "A master carpenter, unlike the masons you went to discover the secrets of the wood. \
	The elves, created by Dendor ,who taught you how to transform the wood into anything you wish, \
	but you swore to chop down trees only when it is necessary."
	
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/mastercarpenter
	category_tags = list(CTAG_TOWNER)
	maximum_possible_slots = 1
	pickprob = 5
	subclass_stats = list(
		STATKEY_WIL = 3,
		STATKEY_STR = 2,
		STATKEY_INT = 2,
		STATKEY_CON = 1,
		STATKEY_SPD = 1
	)
	subclass_skills = list(
		/datum/skill/combat/axes = 4, // They use hammers, sawes and axes all day.
		/datum/skill/combat/maces = 3, 
		/datum/skill/misc/athletics = 4, 
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 3,
		/datum/skill/combat/knives = 2,
		/datum/skill/misc/swimming = 3,
		/datum/skill/misc/climbing = 4, // They work at great heights.
		/datum/skill/craft/crafting = 4,
		/datum/skill/craft/carpentry = 6,
		/datum/skill/craft/engineering = 4,
		/datum/skill/misc/reading = 2,
		/datum/skill/craft/traps = 2,
		/datum/skill/labor/lumberjacking = 4,
		/datum/skill/misc/medicine = 2,
	)

/datum/outfit/job/roguetown/adventurer/mastercarpenter/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/dendor 
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
						)
