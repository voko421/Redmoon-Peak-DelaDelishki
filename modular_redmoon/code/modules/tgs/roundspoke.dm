#define ROUNDWAITER "1325992382021501050"
#define FUNNY_VIDEOS_FILE_NAME "config/discord_videos.json"

/proc/init_discord_videos()
	if (!fexists(FUNNY_VIDEOS_FILE_NAME))
		return null
	var/list/videos_json = json_decode(file2text(FUNNY_VIDEOS_FILE_NAME))
	if (!length(videos_json))
		return null

	var/list/contents = list()
	for (var/entry in videos_json)
		if (entry["content"])
			contents += entry["content"]

	return contents

/datum/tgs_chat_embed/provider/author/glob
	name = "Ксайликс вещает"
	icon_url = "https://cdn.discordapp.com/attachments/1325992384684884115/1330502172906885131/IMG_4957.png?ex=678e3635&is=678ce4b5&hm=525f0416de455a33fabe2b014f91a546bc2883f670dd2785afbc95add71375e4&"

/world/TgsInitializationComplete()
	. = ..()
	var/list/randomline = list(
				"О-о-о? Что это? Начало игры?",
				"Это для меня? Начало игры?",
				"ИГРА НАЧАЛАСЬ! :)",
				"Давно-давно... началась история, произошедшая в славном городе Алая Пиковая Вершина.",
				"Уэ. Новый раунд или что-то вроде того.",
				"Я всегда возвращаюсь вместе с новой партией.",
				"Мы начинаем новую партию!",
				"Мы начинаем новую партию!",
				"Мы начинаем новую партию!",
				"Время для новой истории!",
				"Время для новой истории!",
				"Время для новой истории!",
				"Я должна признаться. Вы мои любимые слушатели.",
				"Тишина, дитя человеческое, у меня есть история для тебя...",
				"Партия начинается. Вы встретились в та...раске...",
				"Нет конца, нет конца, нет конца, нет конца...",
				"Убивать. Насиловать. Предавать.",
				"Пора начинать партию!",
				"Партия начинается. Вы встретились в таверне, мои чуваки.",
				",g Мы начали партию.",
				"Партия начинается, встречаемся в таверне.",
				"Нельзя, запрещено.",
				"Только для Айко.",
				"Айко - лучшая девочька.",
				"Только для крутышей.",
				"Убейся.",
				"11010000 10111100 11010000 10110000 11010001 10000010 11010001 10001100 100000 11010000 10110101 11010000 10110001 11010000 10110000 11010000 10111011",
				"А я всё думал, когда же ты появишься.",
				"Хочу джамбургер.",
				"Сегодня нас атакуют танки, авиация и корабли. А знаете, где ещё есть танки, авиация и корабли? Конечно же, в Гром Войны. Гром Войны - это компьютерная многопользовательская онлайн-игра...",
				"Сегодня нас атакуют мехи, пехтура и шизофрения. А знаете, где ещё есть мехи, пехтура и шизофрения? Конечно же, в Война Лицо. Война Лицо - это компьютерная многопользовательская онлайн-игра...",
				"Ты мне сейчас не поверишь, но там ебать сколько посуды, которая сама себя никак не вымоет.",
				"B чём сила, брат? В ОМах.",
				"В чём сопротивление, брат? В острых козырьках.",
				"В чём измеряют напряжение, брат? В Томасах Шелби.",
				"We can't expect god to do all the work.",
				"Заканчивай свой звонок и поцелуй меня в сладкие уста. Романтики хочется.",
				"Не надо делать мне как лучше, оставьте мне как хорошо.",
				"Я не хотела Вас обидеть, случайно просто повезло.",
				"Поскольку времени немного, я вкратце матом объясню.",
				"Башка сегодня отключилась, не вся, конечно, - есть могу.",
				"Следить стараюсь за фигурой, чуть отвлекусь - она жует.",
				"Шаман за скверную погоду недавно в бубен получил.",
				"Всё вроде с виду в шоколаде, но если внюхаться - то нет.",
				"Обидеть Таню может каждый, не каждый может убежать.",
				"Ищу приличную работу, но чтоб не связана с трудом.",
				"Мои намеренья прекрасны, пойдёмте, тут недалеко.",
				"Я за тебя переживаю - вдруг у тебя всё хорошо.",
				"Держи вот этот подорожник - щас врежу, сразу приложи.",
				"Я понимаю, что Вам нечем, но всё ж попробуйте понять.",
				"Мы были б идеальной парой, конечно, если бы не ты.",
				"Как говорится, всё проходит, но может кое-что застрять.",
				"Кого хочу я осчастливить, тому спасенья уже нет.",
				"А ты готовить-то умеешь? — Я вкусно режу колбасу.",
				"Звони почаще - мне приятно на твой «пропущенный» смотреть.",
				"Зачем учить нас, как работать, вы научитесь как платить.",
				"Характер у меня тяжёлый, всё потому, что золотой.",
				"Чтоб дело мастера боялось, он знает много страшных слов.",
				"Вы мне хотели жизнь испортить? Спасибо, справилась сама.",
				"Её сбил конь средь изб горящих, она нерусскою была…",
				"Когда все крысы убежали, корабль перестал тонуть.",
				"Дела идут пока отлично, поскольку к ним не приступал.",
				"Работаю довольно редко, а недовольно каждый день.",
				"Была такою страшной сказка, что дети вышли покурить.",
				"Когда на планы денег нету, они становятся мечтой.",
				"Женат два раза неудачно - одна ушла, вторая - нет.",
				"Есть всё же разум во Вселенной, раз не выходит на контакт.",
				"Уж вроде ноги на исходе, а юбка всё не началась.",
				"Я попросил бы Вас остаться, но вы ж останетесь, боюсь.",
				"Для женщин нет такой проблемы, которой им бы не создать.",
				"Олегу не везёт настолько, что даже лифт идет в депо.",
				"Мы называем это жизнью, а это просто список дел.",
				"И жили счастливо и долго… он долго, счастливо она.",
				"Не копай противнику яму, сам туда ляжешь.",
				"Не копай противнику яму, сам туда ляжешь.",
				"Не копай противнику яму, сам туда ляжешь.",
				"Не копай противнику яму, сам туда ляжешь.",
				"Не копай противнику яму, сам туда ляжешь.",
				"Не копай противнику яму, сам туда ляжешь.",
				"В БОЙ!!!",
				"В БОЙ!!!",
				"В БОЙ!!!",
				"Поиграй со мной. ;з",
				"Кто глубоко скорбит - тот истово любил.")
	
	var/datum/tgs_message_content/message = new ("Я собираю людей для новой партии прямо сейчас! <@&[ROUNDWAITER]>")
	var/datum/tgs_chat_embed/structure/embed = new()
	message.embed = embed
	embed.title = "Начинается новая история!"
	embed.description = "Новая сессия начнется примерно через пять-десять минут."
	var/datum/tgs_chat_embed/field/line = new ("Ксайликс говорит:", "[pick(randomline)]")
	var/datum/tgs_chat_embed/field/joinat = new ("Заходи на cервер!","https://redmoon.ss13-bluemoon.ru/")
	embed.colour = "#ff0000"
	embed.author = new /datum/tgs_chat_embed/provider/author/glob("Ксайликс собирает игроков на сессию")
	//embed.media.thumbnail = "https://tenor.com/view/leaf-black-souls-black-souls-2-marry-ann-mary-sue-gif-9443358797381852725"
	to_chat(world,"We probably sent a hook to tgs. probably")

	embed.fields = list(line, joinat)

	send2chat(message, "status") //can't "CONFIG_GET" before mc start. Womp-womp

	var/list/random_links = init_discord_videos()
	if (!random_links || !length(random_links))
		send2chat("Ошибка: не удалось загрузить ссылки из FUNNY_VIDEOS_FILE_NAME", "status")
		return

	var/random_link = pick(random_links)
	var/last_roundend_message = "[random_link]"
	var/datum/tgs_message_content/random_message = new(last_roundend_message)
	spawn(5)
		send2chat(random_message, "status")

