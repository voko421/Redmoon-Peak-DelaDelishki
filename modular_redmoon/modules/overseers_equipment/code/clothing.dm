// OVERSEER

/obj/item/clothing/suit/roguetown/armor/gambeson/heavy/inq/overseer
	name = "overseer jacket"
	desc = "Padded jacket that provides adequate protection against unarmed innocents."
	icon_state = "overseerjacket"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	sleeved = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	boobed = TRUE

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer
	name = "vice overseer coat"
	desc = "Heavy, reinforced coat with a tasteful burgundy covering will not leave anyone indifferent."
	icon_state = "viceseercoat"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	sleeved = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	boobed = TRUE

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer/ComponentInitialize()	//No movement rustle component.
	return

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/clothing/suit/roguetown/armor/plate/half/fluted/ornate))
		user.visible_message(span_warning("[user] starts to fit [W] inside the [src]."))
		if(do_after(user, 12 SECONDS))
			var/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer/armored/P = new /obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer/armored(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
			user.put_in_hands(P)
			P.obj_integrity = src.obj_integrity
			qdel(src)
			qdel(W)
		else
			user.visible_message(span_warning("[user] stops fitting [W] inside the [src]."))
		return

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer/armored
	slot_flags = ITEM_SLOT_ARMOR
	name = "armored overseer coat"
	icon_state = "viceseercoat"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	sleeved = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'

/obj/item/clothing/suit/roguetown/armor/plate/scale/inqcoat/overseer/armored/ComponentInitialize()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_STEP)
	return

/obj/item/clothing/under/roguetown/heavy_leather_pants/otavan/overseer
	name = "heavy trousers"
	desc = "A pair of washed-out heavy trousers in grey colors."
	icon_state = "overseerpants"
	item_state = "overseerpants"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	sleeved = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'

/obj/item/clothing/gloves/roguetown/otavan/overseer
	name = "leather gloves"
	desc = "Black leather gloves, adorned with bright strips."
	icon_state = "viceseergloves"
	item_state = "viceseergloves"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'

/obj/item/storage/belt/rogue/leather/overseer
	name = "belt with pouches"
	desc = "Leather belt with some pouches attached."
	icon_state = "overseerbelt"
	item_state = "overseerbelt"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	w_class = WEIGHT_CLASS_BULKY
	component_type = /datum/component/storage/concrete/roguetown/belt/overseer

/datum/component/storage/concrete/roguetown/belt/overseer
	screen_max_rows = 3
	screen_max_columns = 3
	max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/mask/rogue/sack/overseer
	name = "cloth hood"
	desc = "You wouldn't hide your face if there were no reasons for."
	icon_state = "overseerhood"
	item_state = "overseerhood"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'

/obj/item/clothing/head/roguetown/helmet/overseer
	name = "overseer mask"
	desc = "Silver mask covered in protective runes, depicting Psydon's ENDURING visage."
	icon_state = "viceseermask"
	item_state = "viceseermask"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/overseer.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/overseer_onmob.dmi'
	max_integrity = 250
	flags_inv = HIDEFACE
	body_parts_covered = FACE|HEAD|HAIR|EARS|NOSE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	block2add = FOV_BEHIND
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK|ITEM_SLOT_HIP
	sellprice = 30
	smeltresult = /obj/item/ingot/silver

/obj/item/clothing/head/roguetown/helmet/overseer/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -5,"sy" = -3,"nx" = 0,"ny" = 0,"wx" = 0,"wy" = -3,"ex" = 2,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 8)
			if("onbelt")
				return list("shrink" = 0.32,"sx" = -3,"sy" = -8,"nx" = 6,"ny" = -8,"wx" = -1,"wy" = -8,"ex" = 3,"ey" = -8,"nturn" = 180,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 1,"sflip" = 0,"wflip" = 0,"eflip" = 8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


// INQUISITOR CAP

/obj/item/clothing/head/roguetown/inqhat/cap
	name = "inquisitorial cap"
	desc = "To keep ones vision away from the heavens, and focused on the sin beneath the soil."
	icon_state = "inqcap"
	item_state = "inqcap"
	icon = 'modular_redmoon/modules/overseers_equipment/icons/inqcap.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/overseers_equipment/icons/onmob/inqcap_onmob.dmi'
