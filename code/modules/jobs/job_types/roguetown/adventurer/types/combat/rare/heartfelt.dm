
/datum/advclass/heartfeltlord
	name = "Lord of Heartfelt"
	tutorial = "You are the proud lord of heartfelt \
	but why did you come to the isle of enigma?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_NO_CONSTRUCT
	outfit = /datum/outfit/job/roguetown/adventurer/heartfeltlord
	maximum_possible_slots = 1
	pickprob = 100
	traits_applied = list(TRAIT_NOBLE, TRAIT_HEAVYARMOR, TRAIT_MEDIUMARMOR)
	category_tags = list(CTAG_DISABLED)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_INT = 2,
		STATKEY_WIL = 2,
		STATKEY_SPD = 1,
		STATKEY_PER = 2,
		STATKEY_LCK = 5
	)
	subclass_skills = list(
		/datum/skill/combat/crossbows = 3,
		/datum/skill/combat/polearms = 2,
		/datum/skill/combat/maces = 3,
		/datum/skill/combat/bows = 3,
		/datum/skill/combat/wrestling = 2,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/misc/swimming = 1,
		/datum/skill/misc/climbing = 2,
		/datum/skill/misc/athletics = 3,
		/datum/skill/combat/swords = 4,
		/datum/skill/combat/knives = 2,
		/datum/skill/misc/reading = 4,
		/datum/skill/misc/sneaking = 2,
		/datum/skill/misc/medicine = 1,
		/datum/skill/misc/riding = 3,

	)

/datum/outfit/job/roguetown/adventurer/heartfeltlord/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	belt = /obj/item/storage/belt/rogue/leather/black
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	pants = /obj/item/clothing/under/roguetown/tights/black
	cloak = /obj/item/clothing/cloak/heartfelt
	armor = /obj/item/clothing/suit/roguetown/armor/heartfelt/lord
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	beltl = /obj/item/rogueweapon/scabbard/sword
	l_hand = /obj/item/rogueweapon/sword/long/marlin
	beltr = /obj/item/rogueweapon/huntingknife
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
						/obj/item/flashlight/flare/torch = 1,
						)
	id = /obj/item/scomstone
