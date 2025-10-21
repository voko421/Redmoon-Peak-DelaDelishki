/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher
	icon = 'icons/mob/summonable/32x32.dmi'
	name = "infernal watcher"
	icon_state = "watcher"
	icon_living = "watcher"
	summon_primer = "You are an infernal watcher, a creature of lava and rock. You have watched over the chaos of the infernal plane long enough that it was been pointless to keep count."
	summon_tier = 3
	icon_dead = "vvd"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 6
	see_in_dark = 6
	move_to_delay = 5
	base_intents = list(/datum/intent/simple/bite)
	butcher_results = list()
	faction = list("infernal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 600
	maxHealth = 600
	melee_damage_lower = 20
	melee_damage_upper = 30
	vision_range = 7
	aggro_vision_range = 9
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	simple_detect_bonus = 20
	retreat_distance = 4
	minimum_distance = 3
	food_type = list()
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	STACON = 13
	STASTR = 12
	STASPD = 8
	simple_detect_bonus = 20
	deaggroprob = 0
	canparry = TRUE
	defprob = 35
	// del_on_deaggro = 44 SECONDS
	retreat_health = 0.3
	food = 0
	attack_sound = list('sound/misc/lava_death.ogg')
	dodgetime = 30
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	ranged = TRUE
	ranged_cooldown = 40
	projectiletype = /obj/projectile/magic/aoe/fireball/rogue
	ranged_message = "stares"

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_SILVER_WEAK, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/simple_add_wound(datum/wound/wound, silent = FALSE, crit_message = FALSE)	//no wounding the watcher
	return

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/MeleeAction(patience = TRUE)
	for(var/t in RANGE_TURFS(1, src))
		new /obj/effect/hotspot(t)
		src.visible_message(span_danger("[src] emits a burst of flames from it's core!"))
	if(rapid_melee > 1)
		var/datum/callback/cb = CALLBACK(src, PROC_REF(CheckAndAttack))
		var/delay = SSnpcpool.wait / rapid_melee
		for(var/i in 1 to rapid_melee)
			addtimer(cb, (i - 1)*delay)
	else
		AttackingTarget()
	if(patience)
		GainPatience()

/mob/living/simple_animal/hostile/retaliate/rogue/infernal/watcher/death(gibbed)
	..()
	var/turf/deathspot = get_turf(src)
	new /obj/item/magic/infernal/core(deathspot)
	new /obj/item/magic/infernal/core(deathspot)
	new /obj/item/magic/infernal/fang(deathspot)
	new /obj/item/magic/infernal/fang(deathspot)
	new /obj/item/magic/infernal/ash(deathspot)
	new /obj/item/magic/infernal/ash(deathspot)
	new /obj/item/magic/melded/t1(deathspot)

	update_icon()
	spill_embedded_objects()
	qdel(src)
