/datum/job/roguetown/bogguardsman
	title = "Warden"
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Typically a denizen of the sparsely populated Azurian woods, you volunteered up with the wardens--a group of ranger types who keep a vigil over the untamed wilderness. \
				While Wardens have no higher authority, operating as a fraternity of rangers, you will be called upon as members of the garrison by the Marshal or the Crown. \
				Serve their will and recieve what a ranger craves the most - freedom and safety."
	min_pq = 0
	max_pq = null
	round_contrib_points = 5

/datum/advclass/bogguardsman/ranger
	name = "Ranger"
	tutorial = "You are a ranger, a hunter who volunteered to become a part of the wardens. You have experience using bows and daggers."

/datum/advclass/bogguardsman/forester
	name = "Forester"
	tutorial = "You are a forester, a woodsman who volunteered to become a part of the wardens. You have experience using axes and polearms."

/datum/outfit/job/roguetown/bogguardsman/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank_up_to(/datum/skill/misc/riding, SKILL_LEVEL_APPRENTICE, TRUE)

/datum/outfit/job/roguetown/bogguardsman/forester/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank_up_to(/datum/skill/misc/riding, SKILL_LEVEL_JOURNEYMAN, TRUE)
