/datum/job/roguetown/marshal // A somewhat ham-fisted merge between bailiff and the old town sheriff role. The latter was built like a modern day officer, but we medieval in this bitch!
	title = "Marshal"
	tutorial = "Вы являетесь представителем короны в юридических и военных вопросах, следящим за тем, чтобы свита распространяла, проверяла и исполняла законы среди граждан королевства. Пока вы руководите рыцарями и латниками, большая часть вашей работы происходит за письменным столом, и вы доверяете сержанту по оружию или капитану рыцарей следить за тем, чтобы ваша воля выполнялась на поле боя."
	min_pq = 0
	max_pq = null

/datum/advclass/marshal/classic
	name = "Marshal"
	tutorial = "Вы провели свои годы в судах и гарнизонах города. Вы изучили закон от корки до корки и выполняете свое слово железной рукой правосудия и железной булавой в своих руках. В подземелье сгнило больше людей, чем мог бы когда-либо заявить рыцарь-командор, и каждый человек в королевстве уважает вашу власть в вопросах закона и порядка."

/datum/advclass/marshal/kcommander
	name = "Knight Commander"
	tutorial = "Вы провели свои годы как послушный долгу рыцарь на службе короне. Заслужив почести благодаря военной тактике и победам, вы прославились своим воинским мастерством. Теперь, отойдя от дел, вы следуете тем же железным законам, которые когда-то применяли на войне у себя дома. Вы руководите гарнизоном, рыцарями и городскими законами с военной строгостью, и никто не может утверждать, что в борьбе с преступностью вы слабее любого из этих слабых маршалов."

/datum/outfit/job/roguetown/marshal/classic/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/holsterbelt/marshal
	beltl = /obj/item/powderflask/artificer
	beltr = /obj/item/quiver/bullet/lead
	backpack_contents += list(/obj/item/storage/keyring/sheriff)

/datum/outfit/job/roguetown/marshal/kcommander/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/holsterbelt/marshal
	beltl = /obj/item/powderflask/artificer
	beltr = /obj/item/quiver/bullet/lead
	backpack_contents += list(/obj/item/storage/keyring/sheriff)
