/datum/advclass/fisher
	name = "Fisher"
	tutorial = "You are a fisherman, with your bag of bait and your fishing rod, you are one of few who can reliably get a stable source of meat around here"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/fisher
	
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	traits_applied = list(TRAIT_CAUTIOUS_FISHER)
	subclass_stats = list(
		STATKEY_PER = 2,
		STATKEY_FOR = 2,
		STATKEY_SPD = 1
	)
	subclass_skills = list(
		/datum/skill/combat/swords = 1,
		/datum/skill/combat/axes = 1,
		/datum/skill/combat/maces = 1,
		/datum/skill/combat/crossbows = 1,
		/datum/skill/misc/athletics = 3,
		/datum/skill/combat/bows = 1,
		/datum/skill/combat/wrestling = 2, //Wrestling down those nasty carp.
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/knives = 3,
		/datum/skill/combat/polearms = 1,
		/datum/skill/misc/swimming = 4,
		/datum/skill/misc/climbing = 3,
		/datum/skill/craft/crafting = 2,
		/datum/skill/misc/reading = 1,
		/datum/skill/misc/sewing = 1,
		/datum/skill/labor/butchering = 3,
		/datum/skill/craft/traps = 1,
		/datum/skill/misc/medicine = 2,
		/datum/skill/misc/sneaking = 2,
		/datum/skill/craft/cooking = 2,
		/datum/skill/craft/carpentry = 1,
	)

/datum/outfit/job/roguetown/adventurer/fisher/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/labor/fishing, 5, TRUE)
	else
		H.adjust_skillrank(/datum/skill/labor/fishing, 4, TRUE)
	if(H.pronouns == HE_HIM || H.pronouns == THEY_THEM || H.pronouns == IT_ITS)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		head = /obj/item/clothing/head/roguetown/fisherhat
		mouth = /obj/item/rogueweapon/huntingknife
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		backr = /obj/item/fishingrod
		beltr = /obj/item/cooking/pan
		beltl = /obj/item/flint
		backpack_contents = list(
							/obj/item/natural/worms = 2,
							/obj/item/rogueweapon/shovel/small = 1,
							/obj/item/flashlight/flare/torch = 1,
							/obj/item/recipe_book/survival = 1,
							/obj/item/rogueweapon/scabbard/sheath = 1
							)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		head = /obj/item/clothing/head/roguetown/fisherhat
		mouth = /obj/item/rogueweapon/huntingknife
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		backr = /obj/item/fishingrod
		beltr = /obj/item/cooking/pan
		beltl = /obj/item/flint
		backpack_contents = list(
							/obj/item/natural/worms = 2,
							/obj/item/rogueweapon/shovel/small = 1,
							/obj/item/flashlight/flare/torch = 1,
							/obj/item/rogueweapon/scabbard/sheath = 1
							)
