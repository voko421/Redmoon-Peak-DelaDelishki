
// REAL hoods

/obj/item/clothing/head/roguetown/roguehood
	name = "hood"
	desc = ""
	color = CLOTHING_BROWN
	icon_state = "basichood"
	item_state = "basichood"
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = NECK|HAIR|EARS|HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	sleevetype = null
	sleeved = null
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100
	sewrepair = TRUE
	block2add = FOV_BEHIND

/obj/item/clothing/head/roguetown/roguehood/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/adjustable_clothing, NECK, null, null, 'sound/foley/equip/cloak (3).ogg', null, (UPD_HEAD|UPD_MASK))	//Standard hood

/obj/item/clothing/head/roguetown/roguehood/MiddleClick(mob/user) 
	overarmor = !overarmor
	to_chat(user, span_info("I [overarmor ? "wear \the [src] under my hair" : "wear \the [src] over my hair"]."))
	if(overarmor)
		alternate_worn_layer = HOOD_LAYER //Below Hair Layer
	else
		alternate_worn_layer = BACK_LAYER //Above Hair Layer
	user.update_inv_wear_mask()
	user.update_inv_head()

/obj/item/clothing/head/roguetown/roguehood/red
	color = CLOTHING_RED

/obj/item/clothing/head/roguetown/roguehood/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/roguehood/darkgreen
	color = "#264d26"

/obj/item/clothing/head/roguetown/roguehood/random/Initialize()
	color = pick("#544236", "#435436", "#543836", "#79763f")
	..()

/obj/item/clothing/head/roguetown/roguehood/mage/Initialize()
	color = pick("#4756d8", "#759259", "#bf6f39", "#c1b144", "#b8252c")
	..()

/obj/item/clothing/head/roguetown/roguehood/shalal
	name = "keffiyeh"
	desc = "A protective covering worn by those native to the desert."
	color = "#b8252c"
	icon_state = "shalal"
	item_state = "shalal"
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDEEARS
	sleevetype = null
	sleeved = null
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head.dmi' //Overrides slot icon behavior
	alternate_worn_layer  = 8.9 //On top of helmet
	body_parts_covered = HEAD|HAIR|EARS|NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	armor = ARMOR_CLOTHING
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	hidesnoutADJ = TRUE
	blocksound = SOFTHIT
	max_integrity = 100
	sewrepair = TRUE
	mask_override = TRUE
	overarmor = FALSE

/obj/item/clothing/head/roguetown/roguehood/shalal/black
	color = CLOTHING_BLACK

/obj/item/clothing/head/roguetown/roguehood/shalal/purple
	color = CLOTHING_PURPLE

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab
	name = "hijab"
	desc = "Flowing like blood from a wound, this tithe of cloth-and-silk spills out to the shoulders. It carries the telltale mark of Naledian stitcheries."
	item_state = "hijab"
	icon_state = "deserthood"
	hidesnoutADJ = FALSE
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR	//Does not hide face.
	block2add = null

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab/raneshen
	name = "padded headscarf"
	desc = "A common sight amongst those travelling the long desert routes, it offers protection from the heat and a modicum of it against the beasts that prowl its more comfortable nites."
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER //basically the same as a warscholar hood
	item_state = "hijab"
	icon_state = "deserthood"
	naledicolor = TRUE

/obj/item/clothing/head/roguetown/roguehood/shalal/heavyhood
	name = "heavy hood"
	desc = "This thick lump of burlap completely shrouds your head, protecting it from harsh weather and nosey protagonists alike."
	color = CLOTHING_BROWN
	item_state = "heavyhood"
	icon_state = "heavyhood"
	hidesnoutADJ = FALSE

/obj/item/clothing/head/roguetown/roguehood/shalal/hijab/yoruku
	name = "shadowed hood"
	desc = "It sits just so, obscuring the face just enough to spoil recognition."
	color = CLOTHING_BLACK

// Holy Hoods

