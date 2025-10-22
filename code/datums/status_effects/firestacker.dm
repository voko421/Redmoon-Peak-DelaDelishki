/// Maxamounts of fire stacks a mob can get
#define MAX_FIRE_STACKS 20
#define MOB_BIG_FIRE_STACK_THRESHOLD 10
/// How fast fire stacks decay (more - faster)
#define STACK_DECAY_MULTIPLIER 1
#define STACK_DECAY_SCALE_FACTOR 4 // Multiply the decay rate by dividing the amount of firestacks by this value
#define STACK_DECAY_PRONE_MULTIPLIER 3 // If the mob is prone, decay stacks faster
/datum/status_effect/fire_handler
	id = "abstract"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH //Custom code
	on_remove_on_mob_delete = TRUE
	tick_interval = 2 SECONDS
	//processing_speed = STATUS_EFFECT_PRIORITY
	/// Current amount of stacks we have
	var/stacks
	/// Maximum of stacks that we could possibly get
	var/stack_limit = MAX_FIRE_STACKS
	/// What status effect types do we remove uppon being applied. These are just deleted without any deduction from our or their stacks when forced.
	var/list/enemy_types
	/// What status effect types do we merge into if they exist. Ignored when forced.
	var/list/merge_types
	/// What status effect types do we override if they exist. These are simply deleted when forced.
	var/list/override_types
	/// For how much firestacks does one our stack count
	var/stack_modifier = 1
	/// Type of alert we throw
	var/fire_alert_type = /atom/movable/screen/alert/fire

/datum/status_effect/fire_handler/refresh(mob/living/new_owner, new_stacks, forced = FALSE)
	if(forced)
		set_stacks(new_stacks)
	else
		adjust_stacks(new_stacks)

/datum/status_effect/fire_handler/on_creation(mob/living/new_owner, new_stacks, forced = FALSE)
	. = ..()

	owner = new_owner
	set_stacks(new_stacks)

	for(var/enemy_type in enemy_types)
		var/datum/status_effect/fire_handler/enemy_effect = owner.has_status_effect(enemy_type)
		if(enemy_effect)
			if(forced)
				qdel(enemy_effect)
				continue

			var/cur_stacks = stacks
			adjust_stacks(-abs(enemy_effect.stacks * enemy_effect.stack_modifier / stack_modifier))
			enemy_effect.adjust_stacks(-abs(cur_stacks * stack_modifier / enemy_effect.stack_modifier))
			if(enemy_effect.stacks <= 0)
				qdel(enemy_effect)

			if(stacks <= 0)
				qdel(src)
				return

	if(!forced)
		var/list/merge_effects = list()
		for(var/merge_type in merge_types)
			var/datum/status_effect/fire_handler/merge_effect = owner.has_status_effect(merge_type)
			if(merge_effect)
				merge_effects += merge_effects

		if(LAZYLEN(merge_effects))
			for(var/datum/status_effect/fire_handler/merge_effect in merge_effects)
				merge_effect.adjust_stacks(stacks * stack_modifier / merge_effect.stack_modifier / LAZYLEN(merge_effects))
			qdel(src)
			return

	for(var/override_type in override_types)
		var/datum/status_effect/fire_handler/override_effect = owner.has_status_effect(override_type)
		if(override_effect)
			if(forced)
				qdel(override_effect)
				continue

			adjust_stacks(override_effect.stacks)
			qdel(override_effect)

/**
 * Setter and adjuster procs for firestacks
 *
 * Arguments:
 * - new_stacks
 *
 */

/datum/status_effect/fire_handler/proc/set_stacks(new_stacks)
	stacks = max(0, min(stack_limit, new_stacks))
	cache_stacks()

/datum/status_effect/fire_handler/proc/adjust_stacks(new_stacks)
	stacks = max(0, min(stack_limit, stacks + new_stacks))
	cache_stacks()

/**
 * Refresher for mob's fire_stacks
 */

/datum/status_effect/fire_handler/proc/cache_stacks()
	owner.fire_stacks = 0
	var/was_on_fire = owner.on_fire
	owner.on_fire = FALSE
	for(var/datum/status_effect/fire_handler/possible_fire in owner.status_effects)
		owner.fire_stacks += possible_fire.stacks * possible_fire.stack_modifier

		if(!istype(possible_fire, /datum/status_effect/fire_handler/fire_stacks))
			continue

		var/datum/status_effect/fire_handler/fire_stacks/our_fire = possible_fire
		if(our_fire.on_fire)
			owner.on_fire = TRUE

	if(was_on_fire && !owner.on_fire)
		owner.clear_alert(ALERT_FIRE)
	else if(!was_on_fire && owner.on_fire)
		owner.throw_alert(ALERT_FIRE, fire_alert_type)
	owner.update_fire()

/datum/status_effect/fire_handler/fire_stacks
	id = "fire_stacks" //fire_stacks and wet_stacks should have different IDs or else has_status_effect won't work

	stack_modifier = 1

	/// If we're on fire
	var/on_fire = FALSE
	/// Reference to the mob light emitter itself
	var/obj/effect/dummy/lighting_obj/moblight
	/// Type of mob light emitter we use when on fire
	var/moblight_type = /obj/effect/dummy/lighting_obj/moblight/fire
	/// Cached particle type
	var/cached_state

/datum/status_effect/fire_handler/fire_stacks/proc/get_examine_text()
	if(owner.on_fire)
		return

	return "[owner.p_they()] [owner.p_are()] covered in something flammable."

/datum/status_effect/fire_handler/fire_stacks/proc/owner_touched_sparks()
	SIGNAL_HANDLER

	ignite()

