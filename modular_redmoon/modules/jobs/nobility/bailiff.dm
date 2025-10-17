/datum/job/roguetown/marshal // A somewhat ham-fisted merge between bailiff and the old town sheriff role. The latter was built like a modern day officer, but we medieval in this bitch!
	title = "Marshal"
	tutorial = "You are an agent of the crown in matters of law and military, making sure that laws are pushed, verified and carried out by the retinue upon the citizenry of the realm. \
				While you preside over the knights and men-at-arms, much of your work happens behind a desk, deferring to the Sergeant-at-Arms or the Knight Captain to make sure your will is carried out in the field."
	min_pq = 0
	max_pq = null

/datum/advclass/marshal/classic
	name = "Marshal"
	tutorial = "You've spent your daes in the courts and garrisons of the city. You've studied the law tome from back to front and enforce your word with the iron hand of justice, and the iron mace in your hands. More men have spent days rotting in the dungeon than that Knight Commander could ever have claimed, and every person in the realm respects your authority in matters of law and order."

/datum/advclass/marshal/kcommander
	name = "Knight Commander"
	tutorial = "You spent your daes as a dutiful knight in the service of the crown. Earning your accolades through military tactics and victories, you're reknown for your warfaring. Now retired from your days afield, you enforce the same iron law you once practiced at war in your home. You run the garrison, knights and the town's laws with a military strictness, and no-one can claim you are weaker on crime than any of those weak Marshals."

/datum/outfit/job/roguetown/marshal/classic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/holsterbelt
	beltl = /obj/item/powderflask/artificer
	beltr = /obj/item/quiver/bullet/lead
	backpack_contents += list(/obj/item/storage/keyring/sheriff)

/datum/outfit/job/roguetown/marshal/kcommander/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/holsterbelt
	beltl = /obj/item/powderflask/artificer
	beltr = /obj/item/quiver/bullet/lead
	backpack_contents += list(/obj/item/storage/keyring/sheriff)
