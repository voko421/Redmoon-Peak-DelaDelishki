/obj/item/clothing/cloak/apron/waist/maid
	name = "maid apron"
	desc = "A fancy, somewhat short apron usually worn by servants."
	body_parts_covered = null
	icon_state = "maidapron"
	item_state = "maidapron"
	icon = 'modular_redmoon/modules/maids/icons/maids.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'
	sleeved = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'

/obj/item/clothing/head/roguetown/maidhead
	name = "maid headdress"
	desc = "A decorative cloth headband clearly indicating the wearer as a maid."
	icon_state = "maidhead"
	item_state = "maidhead"
	icon = 'modular_redmoon/modules/maids/icons/maids.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'
	sleeved = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'

/obj/item/clothing/suit/roguetown/shirt/dress/maid
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "maid dress"
	desc = "A distinctive black dress that should be kept clean and tidy - unless you want to be disciplined."
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
	boobed = TRUE
	item_state = "maiddress"
	icon_state = "maiddress"
	icon = 'modular_redmoon/modules/maids/icons/maids.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'
	sleeved = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'
	var/open_wear = FALSE

/obj/item/clothing/suit/roguetown/shirt/dress/maid/attack_right(mob/user)
	switch(open_wear)
		if(FALSE)
			name = "open maid dress"
			body_parts_covered = null
			open_wear = TRUE
			flags_inv = HIDEBOOB
			to_chat(usr, span_warning("Now wearing radically!"))
		if(TRUE)
			name = "maid dress"
			body_parts_covered = CHEST|GROIN|ARMS|LEGS|VITALS
			open_wear = FALSE
			flags_inv = HIDEBOOB|HIDECROTCH
			to_chat(usr, span_warning("Now wearing normally!"))
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_armor()

/obj/item/storage/belt/rogue/leather/sash/maid
	name = "cloth sash"
	desc = "A pliable sash made of wool meant to wrap tightly around the waist."
	item_state = "maidsash"
	icon_state = "maidsash"
	icon = 'modular_redmoon/modules/maids/icons/maids.dmi'
	mob_overlay_icon = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'
	sleeved = 'modular_redmoon/modules/maids/icons/onmob/maids_onmob.dmi'
