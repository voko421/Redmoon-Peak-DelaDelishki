/datum/element/forced_gravity
	element_flags = ELEMENT_BESPOKE
	id_arg_index = 2
	var/gravity

/datum/element/forced_gravity/Attach(datum/target, gravity=1, ignore_space=FALSE)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	src.gravity = gravity

	RegisterSignal(target, COMSIG_ATOM_HAS_GRAVITY, PROC_REF(gravity_check))
	if(isturf(target))
		RegisterSignal(target, COMSIG_TURF_HAS_GRAVITY, PROC_REF(turf_gravity_check))

/datum/element/forced_gravity/Detach(datum/source)
	. = ..()
	var/static/list/signals_b_gone = list(COMSIG_ATOM_HAS_GRAVITY, COMSIG_TURF_HAS_GRAVITY)
	UnregisterSignal(source, signals_b_gone)

/datum/element/forced_gravity/proc/gravity_check(datum/source, turf/location, list/gravs)
	gravs += gravity

/datum/element/forced_gravity/proc/turf_gravity_check(datum/source, atom/checker, list/gravs)
	return gravity_check(null, source, gravs)
