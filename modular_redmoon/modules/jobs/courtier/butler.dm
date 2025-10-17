/datum/job/roguetown/butler // really need to re-name all these when the codebase isn't a fork and search will update for the peasants...
	title = "Seneschal"
	tutorial = "Servitude unto death; that is your motto. You are the manor's major-domo, commanding over the house servants and seeing to the administrative affairs, day to day of the estate. This role has style options for chief butlers and head maids."
	min_pq = 0
	max_pq = null

/datum/advclass/seneschal/seneschal
	name = "Seneschal"
	tutorial = "While still expected to fill in for the duties of the household servantry as needed, you have styled yourself as a figure beyond them."

/datum/advclass/seneschal/headmaid
	name = "Head Maid"
	tutorial = "Whether you were promoted from one or just like the frills, you stylize yourself as a head maid. Your duties and talents remain the same, though."

/datum/advclass/seneschal/chiefbutler
	name = "Chief Butler"
	tutorial = "You are the ruling class of butler and your ability to clear your throat and murmur 'I say' is without peer. Your duties and talents as seneschal remain the same, though."

/datum/outfit/job/roguetown/seneschal/headmaid/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/maidhead
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/maid
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/apron/waist/maid
	belt = /obj/item/storage/belt/rogue/leather/sash/maid
