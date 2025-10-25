

//Values for antag preferences, event roles, etc. unified here



//These are synced with the Database, if you change the values of the defines
//then you MUST update the database!
#define ROLE_MANIAC				"Маньяк"
#define ROLE_WEREWOLF			"Оборотень"
#define ROLE_VAMPIRE			"Вампир"
#define ROLE_NBEAST				"Лорд Вампиров"
#define ROLE_BANDIT				"Бандит"
#define ROLE_DELF				"Тёмный Эльф"
#define ROLE_PREBEL				"Мятежник"
#define ROLE_ASPIRANT			"Притязатель"
#define ROLE_LICH				"Лич"
#define ROLE_DREAMWALKER		"Сновидец"
#define ROLE_ASCENDANT			"Возносящийся"
#define ROLE_WRETCH				"Отверженный"
#define ROLE_UNBOUND_DEATHKNIGHT "Свободный рыцарь смерти"
#define ROLE_DARK_ITINERANT "Тёмный путешественник"

#define ROLE_SYNDICATE			"Syndicate"
#define ROLE_TRAITOR			"Traitor"
#define ROLE_OPERATIVE			"Operative"
#define ROLE_CHANGELING			"Changeling"
#define ROLE_WIZARD				"Wizard"
#define ROLE_MALF				"Malf AI"
#define ROLE_REV				"Revolutionary"
#define ROLE_REV_HEAD			"Head Revolutionary"
#define ROLE_PAI				"pAI"
#define ROLE_CULTIST			"Cultist"
#define ROLE_BLOB				"Blob"
#define ROLE_NINJA				"Space Ninja"
#define ROLE_MONKEY				"Monkey"
#define ROLE_ABDUCTOR			"Abductor"
#define ROLE_REVENANT			"Revenant"
#define ROLE_DEVIL				"Devil"
#define ROLE_BROTHER			"Blood Brother"
#define ROLE_BRAINWASHED		"Brainwashed Victim"
#define ROLE_OVERTHROW			"Syndicate Mutineer"		//Role removed, left here for safety.
#define ROLE_HIVE				"Hivemind Host"				//Role removed, left here for safety.
#define ROLE_OBSESSED				"Obsessed"
#define ROLE_SENTIENCE			"Sentience Potion Spawn"
#define ROLE_MIND_TRANSFER		"Mind Transfer Potion"
#define ROLE_POSIBRAIN			"Posibrain"
#define ROLE_DRONE				"Drone"
#define ROLE_DEATHSQUAD			"Deathsquad"
#define ROLE_LAVALAND			"Lavaland"
#define ROLE_INTERNAL_AFFAIRS	"Internal Affairs Agent"
#define ROLE_NECRO_SKELETON		"Скелет Некроманта"
#define ROLE_LICH_SKELETON		"Скелет Лича"
#define ROLE_CHOSEN				"Избранный"
#define ROLE_VAMPIRE_SUMMON		"Существо Вамипира"

GLOBAL_LIST_INIT(special_roles_rogue, list(
	ROLE_MANIAC = /datum/antagonist/maniac,
	ROLE_PREBEL = /datum/antagonist/prebel,
	ROLE_BANDIT = /datum/antagonist/bandit,
	ROLE_ASPIRANT = /datum/antagonist/aspirant,
	ROLE_WEREWOLF = /datum/antagonist/werewolf,
	ROLE_NBEAST = /datum/antagonist/vampire/lord,
	ROLE_VAMPIRE = /datum/antagonist/vampire,
	ROLE_LICH = /datum/antagonist/lich,
	ROLE_DREAMWALKER = /datum/antagonist/dreamwalker
))

//Job defines for what happens when you fail to qualify for any job during job selection
#define BEOVERFLOW 	1
#define BERANDOMJOB "Получить случайную роль"
#define RETURNTOLOBBY 	"Вернуться в лобби"
