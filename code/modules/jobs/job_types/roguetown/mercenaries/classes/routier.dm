/datum/advclass/mercenary/routier
	name = "Otavan Routiers"
	tutorial = "The Routiers are a formidable Otavan mercenary band, a brotherhood of knights from noble families serving lords who seek to profit in peacetime. The Otavan nobility at large and even some of the clergy eagerly awaits to hear about your feats, they expect you to ENDURE, to be the champion of their faith and represent the true values of nobility, will you?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = NON_DWARVEN_RACE_TYPES
	outfit = /datum/outfit/job/roguetown/mercenary/routier
	category_tags = list(CTAG_MERCENARY)
	traits_applied = list(TRAIT_HEAVYARMOR, TRAIT_NOBLE)
	cmode_music = 'sound/music/combat_routier.ogg'
	subclass_stats = list(
		STATKEY_CON = 4,
		STATKEY_WIL = 2,
		STATKEY_STR = 2,
		STATKEY_PER = 1,
		STATKEY_SPD = -1
	)
	subclass_skills = list(
		/datum/skill/misc/swimming = 2,
		/datum/skill/misc/climbing = 2,
		/datum/skill/misc/sneaking = 2,
		/datum/skill/combat/maces = 2,
		/datum/skill/combat/crossbows = 2,
		/datum/skill/combat/wrestling = 3,
		/datum/skill/combat/unarmed = 2,
		/datum/skill/combat/swords = 2,
		/datum/skill/combat/shields = 3,
		/datum/skill/combat/polearms = 3,
		/datum/skill/combat/whipsflails = 2,
		/datum/skill/combat/knives = 2,
		/datum/skill/misc/reading = 1,
		/datum/skill/misc/athletics = 3,
		/datum/skill/misc/riding = 2,
	)

/datum/outfit/job/roguetown/mercenary/routier/pre_equip(mob/living/carbon/human/H)
	..()

	// CLASS ARCHETYPES
	H.adjust_blindness(-3)
	var/classes = list("Swordsman","Macebearer","Flailman", "Foot Lancer")
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	H.set_blindness(0)
	to_chat(H, span_warning("You are a Knight of Otava, well experienced in the use of your chosen arms."))
	switch(classchoice)
		if("Swordsman")
			H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
			beltl = /obj/item/rogueweapon/scabbard/sword
			l_hand = /obj/item/rogueweapon/sword/short/falchion
		if("Macebearer")
			H.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
			beltl = /obj/item/rogueweapon/mace/steel/morningstar
		if("Flailman")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
			beltl = /obj/item/rogueweapon/flail/sflail
		if("Foot Lancer")
			H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			r_hand = /obj/item/rogueweapon/spear/lance
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	neck = /obj/item/clothing/neck/roguetown/fencerguard
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan
	head = /obj/item/clothing/head/roguetown/helmet/otavan
	armor = /obj/item/clothing/suit/roguetown/armor/plate/otavan
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
	gloves = /obj/item/clothing/gloves/roguetown/otavan
	backr = /obj/item/storage/backpack/rogue/satchel/black
	backl = /obj/item/rogueweapon/shield/tower/metal
	backpack_contents = list(
		/obj/item/roguekey/mercenary = 1,
		/obj/item/flashlight/flare/torch = 1,
		)

	H.grant_language(/datum/language/otavan)
	
	H.merctype = 10
