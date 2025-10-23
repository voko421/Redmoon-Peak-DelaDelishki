//intent datums ฅ^•ﻌ•^ฅ

/datum/intent/mace/strike
	name = "strike"
	blade_class = BCLASS_BLUNT
	attack_verb = list("strikes", "hits")
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	chargetime = 0
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1
	swingdelay = 0
	icon_state = "instrike"
	item_d_type = "blunt"
	intent_intdamage_factor = BLUNT_DEFAULT_INT_DAMAGEFACTOR

/datum/intent/mace/smash
	name = "smash"
	blade_class = BCLASS_SMASH
	attack_verb = list("smashes")
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	penfactor = BLUNT_DEFAULT_PENFACTOR
	damfactor = 1 // It now has CC effective
	chargedrain = 1 // Slight stamina drain on use
	chargetime = 5 // Half a second of charge for a bit of a warning.
	icon_state = "insmash"
	item_d_type = "blunt"
	intent_intdamage_factor = BLUNT_DEFAULT_INT_DAMAGEFACTOR
	desc = "A powerful, charged up strike that deals normal damage but can throw a standing opponent back and slow them down, based on your strength. Ineffective below 10 strength. Slowdown & Knockback scales to your Strength up to 14 (1 - 4 tiles). Cannot be used consecutively more than every 5 seconds on the same target. Prone targets halve the knockback distance. Not fully charging the attack limits knockback to 1 tile."

/datum/intent/mace/smash/spec_on_apply_effect(mob/living/H, mob/living/user, params)
	var/chungus_khan_str = user.STASTR 
	if(H.has_status_effect(/datum/status_effect/debuff/yeetcd))
		return // Recently knocked back, cannot be knocked back again yet
	if(chungus_khan_str < 10)
		return // Too weak to have any effect
	var/scaling = CLAMP((chungus_khan_str - 10), 1, 4)
	H.apply_status_effect(/datum/status_effect/debuff/yeetcd)
	H.Slowdown(scaling)
	// Copypasta from knockback proc cuz I don't want the math there
	var/knockback_tiles = scaling // 1 to 4 tiles based on strength
	if(H.resting)
		knockback_tiles = max(1, knockback_tiles / 2)
	if(user?.client?.chargedprog < 100)
		knockback_tiles = 1 // Minimal knockback on non-charged smash.
	var/turf/edge_target_turf = get_edge_target_turf(H, get_dir(user, H))
	if(istype(edge_target_turf))
		H.safe_throw_at(edge_target_turf, \
		knockback_tiles, \
		scaling, \
		user, \
		spin = FALSE, \
		force = H.move_force)
// Do not call handle_knockback like in knockback cuz that means it will hardstun

/datum/intent/mace/rangedthrust
	name = "thrust"
	blade_class = BCLASS_STAB
	attack_verb = list("thrusts")
	animname = "stab"
	icon_state = "instab"
	reach = 2
	clickcd = CLICK_CD_CHARGED
	recovery = 30
	warnie = "mobwarning"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	penfactor = 25
	damfactor = 0.9
	item_d_type = "stab"

//blunt objs ฅ^•ﻌ•^ฅ

/obj/item/rogueweapon/mace
	force = 20
	force_wielded = 25
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/effect/daze)
	name = "mace"
	desc = "Helps anyone fall asleep."
	icon_state = "mace"
	icon = 'icons/roguetown/weapons/blunt32.dmi'
	item_state = "mace_greyscale"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP | ITEM_SLOT_BACK
	associated_skill = /datum/skill/combat/maces
	anvilrepair = /datum/skill/craft/weaponsmithing
	smeltresult = /obj/item/ingot/iron
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED
	minstr = 7
	wdefense = 2
	wbalance = WBALANCE_HEAVY
	icon_angle_wielded = 50

