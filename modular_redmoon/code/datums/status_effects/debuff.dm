/datum/status_effect/debuff/banditbuffdown
	id = "banditbuffdown"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/banditbuffdown
	effectedstats = list("constitution" = -2, "endurance" = -2, "speed" = -2, "perception" = -4)

/datum/status_effect/debuff/banditbuffdown/process()
	.=..()
	var/area/rogue/our_area = get_area(owner)
	if(!(our_area.town_area))
		owner.remove_status_effect(/datum/status_effect/debuff/banditbuffdown)

/atom/movable/screen/alert/status_effect/debuff/banditbuffdown
	name = "I don't belong here"
	desc = "Алый Предел находится под защитой Десяти! Жжётся!"

/atom/movable/screen/alert/status_effect/emberwine
	name = "Aphrodesiac"
	desc = "The warmth is spreading through my body..."
	icon_state = "emberwine"
	icon = 'modular_redmoon/icons/mob/screen_alert.dmi'

/datum/status_effect/debuff/emberwine
	id = "emberwine"
	effectedstats = list("strength" = -1, "endurance" = -2, "speed" = -2, "intelligence" = -3)
	duration = 1 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/emberwine
