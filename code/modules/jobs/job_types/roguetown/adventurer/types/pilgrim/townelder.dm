/datum/advclass/elder
	name = "Town Elder"
	maximum_possible_slots = 1
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	allowed_ages = list(AGE_OLD)
	tutorial = "You are as venerable and ancient as the trees themselves, wise even for your years spent with the first Wardens. The people look up to you both as a teacher and a guide to solve lesser issues before violence is involved. Not everything must end in bloodshed, no matter how much the retinue wish it were the case. Lead your fellow townsfolk in these troubling times lest they incur wrath of the nobility with their ignorance."
	outfit = /datum/outfit/job/roguetown/elder
	cmode_music = 'sound/music/cmode/towner/combat_retired.ogg'
	category_tags = list(CTAG_TOWNER)
	traits_applied = list(TRAIT_SEEPRICES_SHITTY, TRAIT_EMPATH, TRAIT_MEDICINE_EXPERT)
	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_PER = 2,
		STATKEY_WIL = 2,
		STATKEY_CON = 1,
		STATKEY_SPD = -1
	)
	subclass_skills = list(
		/datum/skill/combat/knives = 2,
		/datum/skill/combat/maces = 3,
		/datum/skill/combat/wrestling = 2,
		/datum/skill/combat/unarmed = 3,
		/datum/skill/craft/crafting = 5,
		/datum/skill/craft/carpentry = 3,
		/datum/skill/craft/masonry = 3,
		/datum/skill/craft/engineering = 2,
		/datum/skill/misc/sewing = 4,
		/datum/skill/misc/climbing = 3,
		/datum/skill/craft/alchemy = 2,
		/datum/skill/craft/tanning = 3,
		/datum/skill/labor/farming = 1,
		/datum/skill/misc/athletics = 1,
		/datum/skill/misc/reading = 4,
		/datum/skill/misc/swimming = 3,
		/datum/skill/misc/medicine = 4,
		/datum/skill/misc/riding = 1,
		/datum/skill/misc/tracking = 3,
		/datum/skill/craft/cooking = 3,
		/datum/skill/misc/ceramics = 3,
	)

/datum/outfit/job/roguetown/elder/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/stabard/guardhood/elder
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/white
	pants = /obj/item/clothing/under/roguetown/tights
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/mace
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/scomstone/bad
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1, /obj/item/storage/belt/rogue/pouch/coins/rich = 1)
	if(should_wear_femme_clothes(H))
		head = /obj/item/clothing/head/roguetown/chaperon/greyscale/elder
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress
		backr = /obj/item/clothing/cloak/raincloak/furcloak
	else if(should_wear_masc_clothes(H))
		head = /obj/item/clothing/head/roguetown/chaperon/greyscale/elder
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
		gloves = /obj/item/clothing/gloves/roguetown/leather
