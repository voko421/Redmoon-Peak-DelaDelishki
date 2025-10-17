/datum/triumph_buy/wipe_triumphs
	triumph_buy_id = "WipeTriumphs"
	desc = "Сжечь дотла все триумфы! Вернуть всех к НУЛЮ!"
	triumph_cost = 180
	category = TRIUMPH_CAT_MISC
	pre_round_only = FALSE
	visible_on_active_menu = FALSE

// We fire this on activate
/datum/triumph_buy/wipe_triumphs/on_activate()
	SStriumphs.wipe_all_triumphs(ckey_of_buyer) // ha haha .... woops guys
	to_chat(world, span_redtext("[key_of_buyer] сжигает все триумфы!"))
