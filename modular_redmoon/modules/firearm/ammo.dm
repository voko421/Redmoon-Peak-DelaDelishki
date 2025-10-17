/obj/item/quiver/bullet
	name = "Ammo Bag"
	desc = "Небольшой мешочек, в котором хранятся пули для огнестрельного оружия."
	icon = 'modular_redmoon/icons/obj/ammo.dmi'
	icon_state = "pouch1"
	item_state = "pouch1"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 30
	var/ammo_type = /obj/item/ammo_casing/caseless/lead

/obj/item/quiver/bullet/update_icon()
	if(arrows.len)
		icon_state = "pouch1"
	else
		icon_state = "pouch0"

/obj/item/quiver/bullet/attack_turf(turf/T, mob/living/user)
	if(arrows.len >= max_storage)
		to_chat(user, span_warning("My [src.name] is full!"))
		return
	to_chat(user, span_notice("I begin to gather the ammunition..."))
	for(var/obj/item/ammo_casing/caseless/lead/arrow in T.contents)
		if(do_after(user, 5))
			if(!eatarrow(arrow))
				break

/obj/item/quiver/bullet/eatarrow(obj/A)
	if(A.type in typesof(ammo_type))
		if(arrows.len < max_storage)
			A.forceMove(src)
			arrows += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/quiver/bullet/attack_self(mob/living/user)
	..()

	if (!arrows.len)
		return
	to_chat(user, span_warning("I begin to take out the ammo from [src], one by one..."))
	for(var/obj/item/ammo_casing/caseless/arrow in arrows)
		if(!do_after(user, 0.5 SECONDS))
			return
		arrow.forceMove(user.loc)
		arrows -= arrow

	update_icon()

/obj/item/quiver/bullet/attackby(obj/A, loc, params)
	if(A.type in typesof(ammo_type))
		if(arrows.len < max_storage)
			if(ismob(loc))
				var/mob/M = loc
				M.doUnEquip(A, TRUE, src, TRUE, silent = TRUE)
			else
				A.forceMove(src)
			arrows += A
			update_icon()
		else
			to_chat(loc, span_warning("Full!"))
		return
	if(istype(A, /obj/item/gun/ballistic/revolver/grenadelauncher/runelock))
		var/obj/item/gun/ballistic/revolver/grenadelauncher/runelock/B = A
		if(arrows.len && !B.chambered && B.cocked)
			for(var/AR in arrows)
				if(istype(AR, /obj/item/ammo_casing/caseless/runelock))
					arrows -= AR
					B.attackby(AR, loc, params)
					break
		return
	..()

/obj/item/quiver/bullet/runed/Initialize()
	. = ..()
	for(var/i in 1 to 6)
		var/obj/item/ammo_casing/caseless/runelock/R = new()
		arrows += R
	update_icon()

/obj/item/quiver/bullet/lead/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/lead/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/bullet/grapeshot/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/grapeshot/B = new()
		arrows += B
	update_icon()

/obj/item/quiver/bullet/bomb
	name = "bomb pouch"
	icon_state = "pouch0"
	item_state = "pouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 6
	ammo_type = list(/obj/item/bomb/smoke)
	color = "#b5b5b5"

/obj/item/quiver/bullet/bomb/smokebombs/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/bomb/smoke/A = new()
		arrows += A
	update_icon()

#define RUNELOCK_DAMAGE		120
#define LEAD_DAMAGE			225
#define GRAPE_DAMAGE		45 
#define BULLET_PENETRATION	60

/obj/item/ammo_casing/caseless/runelock
	name = "runed sphere"
	desc = "A small iron ball, perfectly round and covered in Psydonite runes. Deadly when projected at very high velocity."
	projectile_type = /obj/projectile/bullet/reusable/runelock
	caliber = "runed_sphere"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0
	w_class = WEIGHT_CLASS_TINY
	smeltresult = /obj/item/rogueore/iron

/obj/projectile/bullet/reusable/runelock
	name = "runed sphere"
	damage = RUNELOCK_DAMAGE
	armor_penetration = BULLET_PENETRATION
	speed = 0.6
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	ammo_type = /obj/item/ammo_casing/caseless/runelock
	range = 30
	hitsound = 'sound/combat/hits/hi_bolt (2).ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"

/**
 * Generic ammo used by handgonnes and arquebuses
 */

/obj/projectile/bullet/lead
	name = "lead sphere"
	damage = LEAD_DAMAGE
	armor_penetration = BULLET_PENETRATION
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/lead
	range = 25		//Higher than arrow, but not halfway through the entire town.
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.1		

/obj/projectile/bullet/lead/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 5

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/firearms, SKILL_LEVEL_LEGENDARY))
		L.mind.add_sleep_experience(/datum/skill/combat/firearms, L.STAINT * skill_multiplier)

/obj/projectile/bullet/grapeshot
	name = "grapeshot"
	damage = GRAPE_DAMAGE
	armor_penetration = BULLET_PENETRATION
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/lead
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.1		

/obj/projectile/bullet/grapeshot/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 5

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/firearms, SKILL_LEVEL_LEGENDARY))
		L.mind.add_sleep_experience(/datum/skill/combat/firearms, L.STAINT * skill_multiplier)

/obj/projectile/bullet/rogue/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/M = target
		var/list/screams = list("painscream", "paincrit")
		var/check = rand(1, 20)
		if(isliving(target))
			if(check > M.STACON)
				M.emote(screams)
				M.Knockdown(rand(15,30))
				M.Immobilize(rand(30,60))


/obj/item/ammo_casing/caseless/lead
	name = "lead sphere"
	desc = "A small lead sphere. This should go well with gunpowder."
	projectile_type = /obj/projectile/bullet/lead
	caliber = "lead_sphere"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	max_integrity = 0.1

/obj/item/ammo_casing/caseless/grapeshot
	name = "grapeshot"
	desc = "A collection of tiny metal beads. This should go well with gunpowder."
	projectile_type = /obj/projectile/bullet/grapeshot
	caliber = "grapeshot"
	icon = 'modular_redmoon/icons/obj/ammo.dmi'
	icon_state = "grapeshot"
	dropshrink = 0.5
	max_integrity = 0.1
	pellets = 6
	variance = 30

/obj/item/powderflask/artificer
	name = "Mechanised Powderflask"
	icon = 'modular_redmoon/icons/obj/32.dmi'
	desc = "A neatly engineered gunpowder flask that compresses powder for size decreasement and cuts it for you so you dont have to measure it that much."
	icon_state = "engiflask"
	item_state = "powderflask"
	slot_flags = SLOT_BELT_L | SLOT_BELT_R | ITEM_SLOT_NECK | ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_SMALL
	grid_height = 64
	grid_width = 32
