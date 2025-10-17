/datum/job/roguetown/lord
	title = "Grand Duke"
	f_title = "Grand Duchess"
	tutorial = "Elevated upon your throne through a web of intrigue and political upheaval, you are the absolute authority of these lands and at the center of every plot within it. Every man, woman and child is envious of your position and would replace you in less than a heartbeat: Show them the error of their ways."
	min_pq = 0
	max_pq = null

/datum/advclass/lord/warrior
	name = "Valiant Warrior"
	tutorial = "You're a noble warrior. You rose to your rank through your own strength and skill, whether by leading your men or by fighting alongside them. Or perhaps you are none of that, but simply a well-trained heir elevated to the position of Lord. You're trained in the usage of heavy armor, and knows swordsmanship well."

/datum/advclass/lord/merchant
	name = "Merchant Lord"
	tutorial = "You were always talented with coins and trade. And your talents have brought you to the position of the Lord of Scarlet Dawn. You could be a merchant who bought his way into nobility and power, or an exceptionally talented noble who were inclined to be good with coins. Fighting directly is not your forte\
	But you have plenty of wealth, keen ears, and know a good deal from a bad one."

/datum/advclass/lord/mage
	name = "Mage Lord"
	tutorial = "Despite spending your younger years focused on reading and the wonders of the arcyne, it came the time for you to take the throne. Now you rule not only by crown and steel, but by spell and wit, show those who doubted your time buried in books was well spent how wrong they were."

/datum/advclass/lord/inbred
	name = "Inbred Lord"
	tutorial = "Psydon and Astrata smiles upon you. For despite your inbred and weak body, and your family's conspiracies to remove you from succession, you have somehow become the Lord of Scarlet Dawn. May your reign lasts a hundred years."

/datum/outfit/job/roguetown/lord/pre_equip(mob/living/carbon/human/H)
	. = ..()
	backpack_contents = list()
	belt = /obj/item/storage/belt/rogue/leather/holsterbelt/lord
	beltl = /obj/item/powderflask/artificer
	beltr = /obj/item/quiver/bullet/lead

/datum/outfit/job/roguetown/lord/warrior/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
	backpack_contents += /obj/item/storage/keyring/lord
	backpack_contents += /obj/item/rogueweapon/huntingknife/idagger/steel/special

/datum/outfit/job/roguetown/lord/merchant/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
	backpack_contents += /obj/item/storage/keyring/lord
	backpack_contents += /obj/item/rogueweapon/huntingknife/idagger/steel/special

/datum/outfit/job/roguetown/lord/inbred/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
	backpack_contents += /obj/item/storage/keyring/lord
	backpack_contents += /obj/item/rogueweapon/huntingknife/idagger/steel/special
