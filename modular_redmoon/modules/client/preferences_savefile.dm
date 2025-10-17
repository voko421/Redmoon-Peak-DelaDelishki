/datum/preferences/proc/redmoon_character_pref_load(savefile/S)	
	S["bark_id"] 										>> bark_id
	S["bark_speed"] 									>> bark_speed
	S["bark_pitch"] 									>> bark_pitch
	S["bark_variance"] 									>> bark_variance
	S["defiant"]										>> defiant

	bark_id = sanitize_inlist(bark_id, GLOB.bark_list, pick(GLOB.bark_random_list))
	var/datum/bark/bark_path = GLOB.bark_list[bark_id]
	bark_speed = sanitize_num_clamp(bark_speed, initial(bark_path.minspeed), initial(bark_path.maxspeed), initial(bark_speed))
	bark_pitch = sanitize_num_clamp(bark_pitch, initial(bark_path.minpitch), initial(bark_path.maxpitch), BARK_PITCH_RAND(gender))
	bark_variance = sanitize_num_clamp(bark_variance, initial(bark_path.minvariance), initial(bark_path.maxvariance), BARK_VARIANCE_RAND)
	defiant	= sanitize_integer(defiant, FALSE, TRUE, TRUE)

/datum/preferences/proc/redmoon_character_pref_save(savefile/S)
	WRITE_FILE(S["bark_id"]								, bark_id)
	WRITE_FILE(S["bark_speed"]							, bark_speed)
	WRITE_FILE(S["bark_pitch"]							, bark_pitch)
	WRITE_FILE(S["bark_variance"]						, bark_variance)
	WRITE_FILE(S["defiant"], defiant)

/datum/preferences/proc/redmoon_save_preferences(savefile/S)
	WRITE_FILE(S["pq_bonus_received"]				, pq_bonus_received)

/datum/preferences/proc/redmoon_load_preferences(savefile/S)
	S["pq_bonus_received"]    						>> pq_bonus_received
