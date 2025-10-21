/obj/effect/proc_holder/spell/invoked/song
	var/song_tier = 1
	sound = list('sound/magic/buffrollaccent.ogg')
	overlay_icon = 'icons/mob/actions/bardsongs.dmi'
	overlay_state = "dirge_t1_base"
	action_icon_state = "dirge_t1_base"
	action_icon = 'icons/mob/actions/bardsongs.dmi'
	warnie = "spellwarning"
	releasedrain = 60
	chargedrain = 1
	chargetime = 0
	no_early_release = TRUE
	recharge_time = 2 MINUTES
	movement_interrupt = FALSE


/datum/status_effect/buff/playing_dirge
	id = "play_dirge"
	alert_type = /atom/movable/screen/alert/status_effect/buff/playing_dirge
	var/effect_color
	var/datum/status_effect/debuff/debuff_to_apply
	var/pulse = 0
	var/ticks_to_apply = 10
	duration = -1
	var/obj/effect/temp_visual/songs/effect = /obj/effect/temp_visual/songs/inspiration_dirget1


/atom/movable/screen/alert/status_effect/buff/playing_dirge
	name = "Playing Dirge"
	desc = "Terrorizing the world with my craft."
	icon_state = "buff"


/datum/status_effect/buff/playing_dirge/tick()
	var/mob/living/carbon/human/O = owner
	if(!O.inspiration)
		return
	pulse += 1
	new effect(get_turf(owner))
	if (pulse >= ticks_to_apply)
		pulse = 0
		O.energy_add(-25)
		for (var/mob/living/carbon/human/H in hearers(10, owner))
			if(!O.in_audience(H))
				H.apply_status_effect(debuff_to_apply)


/datum/status_effect/buff/playing_melody
	id = "play_melody"
	alert_type = /atom/movable/screen/alert/status_effect/buff/playing_melody
	var/effect_color
	var/datum/status_effect/buff/buff_to_apply
	var/pulse = 0
	var/ticks_to_apply = 10
	duration = -1
	var/obj/effect/temp_visual/songs/effect = /obj/effect/temp_visual/songs/inspiration_melodyt1


/atom/movable/screen/alert/status_effect/buff/playing_melody
	name = "Playing Melody"
	desc = "Healing the world with my craft."
	icon_state = "buff"


/datum/status_effect/buff/playing_melody/tick()
	var/mob/living/carbon/human/O = owner
	if(!O.inspiration)
		return
	new effect(get_turf(owner))
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		O.energy_add(-25)
		for (var/mob/living/carbon/human/H in hearers(10, owner))
			if(O.in_audience(H))
				H.apply_status_effect(buff_to_apply)
