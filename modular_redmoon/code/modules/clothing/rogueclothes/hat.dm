/obj/item/clothing/head/roguetown/helmet/heavy/pumpkin
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "pumpkin"
	item_state = "pumpkin"
	icon = 'modular_redmoon/icons/head/head.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/head/head_onmob.dmi'
	var/on = FALSE
	light_outer_range = 6
	light_power = 3
	light_color = LIGHT_COLOR_FIRE
	light_system = MOVABLE_LIGHT
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/head/roguetown/helmet/heavy/pumpkin/MiddleClick(mob/user)
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, 'sound/misc/toggle_lamp.ogg', 100)
	toggle_helmet_light(user)
	to_chat(user, span_info("I toggle [src] [on ? "on" : "off"]."))

/obj/item/clothing/head/roguetown/helmet/heavy/pumpkin/proc/toggle_helmet_light(mob/living/user)
	on = !on
	set_light_on(on)
	update_icon()

/obj/item/clothing/head/roguetown/helmet/heavy/pumpkin/update_icon()
	icon_state = "[initial(icon_state)][on]"
	item_state = "[initial(item_state)][on]"
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.update_inv_head()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon(force = TRUE)
	..()

/obj/item/clothing/head/roguetown/helmet/heavy/pumpkin/blumpkin
	name = "carved blumpkin"
	desc = "A very blue jack o' lantern! Believed to ward off vengeful chemists."
	icon_state = "blumpkin"
	item_state = "blumpkin"
	light_color = LIGHT_COLOR_BLUE