/obj/item/rogueweapon/mace/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -11,"sy" = -8,"nx" = 12,"ny" = -8,"wx" = -5,"wy" = -8,"ex" = 6,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.7,"sx" = 5,"sy" = -4,"nx" = -5,"ny" = -4,"wx" = -5,"wy" = -3,"ex" = 7,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -45,"sturn" = 45,"wturn" = -45,"eturn" = 45,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/mace/alloy
	name = "decrepit mace"
	desc = "Frayed bronze, perched atop a rotwooden shaft. His sacrifice had drowned Old Syon, and - in its wake - left Man bereft of all it had accomplished. With all other prayers falling upon deaf ears, Man had crafted this idol in tribute to its new God; violence."
	icon_state = "amace"
	force = 17
	force_wielded = 21
	max_integrity = 180
	blade_dulling = DULLING_SHAFT_CONJURED
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null


/obj/item/rogueweapon/mace/church
	force = 25
	force_wielded = 30
	name = "bell ringer"
	desc = "This heavy hammer is used to ring the church's bell."
	icon_state = "churchmace"
	wbalance = WBALANCE_HEAVY
	smeltresult = /obj/item/ingot/steel
	wdefense = 3

/obj/item/rogueweapon/mace/steel
	force = 25
	force_wielded = 32
	name = "steel mace"
	desc = "This steel mace is objectively superior to an iron one."
	icon_state = "smace"
	wbalance = WBALANCE_HEAVY
	smeltresult = /obj/item/ingot/steel
	wdefense = 3
	smelt_bar_num = 2

/obj/item/rogueweapon/mace/steel/palloy
	name = "ancient alloy mace"
	desc = "Polished gilbranze, perched atop a reinforced shaft. Break the unenlightened into naught-but-giblets; like a potter's vessels, dashed against the rocks."
	icon_state = "amace"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/rogueweapon/mace/steel/silver
	force = 30
	force_wielded = 35
	name = "silver mace"
	desc = "A heavy flanged mace, forged from pure silver. For a lord, it's the perfect symbol of authority; a decorative piece for the courts. For a paladin, however, there's no better implement for shattering avantyne-maille into a putrid pile of debris."
	icon_state = "silvermace"
	wbalance = WBALANCE_HEAVY
	smeltresult = /obj/item/ingot/silver
	minstr = 10
	wdefense = 5
	smelt_bar_num = 2
	is_silver = TRUE

/obj/item/rogueweapon/mace/steel/silver/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_NONE,\
		silver_type = SILVER_TENNITE,\
		added_force = 0,\
		added_blade_int = 100,\
		added_int = 50,\
		added_def = 2,\
	)

/obj/item/rogueweapon/mace/woodclub
	force = 15
	force_wielded = 18
	name = "wooden club"
	desc = "A primitive cudgel carved of a stout piece of treefall."
	icon_state = "club1"
	//dropshrink = 0.75
	wbalance = WBALANCE_NORMAL
	wdefense = 1
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/mace/strike/wood, /datum/intent/mace/smash/wood)
	smeltresult = /obj/item/ash
	anvilrepair = /datum/skill/craft/carpentry
	minstr = 7
	resistance_flags = FLAMMABLE

/obj/item/rogueweapon/mace/woodclub/New()
	..()
	icon_state = "club[rand(1,2)]"

/datum/intent/mace/strike/wood
	hitsound = list('sound/combat/hits/blunt/woodblunt (1).ogg', 'sound/combat/hits/blunt/woodblunt (2).ogg')
	penfactor = BLUNT_DEFAULT_PENFACTOR

/datum/intent/mace/smash/wood
	hitsound = list('sound/combat/hits/blunt/woodblunt (1).ogg', 'sound/combat/hits/blunt/woodblunt (2).ogg')
	penfactor = BLUNT_DEFAULT_PENFACTOR

/datum/intent/mace/smash/wood/ranged
	reach = 2

/obj/item/rogueweapon/mace/cudgel
	name = "cudgel"
	desc = "A stubby little club for brigands or thieves. Attempting parries with this is a bad idea."
	force = 25
	icon_state = "cudgel"
	force_wielded = 25
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash)
	smeltresult = /obj/item/ash
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_NORMAL
	wbalance = WBALANCE_NORMAL
	minstr = 7
	wdefense = 1
	resistance_flags = FLAMMABLE
	grid_width = 32
	grid_height = 96

