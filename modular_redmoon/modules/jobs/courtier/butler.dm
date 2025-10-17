/datum/job/roguetown/butler // really need to re-name all these when the codebase isn't a fork and search will update for the peasants...
	title = "Seneschal"
	tutorial = "Служба до гроба - вот ваш девиз. Вы - мажор-домо поместья, командующий прислугой и следящий за повседневными административными делами поместья. В этой роли есть варианты для главных дворецких и горничных."
	min_pq = 0
	max_pq = null

/datum/advclass/seneschal/seneschal
	name = "Seneschal"
	tutorial = "Хотя от вас по-прежнему ожидают, что вы будете выполнять обязанности домашней прислуги по мере необходимости, вы позиционируете себя как фигуру, стоящую выше их."

/datum/advclass/seneschal/headmaid
	name = "Head Maid"
	tutorial = "Независимо от того, повысили ли вас в должности или вам просто нравится 'самоповышаться', вы выдаете себя за старшую горничную. Однако ваши обязанности и таланты остаются прежними."

/datum/advclass/seneschal/chiefbutler
	name = "Chief Butler"
	tutorial = "Вы принадлежите к правящему классу дворецких, и ваше умение прочистить горло и пробормотать 'моё слово - закон' не имеет себе равных. Однако ваши обязанности и таланты как сенешаля остаются прежними."

/datum/outfit/job/roguetown/seneschal/headmaid/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/maidhead
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/maid
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/apron/waist/maid
	belt = /obj/item/storage/belt/rogue/leather/sash/maid
