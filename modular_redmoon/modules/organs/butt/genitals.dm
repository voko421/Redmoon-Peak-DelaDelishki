// ORGAN

/obj/item/organ/butt
	name = "butt"
	icon = 'modular_redmoon/icons/surgery.dmi'
	icon_state = "butt"
	dropshrink = 0.5
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_STOMACH
	slot = ORGAN_SLOT_BUTT
	organ_dna_type = /datum/organ_dna/butt
	accessory_type = /datum/sprite_accessory/butt/pair
	var/butt_size = DEFAULT_BUTT_SIZE

/obj/item/organ/butt/internal
	name = "internal butt"
	visible_organ = FALSE
	accessory_type = /datum/sprite_accessory/none

// ORGAN DNA

/datum/organ_dna/butt
	var/butt_size = DEFAULT_BUTT_SIZE

/datum/organ_dna/butt/imprint_organ(obj/item/organ/organ)
	..()
	var/obj/item/organ/butt/butt_organ = organ
	butt_organ.butt_size = butt_size

// CUSTOMIZER

/datum/customizer_entry/organ/butt
	var/butt_size = DEFAULT_BUTT_SIZE

/datum/customizer/organ/butt
	abstract_type = /datum/customizer/organ/butt
	name = "Butt"
	allows_disabling = TRUE
	default_disabled = TRUE

/datum/customizer_choice/organ/butt
	abstract_type = /datum/customizer_choice/organ/butt
	name = "Butt"
	customizer_entry_type = /datum/customizer_entry/organ/butt
	organ_type = /obj/item/organ/butt
	organ_slot = ORGAN_SLOT_BUTT
	organ_dna_type = /datum/organ_dna/butt

/datum/customizer_choice/organ/butt/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	butt_entry.butt_size = sanitize_integer(butt_entry.butt_size, MIN_BUTT_SIZE, MAX_BUTT_SIZE, DEFAULT_BUTT_SIZE)

/datum/customizer_choice/organ/butt/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/butt/butt_dna = organ_dna
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	butt_dna.butt_size = butt_entry.butt_size

/datum/customizer_choice/organ/butt/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	dat += "<br>Butt size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=butt_size''>[find_key_by_value(GLOB.named_butt_sizes, butt_entry.butt_size)]</a>"

/datum/customizer_choice/organ/butt/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	switch(href_list["customizer_task"])
		if("butt_size")
			var/named_size = input(user, "Choose your butt size:", "Character Preference", find_key_by_value(GLOB.named_butt_sizes, butt_entry.butt_size)) as anything in GLOB.named_butt_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_butt_sizes[named_size]
			butt_entry.butt_size = sanitize_integer(new_size, MIN_BUTT_SIZE, MAX_BUTT_SIZE, DEFAULT_BUTT_SIZE)

/datum/customizer/organ/butt/human
	customizer_choices = list(/datum/customizer_choice/organ/butt/human)

/datum/customizer_choice/organ/butt/human
	sprite_accessories = list(/datum/sprite_accessory/butt/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/butt/animal
	customizer_choices = list(/datum/customizer_choice/organ/butt/animal)

/datum/customizer_choice/organ/butt/animal
	sprite_accessories = list(
		/datum/sprite_accessory/butt/pair
		)

// SPRITE

/datum/sprite_accessory/butt
	icon = 'modular_redmoon/icons/butt.dmi'
	color_key_name = "Butt"
	relevant_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/butt/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!isdwarf(owner) && !isgoblinp(owner) && !iskobold(owner) && !isvermin(owner))
		generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_PANTS, OFFSET_PANTS_F)
	else
		generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BUTT, OFFSET_BUTT)

/datum/sprite_accessory/butt/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	var/obj/item/organ/butt/buttie = organ
	return "butt_[icon_state]_[buttie.butt_size]"

/datum/sprite_accessory/butt/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	var/obj/item/organ/butt/buttie = organ
	if(owner.underwear)
		return FALSE
	if(!buttie.visible_organ)
		return FALSE
	return is_human_part_visible(owner, HIDEJUMPSUIT|HIDECROTCH)

/datum/sprite_accessory/butt/pair
	name = "Pair"
	icon_state = "pair"
	color_key_defaults = list(KEY_SKIN_COLOR)

/obj/item/organ/penis/human
	name = "human penis"
	penis_type = PENIS_TYPE_PLAIN
	sheath_type = SHEATH_TYPE_NONE

/datum/customizer_choice/organ/penis/human
	organ_type = /obj/item/organ/penis/human

/datum/customizer_choice/organ/penis/human_anthro
	organ_type = /obj/item/organ/penis/human
