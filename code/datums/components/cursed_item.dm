/datum/component/cursed_item
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/required_trait //trait that will avoid triggering the curse
	var/item_type //used for the text you get upon triggering the curse
	var/verbed

/datum/component/cursed_item/Initialize(god_trait, item_class, verbiage = "PUNISHED")
	. = ..()
	required_trait = god_trait
	item_type = item_class
	verbed = verbiage

	RegisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_PICKUP), PROC_REF(curse_test))

/datum/component/cursed_item/proc/curse_test()
	SIGNAL_HANDLER
	var/obj/item/I = parent
	if(!ishuman(I.loc))
		return
	var/mob/living/carbon/human/user = I.loc
	if(!HAS_TRAIT(user, required_trait))
		spawn(0)
			to_chat(user, "<font color='red'>UNWORTHY HANDS TOUCHING THIS [item_type], CEASE OR BE [verbed]</font>")
			user.adjust_fire_stacks(5)
			user.IgniteMob()
			user.Stun(40)