/obj/item/rogueweapon/mace/cudgel/psy
	name = "psydonic handmace"
	desc = "A shorter variant of the flanged silver mace, rebalanced for one-handed usage. It isn't uncommon for these sidearms to mysteriously 'vanish' from an Adjudicator's belt, only to be 'rediscovered' - and subsequently kept - by a Confessor."
	force = 25
	force_wielded = 30
	minstr = 9
	wdefense = 5
	wbalance = WBALANCE_SWIFT
	resistance_flags = FIRE_PROOF
	icon_state = "psyflangedmace"
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silverblessed

/obj/item/rogueweapon/mace/cudgel/psy/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_NONE,\
		silver_type = SILVER_PSYDONIAN,\
		added_force = 0,\
		added_blade_int = 100,\
		added_int = 50,\
		added_def = 1,\
	)

/obj/item/rogueweapon/mace/cudgel/psy/preblessed/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_PSYDONIAN,\
		silver_type = SILVER_PSYDONIAN,\
		added_force = 0,\
		added_blade_int = 100,\
		added_int = 50,\
		added_def = 1,\
	)

/obj/item/rogueweapon/mace/cudgel/psy/old
	name = "enduring handmace"
	desc = "A shorthanded mace and convenient sleeping aid, its grown harder to swing with age, though it hasn't lost reliability."
	force = 20
	wbalance = WBALANCE_NORMAL
	icon_state = "opsyflangedmace"

/obj/item/rogueweapon/mace/cudgel/copper
	name = "copper bludgeon"
	desc = "An extremely crude weapon for cruder bastards."
	force = 15
	icon_state = "cbludgeon"
	force_wielded = 20
	smeltresult = /obj/item/ingot/copper
	wdefense = 2

/obj/item/rogueweapon/mace/cudgel/justice
	name = "'Justice'"
	desc = "The icon of the right of office of the Marshal. While mostly ceremonial in design, it serves it's purpose in dishing out some much needed justice."
	force = 30
	icon_state = "justice"
	force_wielded = 30
	gripped_intents = list(/datum/intent/mace/strike,/datum/intent/mace/smash)
	smeltresult = /obj/item/ingot/steel
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_NORMAL
	wbalance = WBALANCE_SWIFT
	resistance_flags = FIRE_PROOF
	minstr = 7
	wdefense = 5

/obj/item/rogueweapon/mace/cudgel/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -8,"sy" = -7,"nx" = 10,"ny" = -7,"wx" = -1,"wy" = -8,"ex" = 1,"ey" = -7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 91,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -3,"sy" = -4,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 70,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 1,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/mace/wsword
	name = "wooden sword"
	desc = "This wooden sword is great for training."
	force = 5
	force_wielded = 8
	icon_state = "wsword"
	//dropshrink = 0.75
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/mace/strike/wood, /datum/intent/mace/smash/wood)
	smeltresult = /obj/item/ash
	minstr = 7
	wdefense = 5
	wbalance = WBALANCE_NORMAL
	associated_skill = /datum/skill/combat/swords
	anvilrepair = /datum/skill/craft/carpentry
	resistance_flags = FLAMMABLE


/obj/item/rogueweapon/mace/wsword/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,
"sx" = -15,
"sy" = -12,
"nx" = 9,
"ny" = -11,
"wx" = -11,
"wy" = -11,
"ex" = 1,
"ey" = -12,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 90,
"sturn" = -90,
"wturn" = -90,
"eturn" = 90,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,
"sx" = -15,
"sy" = -1,
"nx" = 10,
"ny" = 0,
"wx" = -13,
"wy" = -1,
"ex" = 2,
"ey" = -1,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = 0,
"sturn" = 0,
"wturn" = 0,
"eturn" = 0,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/rogueweapon/mace/goden
	force = 15
	force_wielded = 30
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/mace/rangedthrust, /datum/intent/effect/daze)
	name = "Goedendag"
	desc = "Good morning."
	icon_state = "goedendag"
	icon = 'icons/roguetown/weapons/64.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_BULKY
	associated_skill = /datum/skill/combat/maces
	smeltresult = /obj/item/ash
	swingsound = BLUNTWOOSH_MED
	minstr = 10
	wdefense = 3
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	dropshrink = 0.6
	bigboy = TRUE
	gripsprite = TRUE

