/datum/job/roguetown/lord
	title = "Grand Duke"
	f_title = "Grand Duchess"
	tutorial = "Взойдя на трон благодаря хитрости и политическим интригам, вы стали абсолютным правителем этих земель и центром всех заговоров. Каждый мужчина, женщина и ребенок завидуют вашему положению и готовы заменить вас в мгновение ока: покажите им, что они ошибаются."
	min_pq = 0
	max_pq = null

/datum/advclass/lord/warrior
	name = "Valiant Warrior"
	tutorial = "Ты - благородный воин. Ты достиг своего положения благодаря собственной силе и мастерству, будь то командуя своими людьми или сражаясь бок о бок с ними. Или, возможно, ты не такой, как все, а просто хорошо обученный наследник, возведенный в ранг герцога. Вы обучены обращению с тяжелыми доспехами и хорошо владеете мечом."

/datum/advclass/lord/merchant
	name = "Merchant Lord"
	tutorial = "Ты всегда был талантлив в обращении с монетами и торговле. И твои таланты привели тебя к положению герцога Алого Рассвета. Ты мог быть купцом, который купил себе дворянство и власть, или исключительно талантливым дворянином, который умел обращаться с монетами. Прямая борьба - не ваша сильная сторона, но у вас много денег, острый слух и вы умеете отличать хорошее от плохого."

/datum/advclass/lord/mage
	name = "Mage Lord"
	tutorial = "Несмотря на то, что в юности ты посвятил себя чтению и чудесам арканы, пришло твое время занять трон. Теперь ты правишь не только короной и сталью, но и заклинаниями и умом, покажи тем, кто сомневался, что ты не зря провел время, уткнувшись в книги, как они ошибались."

/datum/advclass/lord/inbred
	name = "Inbred Lord"
	tutorial = "Псайдон и Астрата улыбаются тебе. Ибо, несмотря на твое врожденное, слабое тело и заговоры твоей семьи, направленные на то, чтобы лишить тебя права наследования, ты каким-то образом стал Великим Герцогом Алого Рассвета. Пусть твое правление продлится сотни лет."

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

/datum/outfit/job/roguetown/lord/mage/pre_equip(mob/living/carbon/human/H)
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
