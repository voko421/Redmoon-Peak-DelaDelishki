/datum/outfit/job/roguetown/puritan/inspector/pre_equip(mob/living/carbon/human/H)
	..()
	head = null

/datum/outfit/job/roguetown/puritan/inspector/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	var/helmets = list("Hat", "Cap")
	var/helmet_choice = input(H,"Choose your PSYDONIAN insignia.", "TAKE UP HEADWEAR") as anything in helmets
	switch(helmet_choice)
		if("Hat")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/inqhat, SLOT_HEAD, TRUE)
		if("Cap")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/roguetown/inqhat/cap, SLOT_HEAD, TRUE)