/datum/status_effect/fire_handler/fire_stacks/on_creation(mob/living/new_owner, new_stacks, forced = FALSE)
	. = ..()

/datum/status_effect/fire_handler/fire_stacks/on_remove()
	pass()

/datum/status_effect/fire_handler/fire_stacks/tick(wait)
	if(stacks <= 0)
		qdel(src)
		return TRUE

	if(!on_fire)
		return TRUE

	var/decay_multiplier = stacks / STACK_DECAY_SCALE_FACTOR
	if(!(owner.mobility_flags & MOBILITY_STAND))
		decay_multiplier *= STACK_DECAY_PRONE_MULTIPLIER

	adjust_stacks(decay_multiplier * owner.fire_stack_decay_rate * STACK_DECAY_MULTIPLIER * wait * 0.1)

	if(stacks <= 0)
		qdel(src)
		return TRUE

	deal_damage(wait)

/datum/status_effect/fire_handler/fire_stacks/proc/update_particles()
	pass()

/**
 * Proc that handles damage dealing and all special effects
 *
 * Arguments:
 * - seconds_between_ticks
 *
 */

/datum/status_effect/fire_handler/fire_stacks/proc/deal_damage(wait)
	owner.on_fire_stack(wait * 0.1, src)

	var/turf/location = get_turf(owner)
	location?.hotspot_expose(700, 25 * wait * 0.1, TRUE)

/**
 * Used to deal damage to humans and count their protection.
 *
 * Arguments:
 * - seconds_between_ticks
 * - no_protection: When set to TRUE, fire will ignore any possible fire protection
 *
 */

/datum/status_effect/fire_handler/fire_stacks/proc/harm_human(seconds_per_tick, no_protection = FALSE)
	var/mob/living/carbon/human/victim = owner
	victim?.dna?.species?.handle_fire(victim)

/**
 * Handles mob ignition, should be the only way to set on_fire to TRUE
 *
 * Arguments:
 * - silent: When set to TRUE, no message is displayed
 *
 */

/datum/status_effect/fire_handler/fire_stacks/proc/ignite(silent = FALSE)
	if(HAS_TRAIT(owner, TRAIT_NOFIRE))
		return FALSE

	on_fire = TRUE
	if(!silent)
		owner.visible_message(span_warning("[owner] catches fire!"), span_userdanger("You're set on fire!"))

	if(moblight_type)
		if(moblight)
			qdel(moblight)
		moblight = new moblight_type(owner)

	cache_stacks()
	SEND_SIGNAL(owner, COMSIG_LIVING_IGNITED, owner)
	return TRUE

/**
 * Handles mob extinguishing, should be the only way to set on_fire to FALSE
 */

/datum/status_effect/fire_handler/fire_stacks/proc/extinguish()
	QDEL_NULL(moblight)
	on_fire = FALSE
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "on_fire")
	SEND_SIGNAL(owner, COMSIG_LIVING_EXTINGUISHED, owner)
	cache_stacks()

/datum/status_effect/fire_handler/fire_stacks/on_remove()
	if(on_fire)
		extinguish()
	set_stacks(0)
	UnregisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS)
	return ..()

/datum/status_effect/fire_handler/fire_stacks/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(add_fire_overlay))

/datum/status_effect/fire_handler/fire_stacks/proc/add_fire_overlay(mob/living/source, list/overlays)
	SIGNAL_HANDLER

	if(stacks <= 0 || !on_fire)
		return

	var/mutable_appearance/created_overlay = owner.get_fire_overlay(stacks, on_fire)
	if(isnull(created_overlay))
		return

	overlays |= created_overlay

/datum/status_effect/fire_handler/fire_stacks/divine
	id = "fire_stacks_divine"

/datum/status_effect/fire_handler/fire_stacks/divine/harm_human(seconds_per_tick, no_protection = FALSE)
	var/mob/living/carbon/human/victim = owner
	victim?.dna?.species?.handle_fire(victim, no_protection)
	victim.adjustFireLoss(10)

/datum/status_effect/fire_handler/fire_stacks/sunder
	id = "fire_stacks_sunder"
	fire_alert_type = /atom/movable/screen/alert/fire/sunder

/datum/status_effect/fire_handler/fire_stacks/sunder/harm_human(seconds_per_tick, no_protection = FALSE)
	var/mob/living/carbon/human/victim = owner
	if(istype(victim))
		victim?.dna?.species?.handle_fire(victim, no_protection)
	victim.adjustFireLoss((owner.getFireLoss() >= 100) ? 4 : 2)

/datum/status_effect/fire_handler/fire_stacks/sunder/blessed
	id = "fire_stacks_sunder_blessed"
	fire_alert_type = /atom/movable/screen/alert/fire/sunder/blessed

/datum/status_effect/fire_handler/fire_stacks/sunder/blessed/harm_human(seconds_per_tick, no_protection = FALSE)
	var/mob/living/carbon/human/victim = owner
	if(istype(victim))
		victim?.dna?.species?.handle_fire(victim, no_protection)
	victim.adjustFireLoss(8)

/datum/status_effect/fire_handler/wet_stacks
	id = "wet_stacks"

	enemy_types = list(/datum/status_effect/fire_handler/fire_stacks)
	stack_modifier = -1
	/// If the mob has the TRAIT_SLIPPERY_WHEN_WET trait, the mob gets this component while it's wet
	var/datum/component/slippery/slipperiness

/datum/status_effect/fire_handler/wet_stacks/tick(seconds_between_ticks)
	adjust_stacks(-0.5 * seconds_between_ticks)
	if(stacks <= 0)
		qdel(src)

#undef MAX_FIRE_STACKS
#undef MOB_BIG_FIRE_STACK_THRESHOLD
#undef STACK_DECAY_MULTIPLIER