/world/proc/SendTGSRoundEnd()
	var/max_influence = -INFINITY
	var/max_chosen = 0
	var/datum/storyteller/most_influential
	var/datum/storyteller/most_frequent

	for(var/storyteller_name in SSgamemode.storytellers)
		var/datum/storyteller/initialized_storyteller = SSgamemode.storytellers[storyteller_name]
		if(!initialized_storyteller)
			continue

		var/influence = SSgamemode.calculate_storyteller_influence(initialized_storyteller.type)
		if(influence > max_influence)
			max_influence = influence
			most_influential = initialized_storyteller

		if(initialized_storyteller.times_chosen > max_chosen)
			max_chosen = initialized_storyteller.times_chosen
			most_frequent = initialized_storyteller

	var/total_population = GLOB.azure_round_stats[STATS_TOTAL_POPULATION]
	var/percent_of_males = total_population ? PERCENT(GLOB.azure_round_stats[STATS_MALE_POPULATION] / total_population) : 0
	var/percent_of_females = total_population ? PERCENT(GLOB.azure_round_stats[STATS_FEMALE_POPULATION] / total_population) : 0
	var/percent_of_other = total_population ? PERCENT(GLOB.azure_round_stats[STATS_OTHER_GENDER] / total_population) : 0

	var/datum/tgs_message_content/message = new ("...вот и сказочке конец.")
	var/datum/tgs_chat_embed/structure/embed = new()
	message.embed = embed
	embed.author = new /datum/tgs_chat_embed/provider/author/glob("Ксайликс объявляет результаты")
	embed.title = "Партия длилась [gameTimestamp("hh:mm:ss", world.time - SSticker.round_start_time)]."
	embed.description = SSticker.get_end_reason()
	embed.colour = "#f19a37"

	var/datum/tgs_chat_embed/field/deaths = new ("💀 Смертей: ", "[GLOB.azure_round_stats[STATS_DEATHS]]")
	var/datum/tgs_chat_embed/field/players = new (":ghost: Заблудшие души: ", "[GLOB.player_list.len]")
	var/datum/tgs_chat_embed/field/bloodspilled = new ("🩸 Крови пролито: ", "[round(GLOB.azure_round_stats[STATS_BLOOD_SPILT] / 100, 1)]L")
	var/datum/tgs_chat_embed/field/triumphgained = new ("🏆 Триумфов получено: ", "[GLOB.azure_round_stats[STATS_TRIUMPHS_AWARDED]]")
	var/datum/tgs_chat_embed/field/triumphslost = new (":woman_detective: Триумфов украдено: ","[GLOB.azure_round_stats[STATS_TRIUMPHS_STOLEN] * -1]")
	var/datum/tgs_chat_embed/field/pleasures = new ("💦 Наслаждений: ", "[GLOB.azure_round_stats[STATS_PLEASURES]]")
	var/datum/tgs_chat_embed/field/confessors = new (":orthodox_cross: Исповедники: ", "[GLOB.confessors.len]")
	var/datum/tgs_chat_embed/field/men = new (":man_beard: Мужчины: ", "[GLOB.azure_round_stats[STATS_MALE_POPULATION]] ([percent_of_males]%)")
	var/datum/tgs_chat_embed/field/women = new (":woman: Женщины: ", "[GLOB.azure_round_stats[STATS_FEMALE_POPULATION]] ([percent_of_females]%)")
	var/datum/tgs_chat_embed/field/other_gender = new (":transgender_flag: Другие: ", "[GLOB.azure_round_stats[STATS_OTHER_GENDER]] ([percent_of_other]%)")

	var/gods_text = ""
	if(max_influence <= 0 && max_chosen <= 0)
		gods_text = "Боги не проявляли влияния"
	else if(most_influential == most_frequent && max_influence > 0)
		gods_text = "Наиболее Доминирующий Покровитель: [most_influential.name]"
	else
		if(max_influence > 0)
			gods_text += "Покровитель-Блюститель Деца: [most_influential.name] получил [max_influence] очков влияния. "
		if(max_chosen > 0)
			gods_text += "Покровитель Деца: [most_frequent.name] имел [max_chosen] верослужителей."
	var/datum/tgs_chat_embed/field/gods = new (":gem: Боги: ", gods_text)

	var/datum/tgs_chat_embed/field/revivals = new ("✨ Воскрешений: ", "[GLOB.azure_round_stats[STATS_ASTRATA_REVIVALS] + GLOB.azure_round_stats[STATS_LUX_REVIVALS]]")
	var/datum/tgs_chat_embed/field/prayers = new ("🙏 Молитв: ", "[GLOB.azure_round_stats[STATS_PRAYERS_MADE]]")
	var/datum/tgs_chat_embed/field/drowned = new ("🌊 Утонуло: ", "[GLOB.azure_round_stats[STATS_PEOPLE_DROWNED]]")
	var/datum/tgs_chat_embed/field/stolen = new ("👜 Карманного Воровства: ", "[GLOB.azure_round_stats[STATS_ITEMS_PICKPOCKETED]]")
	var/datum/tgs_chat_embed/field/alcohol = new ("🍷 Алкоголя выпито: ", "[GLOB.azure_round_stats[STATS_ALCOHOL_CONSUMED]]")
	var/datum/tgs_chat_embed/field/drugs = new ("💊 Наркотиков использовано: ", "[GLOB.azure_round_stats[STATS_DRUGS_SNORTED]]")
	var/datum/tgs_chat_embed/field/fish = new ("🐟 Рыбы поймано: ", "[GLOB.azure_round_stats[STATS_FISH_CAUGHT]]")
	var/datum/tgs_chat_embed/field/trees = new ("🌳 Деревьев срублено: ", "[GLOB.azure_round_stats[STATS_TREES_CUT]]")
	var/datum/tgs_chat_embed/field/plants = new ("🌿 Растений собрано: ", "[GLOB.azure_round_stats[STATS_PLANTS_HARVESTED]]")

	var/datum/tgs_chat_embed/field/races1 = new (":people_hugging: Расы (основные): ", "\
	Люди: [GLOB.azure_round_stats[STATS_ALIVE_NORTHERN_HUMANS]] | \
	Дварфы: [GLOB.azure_round_stats[STATS_ALIVE_DWARVES]] | \
	Эльфы: [GLOB.azure_round_stats[STATS_ALIVE_WOOD_ELVES] + GLOB.azure_round_stats[STATS_ALIVE_DARK_ELVES]] | \
	Полуэльфы: [GLOB.azure_round_stats[STATS_ALIVE_HALF_ELVES]] | \
	Тифлинги: [GLOB.azure_round_stats[STATS_ALIVE_TIEFLINGS]]")

	var/datum/tgs_chat_embed/field/races2 = new (":people_hugging: Расы (гибриды): ", "\
	Полуорки: [GLOB.azure_round_stats[STATS_ALIVE_HALF_ORCS]] | \
	Гоблины: [GLOB.azure_round_stats[STATS_ALIVE_GOBLINS]] | \
	Кобольды: [GLOB.azure_round_stats[STATS_ALIVE_KOBOLDS]] | \
	Ящеры: [GLOB.azure_round_stats[STATS_ALIVE_LIZARDS]] | \
	Аасимары: [GLOB.azure_round_stats[STATS_ALIVE_AASIMAR]]")

	var/datum/tgs_chat_embed/field/races3 = new (":people_hugging: Расы (экзотические): ", "\
	Полукины: [GLOB.azure_round_stats[STATS_ALIVE_HALFKIN]] | \
	Дикари: [GLOB.azure_round_stats[STATS_ALIVE_WILDKIN]] | \
	Конструкты: [GLOB.azure_round_stats[STATS_ALIVE_CONSTRUCTS]] | \
	Верминфолки: [GLOB.azure_round_stats[STATS_ALIVE_VERMINFOLK]] | \
	Драконы: [GLOB.azure_round_stats[STATS_ALIVE_DRACON]]")

	var/datum/tgs_chat_embed/field/races4 = new (":people_hugging: Расы (звериные): ", "\
	Аксиане: [GLOB.azure_round_stats[STATS_ALIVE_AXIAN]] | \
	Табакси: [GLOB.azure_round_stats[STATS_ALIVE_TABAXI]] | \
	Вульпы: [GLOB.azure_round_stats[STATS_ALIVE_VULPS]] | \
	Люпины: [GLOB.azure_round_stats[STATS_ALIVE_LUPIANS]] | \
	Моли: [GLOB.azure_round_stats[STATS_ALIVE_MOTHS]]")

	var/round_occupations = ""
	for(var/datum/job/roguetown/target_job in SSjob.occupations)
		if(target_job.current_positions > 0)
			round_occupations += "[target_job.title] - [target_job.current_positions] | "
	var/datum/tgs_chat_embed/field/jobs = new (":briefcase: Уделы: ", round_occupations)

	embed.fields = list(
		deaths,
		bloodspilled,
		triumphgained,
		triumphslost,
		pleasures,
		confessors,
		players,
		men,
		women,
		other_gender,
		gods,
		revivals,
		prayers,
		drowned,
		stolen,
		alcohol,
		drugs,
		fish,
		trees,
		plants,
		races1,
		races2,
		races3,
		races4,
		jobs
	)

	send2chat(message, "status")
