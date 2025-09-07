//human treesbane

/datum/advclass/masterwoodcutter
	name = "Master Lumberjack"
	tutorial = "The strongest and wisest Lumberjack, trained in the art of both chopping and transforming wood. \
	With your mighty hands you chopped countless trees, Dendor fears you, the elves tell the children stories about you, \
	so they don't wander in the forest."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/masterwoodcutter
	maximum_possible_slots = 1
	pickprob = 5
	category_tags = list(CTAG_TOWNER)
	subclass_stats = list(
		STATKEY_STR = 4,
		STATKEY_INT = 2,
		STATKEY_WIL = 2,
		STATKEY_CON = 2,
		STATKEY_PER = 1
	)
	subclass_skills = list(
		/datum/skill/combat/axes = 6, // AXE MEN! GIVE ME SPLINTERS!
		/datum/skill/misc/athletics = 4, 
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 3,
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 3,
		/datum/skill/craft/crafting = 4,
		/datum/skill/craft/carpentry = 4,
		/datum/skill/craft/engineering = 1,
		/datum/skill/misc/sewing = 1,
		/datum/skill/labor/butchering = 1,
		/datum/skill/labor/lumberjacking = 6,
		/datum/skill/craft/traps = 2,
		/datum/skill/misc/medicine = 2,
	)
	
/datum/outfit/job/roguetown/adventurer/masterwoodcutter/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/hatfur
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black 
	beltr = /obj/item/rogueweapon/stoneaxe/woodcut/steel/woodcutter
	beltl = /obj/item/rogueweapon/huntingknife
	backpack_contents = list(
						/obj/item/flint = 1,
						/obj/item/flashlight/flare/torch = 1,
						/obj/item/rogueweapon/scabbard/sheath = 1
						)

