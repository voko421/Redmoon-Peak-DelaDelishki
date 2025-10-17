// /datum/triumph_buy/grenzelhoft_maximum
// 	triumph_buy_id = "Grenzelhoftmaxx"
// 	desc = "Все становятся людьми!"
// 	triumph_cost = 250
// 	category = TRIUMPH_CAT_ROUND_EFX
// 	pre_round_only = TRUE
// 	visible_on_active_menu = TRUE

// /datum/triumph_buy/grenzelhoft_maximum/on_buy()
// 	SStriumphs.post_equip_calls[triumph_buy_id] = src
// 	to_chat(world, span_redtext("Благодаря усилиям [usr] Алый Предел наконец-то переходит во владения Королевства Гренцельхофт. И первым же решением оказалось выселение абсолютно всех нелюдей в Зибантию. Удивительно."))

// /datum/triumph_buy/grenzelhoft_maximum/on_removal()
// 	var/found_duplicate = FALSE
// 	for(var/datum/triumph_buy/cur_datum in SStriumphs.active_triumph_buy_queue)
// 		if(cur_datum.category != TRIUMPH_CAT_ROUND_EFX)
// 			continue
// 		if(cur_datum == src)
// 			continue
// 		if(istype(cur_datum, src.type))
// 			found_duplicate = TRUE

// 	// We found no same type effects in there outside of us
// 	if(!found_duplicate) 
// 		SStriumphs.post_equip_calls.Remove(triumph_buy_id)

// /datum/triumph_buy/grenzelhoft_maximum/on_activate(mob/living/carbon/human/H)
// 	if(is_species(H, /datum/species/goblin))
// 		return
// 	if(is_species(H, /datum/species/halforc))
// 		return
// 	if(is_species(H, /datum/species/kobold))
// 		return
// 	if(is_species(H, /datum/species/dwarf/mountain))
// 		return
// 	if(is_species(H, /datum/species/aasimar))
// 		return
// 	if(is_species(H, /datum/species/human/northern))
// 		return
// 	H.set_species(/datum/species/human/northern, FALSE)
// 	H.client?.prefs.headshot_link = null
// 	H.client?.prefs.customizer_entries = list()
// 	H.client?.prefs.validate_customizer_entries()
// 	H.client?.prefs.reset_all_customizer_accessory_colors()
// 	H.client?.prefs.randomize_all_customizer_accessories()
// 	H.client?.prefs.reset_descriptors()
// 	var/acceptable = list("Tomboy", "Bob", "Curly Short")
// 	H.hairstyle = pick(acceptable)
// 	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
// 	var/num = rand(0, 6)
// 	switch(num)
// 		if(0)
// 			set_eye_color(H, "#865900", "#865900")
// 		if(1)
// 			set_eye_color(H, "#06b400", "#06b400")
// 		if(2)
// 			set_eye_color(H, "#312f27", "#312f27")
// 		if(3)
// 			set_eye_color(H, "#008e83", "#008e83")
// 		if(4)
// 			set_eye_color(H, "#002d8e", "#002d8e")
// 		if(5)
// 			set_eye_color(H, "#c16c00", "#c16c00")
// 		else
// 			set_eye_color(H, "#ff0000", "#ff0000")
// 	eyes.update_accessory_colors()
// 	var/datum/bodypart_feature/hair/head/hair = new()
// 	var/num2 = rand(0, 5)
// 	switch(num2)
// 		if(0)
// 			hair.set_accessory_type(/datum/sprite_accessory/hair/head/bob, "#262222", H)
// 		if(1)
// 			hair.set_accessory_type(/datum/sprite_accessory/hair/head/boddicker, "#262222", H)
// 		if(2)
// 			hair.set_accessory_type(/datum/sprite_accessory/hair/head/braided, "#262222", H)
// 		if(3)
// 			hair.set_accessory_type(/datum/sprite_accessory/hair/head/lowbun, "#262222", H)
// 		if(4)
// 			hair.set_accessory_type(/datum/sprite_accessory/hair/head/largebun, "#262222", H)
// 		else
// 			hair.set_accessory_type(/datum/sprite_accessory/hair/head/combover, "#262222", H)
// 	H.update_body()
// 	H.update_hair()
// 	H.update_body_parts()
// 	 // Yeah, you gotta do this after setting species haha! theres an after_creation() proc that goes with set_species and this handles the stats in it.
// 	H.roll_stats()
