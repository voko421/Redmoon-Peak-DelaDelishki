/obj/effect/proc_holder/spell/invoked/mending
	name = "Mending"
	desc = "Uses arcyne energy to mend an item. Effect of repair scales off of your Intelligence."
	overlay_state = "mending"
	releasedrain = 50
	chargetime = 5
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	cost = 2
	spell_tier = 1 // Utility. For repair
	glow_color = GLOW_COLOR_ARCANE
	glow_intensity = GLOW_INTENSITY_LOW

	miracle = FALSE

	invocations = list("Reficio")
	invocation_type = "shout" //can be none, whisper, emote and shout

	var/repair_percent = 0.20
	var/int_bonus = 0.00

/obj/effect/proc_holder/spell/invoked/mending/cast(list/targets, mob/living/user)
	if(istype(targets[1], /obj/item))
		var/obj/item/I = targets[1]
		if(!I.anvilrepair && !I.sewrepair)
			to_chat(user, span_warning("Not even magic can mend this item!"))
			revert_cast()
			return

		if(I.obj_integrity < I.max_integrity || I.body_parts_covered_dynamic != I.body_parts_covered)
			int_bonus = (user.STAINT * 0.01)
			repair_percent += int_bonus
			repair_percent *= I.max_integrity
			I.obj_integrity = min(I.obj_integrity + repair_percent, I.max_integrity)
			user.visible_message(span_info("[I] glows in a faint mending light."))
			playsound(I, 'sound/foley/sewflesh.ogg', 50, TRUE, -2)
			if(I.obj_integrity >= I.max_integrity)
				I.obj_integrity = I.max_integrity
				if(I.obj_broken)
					I.obj_fix()
				else
					I.repair_coverage()
		else if(I.peel_count)
			I.peel_count--
			to_chat(user, span_info("[I]'s shorn layers mend together. ([I.peel_count])."))
		else
			to_chat(user, span_info("[I] appears to be in perfect condition."))
			revert_cast()
	else
		to_chat(user, span_warning("There is no item here!"))
		revert_cast()


/obj/effect/proc_holder/spell/invoked/mending/lesser
	name = "Lesser Mending"
	repair_percent = 0.10
	recharge_time = 30 SECONDS
	cost = 1
