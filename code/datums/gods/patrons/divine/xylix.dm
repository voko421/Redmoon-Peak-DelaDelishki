/datum/patron/divine/xylix
	name = "Xylix"
	domain = "God of Trickery, Freedom and Inspiration"
	desc = "The Laughing God, both famous and infamous for his sway over the forces of luck. Xylix is known for the inspiration of many a bards lyric. Speaks through his gift to man; the Tarot deck."
	worshippers = "Gamblers, Bards, Artists, and the Silver-Tongued"
	mob_traits = list(TRAIT_XYLIX)
	miracles = list(/obj/effect/proc_holder/spell/targeted/touch/orison			= CLERIC_ORI,
					/obj/effect/proc_holder/spell/self/xylixslip				= CLERIC_T0,
					/obj/effect/proc_holder/spell/invoked/lesser_heal 			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/blood_heal			= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/wheel					= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/mockery				= CLERIC_T1,
					/obj/effect/proc_holder/spell/invoked/mastersillusion		= CLERIC_T2,
					/obj/effect/proc_holder/spell/invoked/resurrect/xylix		= CLERIC_T4,
	)
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"NOC IS NIGHT!",
		"DENDOR PROVIDES!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!",
		"PESTRA SOOTHES ALL ILLS!",
		"MALUM IS MY MUSE!",
		"EORA BRINGS US TOGETHER!",
		"LONG LIVE ZIZO!",
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"MATTHIOS IS MY LORD!",
		"BAOTHA IS MY JOY!",
		"REBUKE THE HERETICAL- PSYDON ENDURES!",
	)
	storyteller = /datum/storyteller/xylix

// Near a gambling machine, cross, or within the church
/datum/patron/divine/xylix/can_pray(mob/living/follower)
	. = ..()
	// Allows prayer near psycross
	for(var/obj/structure/fluff/psycross/cross in view(4, get_turf(follower)))
		if(cross.divine == FALSE)
			to_chat(follower, span_danger("That defiled cross interupts my prayers!"))
			return FALSE
		return TRUE
	// Allows prayer in the church
	if(istype(get_area(follower), /area/rogue/indoors/town/church))
		return TRUE
	// Allows prayer near gambling machines.
	for(var/obj/structure/roguemachine/lottery_roguetown/L in view(4, get_turf(follower)))
		return TRUE
	to_chat(follower, span_danger("For Xylix to hear my prayer I must either pray within the church, near a psycross, or near a machine of fortune blessed by the grand jester.."))
	return FALSE

/datum/patron/divine/xylix/on_lesser_heal(
    mob/living/user,
    mob/living/target,
    message_out,
    message_self,
    conditional_buff,
    situational_bonus
)
	*message_out = span_info("A fugue seems to manifest briefly across [target]!")
	*message_self = span_notice("My wounds vanish as if they had never been there! ")

	*situational_bonus = rand(1, 6)
	switch(*situational_bonus)
		if(1)
			if(prob(75+(user.STALUC)))
				user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll1", 3 SECONDS, MUTATIONS_LAYER, soundin = 'sound/misc/psydong.ogg', y_offset = 32)
				user.psydo_nyte()
				var/turf/T = get_step(get_step(user, NORTH), NORTH)
				T.Beam(user, icon_state="lightning[rand(1,12)]", time = 5)
				user.adjustFireLoss(15)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					H.electrocution_animation(40)
				GLOB.azure_round_stats[STATS_PEOPLE_SMITTEN]++
				to_chat(user, span_danger("Roll the dice better, chuclkenuts!"))
			else
				user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll2", 3 SECONDS, MUTATIONS_LAYER, soundin = 'sound/magic/mockery.ogg', y_offset = 32)
				user.psydo_nyte()
				var/turf/target_tile = get_ranged_target_turf(user, pick(GLOB.alldirs), 12)
				user.throw_at(target = target_tile, range = 12, speed = 2, thrower = user, spin = TRUE, force = 30)
				user.Knockdown(1 SECONDS)
				GLOB.azure_round_stats[STATS_PEOPLE_SMITTEN]++
				to_chat(user, span_danger("Xylix is ​​laughing at you!"))
		if(2)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll3", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_1.ogg', y_offset = 32)
		if(3)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll3", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_1.ogg', y_offset = 32)
		if(4)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll4", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_2.ogg', y_offset = 32)
		if(5)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll5", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_3.ogg', y_offset = 32)
		if(6)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll6", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_4.ogg', y_offset = 32)