/obj/item/clothing/head/roguetown/roguehood/astrata
	name = "sun hood"
	desc = "A hood worn by those who favor Astrata. Praise the firstborn sun!"
	color = null
	icon_state = "astratahood"
	item_state = "astratahood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/roguetown/roguehood/abyssor
	name = "depths hood"
	desc = "A hood worn by the followers of Abyssor, with a unique, coral-shaped mask. How do they even see out of this?"
	color = null
	icon_state = "abyssorhood"
	item_state = "abyssorhood"
	icon = 'icons/roguetown/clothing/head.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 100

/obj/item/clothing/head/roguetown/roguehood/ravoxgorget
	name = "ravox's tabard gorget"
	color = null
	icon_state = "ravoxgorget"
	item_state = "ravoxgorget"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDENECK
	dynamic_hair_suffix = ""
	sewrepair = TRUE

//............... Feldshers Hood ............... //
/obj/item/clothing/head/roguetown/roguehood/feld
	name = "feldsher's hood"
	desc = "My cure is most effective."
	icon_state = "feldhood"
	item_state = "feldhood"
	body_parts_covered = HEAD|EARS|NOSE
	color = null

//............... Physicians Hood ............... //
/obj/item/clothing/head/roguetown/roguehood/phys
	name = "physicker's hood"
	desc = "My cure is mostly effective."
	icon_state = "surghood"
	item_state = "surghood"
	body_parts_covered = HEAD|EARS|NOSE
	color = null

//Agnostic variants for use in the loadout.

/obj/item/clothing/head/roguetown/roguehood/shroudscarlet
	name = "scarlet shroud"
	desc = "A billowing hood, carrying the aroma of granulated rosas."
	icon_state = "feldhood"
	item_state = "feldhood"
	body_parts_covered = HEAD|EARS|NOSE
	color = null

/obj/item/clothing/head/roguetown/roguehood/shroudblack
	name = "black shroud"
	desc = "A billowing hood, carrying the aroma of smoldering charcoal."
	icon_state = "surghood"
	item_state = "surghood"
	body_parts_covered = HEAD|EARS|NOSE
	color = null

//

/obj/item/clothing/head/roguetown/roguehood/psydon
	name = "psydonian hood"
	desc = "A hood worn by Psydon's disciples, oft-worn in conjunction with its matching tabard. Made with spell-laced fabric to provide some protection."
	icon_state = "psydonhood"
	item_state = "psydonhood"
	color = null
	blocksound = SOFTHIT
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	body_parts_covered = NECK | HEAD | HAIR
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 200

/obj/item/clothing/head/roguetown/roguehood/psydon/confessor
	name = "confessional hood"
	desc = "A loose-fitting piece of leatherwear that can be tightened on the move. Keeps rain, blood, and the tears of the sullied away."
	icon_state = "confessorhood"
	item_state = "confessorhood"
	color = null
	body_parts_covered = NECK | HEAD | HAIR
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER
	dynamic_hair_suffix = ""
	edelay_type = 1
	adjustable = CAN_CADJUST
	toggle_icon_state = TRUE
	max_integrity = 200

/obj/item/clothing/head/roguetown/roguehood/hierophant
	name = "hierophant's pashmina"
	desc = "A thick hood that covers one's entire head, should they desire, or merely acts as a scarf otherwise. Made with spell-laced fabric to provide some protection against daemons and mortals alike."
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER
	icon_state = "deserthood"
	item_state = "deserthood"
	naledicolor = TRUE

/obj/item/clothing/head/roguetown/roguehood/pontifex
	name = "pontifex's pashmina"
	desc = "A slim hood with thin, yet dense fabric. Stretchy and malleable, allowing for full flexibility and mobility. Made with spell-laced fabric to provide some protection against daemons and mortals alike."
	max_integrity = 100
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = ARMOR_SPELLSINGER
	icon_state = "monkhood"
	item_state = "monkhood"
	naledicolor = TRUE
