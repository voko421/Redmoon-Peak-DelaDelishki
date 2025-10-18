/datum/component/storage/concrete/roguetown/belt/holster_belt
    screen_max_rows = 2
    screen_max_columns = 2

/obj/item/storage/belt/rogue/leather/holsterbelt
	name = "Holster Belt"
	desc = "Ремень с кобурой. Пришлось пожертвовать местом на поясе ради возможности удобно носить пистоль."
	icon = 'modular_redmoon/icons/belt/belts.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/belt/onmob_belts.dmi'
	icon_state = "holsterbelt"
	item_state = "holsterbelt"
	strip_delay = 20
	sellprice = 50
	var/max_storage = 1
	var/list/pistol = list()
	sewrepair = TRUE
	component_type = /datum/component/storage/concrete/roguetown/belt/holster_belt

/obj/item/storage/belt/rogue/leather/holsterbelt/attackby(obj/A, loc, params)
	if((A.type in typesof(/obj/item/gun/ballistic/revolver/grenadelauncher/runelock)) || (A.type in typesof(/obj/item/gun/ballistic/firearm/arquebus_pistol)))
		var/obj/item/gun/ballistic/P = A
		if(!P.gripped_intents)
			if(pistol.len < max_storage)
				if(ismob(loc))
					var/mob/M = loc
					M.doUnEquip(P, TRUE, src, TRUE, silent = TRUE)
				else
					P.forceMove(src)
				pistol += P
				icon_state = "holsterbelt_full"
				update_icon()
				to_chat(usr, span_notice("I holster the [P.name] into [src.name]."))
			else
				to_chat(loc, span_warning("Something is already holstered."))
			return
	..()

/obj/item/storage/belt/rogue/leather/holsterbelt/attack_right(mob/user)
	if(pistol.len)
		var/obj/O = pistol[pistol.len]
		pistol -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		icon_state = "holsterbelt"
		update_icon()
		return TRUE

/obj/item/storage/belt/rogue/leather/holsterbelt/examine(mob/user)
	. = ..()
	if(pistol.len == 1)
		. += span_notice("В кобуре есть оружие.")
	else
		. += span_notice("Кобура пустая.")

/obj/item/storage/belt/rogue/leather/holsterbelt/lord
	name = "Plaque Holster Belt"
	desc = "Пояс с позолоченными металлическими вставками, демонстрирующими богатство и статус. Оснащен кобурой для удобного размещения пистоля."
	icon = 'modular_redmoon/icons/belt/belts_royal.dmi'
	mob_overlay_icon = 'modular_redmoon/icons/belt/onmob_belts_royal.dmi'
	sellprice = 150
	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing

/obj/item/storage/belt/rogue/leather/holsterbelt/lord/New()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/gun/ballistic/firearm/arquebus_pistol/A = new()
		pistol += A
	icon_state = "holsterbelt_full"
	update_icon()

/obj/item/storage/belt/rogue/leather/holsterbelt/marshal/New()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/gun/ballistic/firearm/arquebus_pistol/A = new()
		pistol += A
	icon_state = "holsterbelt_full"
	update_icon()

/obj/item/storage/belt/rogue/leather/holsterbelt/runelock/New()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/A = new()
		pistol += A
	icon_state = "holsterbelt_full"
	update_icon()