/obj/item/rogueweapon/mace/goden/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -7,"sy" = 2,"nx" = 7,"ny" = 3,"wx" = -2,"wy" = 1,"ex" = 1,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 37,"wturn" = 30,"eturn" = -30,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 5,"sy" = -3,"nx" = -5,"ny" = -2,"wx" = -5,"wy" = -1,"ex" = 3,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 7,"sturn" = -7,"wturn" = 16,"eturn" = -22,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/mace/goden/aalloy
	name = "decrepit grand mace"
	desc = "Good nite, sire."
	force = 12
	force_wielded = 22
	icon_state = "ancient_supermace"
	blade_dulling = DULLING_SHAFT_CONJURED
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null

/obj/item/rogueweapon/mace/goden/steel
	name = "grand mace"
	desc = "Good morning, sire."
	icon_state = "polemace"
	force = 15
	force_wielded = 35
	smeltresult = /obj/item/ingot/steel
	smelt_bar_num = 2
	wdefense_wbonus = 5

/obj/item/rogueweapon/mace/goden/steel/paalloy
	name = "ancient grand mace"
	desc = "A twisting polehammer, forged in polished gilbranze. What did you think this was all about? This destruction, this war, this sacrifice; it was all to prepare Man for its true ascension."
	icon_state = "ancient_supermace"
	smeltresult = /obj/item/ingot/aaslag


/obj/item/rogueweapon/mace/goden/deepduke
	name = "deep duke's staff"
	desc = "A staff made of seaglass and sturdy but unusual metal, holding no power after its misled owner's death. More useful as a bashing tool than a magic focus."
	icon = 'icons/roguetown/mob/monster/pufferboss.dmi'
	icon_state = "pufferprod"
	force = 15
	force_wielded = 35
	minstr = 11
	max_integrity = 900
	smeltresult = /obj/item/ingot/steelholy
	smelt_bar_num = 2

/obj/item/rogueweapon/mace/goden/kanabo
	name = "kanabo"
	desc = "A steel-banded wooden club, made to break the enemy in spirit as much as in flesh. One of the outliers among the many more elegant weapons of Kazengun."
	icon_state = "kanabo"
	slot_flags = ITEM_SLOT_BACK
	gripped_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/stab, /datum/intent/effect/daze)
	max_integrity = 225 // it's strong wood, but it's still wood.

/obj/item/rogueweapon/mace/goden/steel/ravox
	name = "duel settler"
	desc = "The tenets of ravoxian duels are enscribed upon the head of this maul."
	icon_state = "ravoxhammer"
	gripped_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/effect/daze) // It loses the Goden stab so I give it daze
	max_integrity = 350 // I am reluctant to give a steel goden more force as it breaks weapon so durability it is.

/obj/item/rogueweapon/mace/goden/psymace
	name = "psydonic mace"
	desc = "An ornate mace, plated in a ceremonial veneer of silver. Even the unholy aren't immune to discombobulation."
	icon_state = "psymace"
	force = 30
	force_wielded = 35
	minstr = 12
	wdefense = 6
	wbalance = WBALANCE_HEAVY
	dropshrink = 0.75
	smelt_bar_num = 2
	is_silver = TRUE
	smeltresult = /obj/item/ingot/silverblessed

/obj/item/rogueweapon/mace/goden/psymace/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_NONE,\
		silver_type = SILVER_PSYDONIAN,\
		added_force = 0,\
		added_blade_int = 0,\
		added_int = 50,\
		added_def = 1,\
	)

/obj/item/rogueweapon/mace/goden/psymace/old
	name = "enduring mace"
	desc = "An ornate mace, its silver tarnished by neglect. Even without HIS holy blessing, its weight ENDURES."
	icon_state = "psymace"
	force = 15
	force_wielded = 30
	minstr = 10
	wdefense = 3
	is_silver = FALSE
	smeltresult = /obj/item/ingot/steel
	color = COLOR_FLOORTILE_GRAY

/obj/item/rogueweapon/mace/goden/psymace/old/ComponentInitialize()
	return

/obj/item/rogueweapon/mace/spiked
	icon_state = "spiked_club"

