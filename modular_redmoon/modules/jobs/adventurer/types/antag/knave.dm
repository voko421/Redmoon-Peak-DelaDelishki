/datum/advclass/knave
	name = "Knave"
	tutorial = "Не все последователи Маттиоса забирают силой. Воры, браконьеры и бездельники всех мастей крадут у других из тени, исчезая задолго до того, как их жертвы осознают свое несчастье."

/datum/outfit/job/roguetown/bandit/knave/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
