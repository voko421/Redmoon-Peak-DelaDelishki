/datum/job/roguetown/bogguardsman
	title = "Warden"
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	tutorial = "Будучи обычным жителем малонаселенных азурийских лесов, вы добровольно вступили в ряды стражей - группы рейнджеров, которые охраняют дикую природу. \
				Хотя стражи не имеют высших полномочий и действуют как братство рейнджеров, маршал или корона призовут вас в качестве членов гарнизона. \
				Подчиняйся их воле и получай то, чего рейнджер жаждет больше всего - свободу и безопасность."
	min_pq = 0
	max_pq = null
	round_contrib_points = 5

/datum/advclass/bogguardsman/ranger
	name = "Ranger"
	tutorial = "Вы рейнджер, охотник, который добровольно вступил в ряды стражей. У вас есть опыт обращения с луками и кинжалами."

/datum/advclass/bogguardsman/forester
	name = "Forester"
	tutorial = "Вы лесничий, дровосек, который добровольно вступил в ряды стражей. У вас есть опыт обращения с топорами и древковым оружием."

/datum/outfit/job/roguetown/bogguardsman/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank_up_to(/datum/skill/misc/riding, SKILL_LEVEL_APPRENTICE, TRUE)

/datum/outfit/job/roguetown/bogguardsman/forester/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank_up_to(/datum/skill/misc/riding, SKILL_LEVEL_JOURNEYMAN, TRUE)
