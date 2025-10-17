/datum/triumph_buy/migrant_wave
	triumph_buy_id = "migrant_wave"
	desc = "Призвать волну определённых мигрантов!"
	triumph_cost = 50
	category = TRIUMPH_CAT_ROUND_EFX

/datum/triumph_buy/migrant_wave/on_activate(mob/living/carbon/human/H)
	if(!usr)
		return
	. = TRUE
	var/mob/user = usr
	message_admins("[key_name_admin(user)] is forcing the next migrant wave.")
	var/migrants = list("Bandits (4 fools)", "Fablefields (4 fools)", "Heartfelts (6 fools)", "Piligrims (4 fools)", \
	"The Knightly Journey (2 fools)", "Grenzelhoftian Envoy (4 fools)", "Ranesheni Emir (4 fools)")
	var/picked_wave_type = input(user, "Choose migrant wave to force:", "Migrants")  as null|anything in migrants
	switch(picked_wave_type)
		if("Bandits (4 fools)")
			picked_wave_type = /datum/migrant_wave/bandit
		if("Fablefields (4 fools)")
			picked_wave_type = /datum/migrant_wave/fablefield
		if("Heartfelts (6 fools)")
			picked_wave_type = /datum/migrant_wave/heartfelt
		if("Piligrims (4 fools)")
			picked_wave_type = /datum/migrant_wave/pilgrim
		if("The Knightly Journey (2 fools)")
			picked_wave_type = /datum/migrant_wave/knightly_journey
		if("Grenzelhoftian Envoy (4 fools)")
			picked_wave_type = /datum/migrant_wave/grenzel_envoy
		if("Ranesheni Emir (4 fools)")
			picked_wave_type = /datum/migrant_wave/ranesheni_noble
	if(!picked_wave_type)
		SStriumphs.triumph_adjust(50, user.ckey)
		return
	message_admins("[key_name_admin(user)] forced next migrant wave: [picked_wave_type] (Arrival: 1 Minute)")
	log_game("[key_name_admin(user)] forced next migrant wave: [picked_wave_type] (Arrival: 1 Minute)")
	SSmigrants.set_current_wave(picked_wave_type, (1 MINUTES))