/obj/item/rogueweapon/mace/steel/morningstar
	icon_state = "morningstar"

/obj/item/rogueweapon/mace/warhammer
	force = 20
	possible_item_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/mace/warhammer/pick)
	gripped_intents = null
	name = "warhammer"
	desc = "Made to punch through armor and skull alike."
	icon_state = "iwarhammer"
	wbalance = WBALANCE_HEAVY
	smeltresult = /obj/item/ingot/iron
	wdefense = 3

/obj/item/rogueweapon/mace/warhammer/alloy
	name = "decrepit warhammer"
	desc = "A macehead of frayed bronze, spiked and perched atop a thin shaft. To see such a knightly implement abandoned to decay and neglect; that wounds the heart greater than any well-poised strike."
	icon_state = "awarhammer"
	force = 17
	max_integrity = 180
	blade_dulling = DULLING_SHAFT_CONJURED
	color = "#bb9696"
	smeltresult = /obj/item/ingot/aaslag
	anvilrepair = null

/obj/item/rogueweapon/mace/warhammer/steel
	force = 25
	possible_item_intents = list(/datum/intent/mace/strike, /datum/intent/mace/smash, /datum/intent/mace/warhammer/pick, /datum/intent/mace/warhammer/stab)
	name = "steel warhammer"
	desc = "A fine steel warhammer, makes a satisfying sound when paired with a knight's helm."
	icon_state = "swarhammer"
	smeltresult = /obj/item/ingot/steel
	wdefense = 4

/obj/item/rogueweapon/mace/warhammer/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -9,"sy" = -8,"nx" = 9,"ny" = -7,"wx" = -7,"wy" = -8,"ex" = 3,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = 3,"sy" = -7,"nx" = -6,"ny" = -3,"wx" = 3,"wy" = -4,"ex" = 4,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -44,"sturn" = 45,"wturn" = 47,"eturn" = 33,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
	return ..()

/obj/item/rogueweapon/mace/warhammer/steel/paalloy
	name = "ancient alloy warhammer"
	desc = "A macehead of polished gilbranze, spiked and perched atop a reinforced shaft. An elegant weapon from a more civilized age; when Man lived in harmony with one-another, and when 'the undying' was nothing more than a nitemare's thought."
	icon_state = "awarhammer"
	smeltresult = /obj/item/ingot/aaslag

/obj/item/rogueweapon/mace/warhammer/steel/silver
	name = "silver warhammer"
	desc = "A heavy warhammer, forged from pure silver. It follows the Otavan design of a 'lucerene'; a shortened polehammer with a pronounced spike, rebalanced for one-handed usage. Resplendent in presentation, righteous in purpose."
	icon_state = "silverhammer"
	force = 30
	force_wielded = 30
	minstr = 10
	wdefense = 5
	smeltresult = /obj/item/ingot/silver
	smelt_bar_num = 2
	is_silver = TRUE

/obj/item/rogueweapon/mace/warhammer/steel/silver/ComponentInitialize()
	AddComponent(\
		/datum/component/silverbless,\
		pre_blessed = BLESSING_NONE,\
		silver_type = SILVER_TENNITE,\
		added_force = 0,\
		added_blade_int = 100,\
		added_int = 50,\
		added_def = 2,\
	)


/datum/intent/mace/warhammer/stab
	name = "thrust"
	icon_state = "instab"
	blade_class = BCLASS_STAB
	attack_verb = list("thrusts", "stabs")
	animname = "stab"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	no_early_release = TRUE
	penfactor = 20
	damfactor = 0.8
	item_d_type = "stab"

/datum/intent/mace/warhammer/pick
	name = "pick"
	icon_state = "inpick"
	blade_class = BCLASS_PICK
	attack_verb = list("picks", "impales")
	animname = "stab"
	hitsound = list('sound/combat/hits/blunt/metalblunt (1).ogg', 'sound/combat/hits/blunt/metalblunt (2).ogg', 'sound/combat/hits/blunt/metalblunt (3).ogg')
	misscost = 1
	swingdelay = 15
	clickcd = 15
	penfactor = 80
	damfactor = 0.9
	item_d_type = "stab"
