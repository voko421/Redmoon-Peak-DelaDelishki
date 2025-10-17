/datum/triumph_buy/race_all_jobs
	triumph_buy_id = "race_all"
	desc = "Снять расовые ограничения для вас с роли!"
	triumph_cost = 10
	category = TRIUMPH_CAT_ROUND_EFX

/datum/triumph_buy/race_all_jobs/on_buy()
	if(usr && usr.client)
		usr.client.triumph_ids += list(src.triumph_buy_id)
	..()

/datum/triumph_buy/race_all_jobs/on_removal()
	if(usr && usr.client)
		if(usr.client.triumph_ids.Find(src.triumph_buy_id))
			usr.client.triumph_ids -= list(src.triumph_buy_id)
