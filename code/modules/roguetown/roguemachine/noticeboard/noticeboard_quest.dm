// File for all contracts & quests related logic on the noticeboard
/obj/structure/roguemachine/noticeboard/proc/consult_contracts(mob/user)
	if(!(user in SStreasury.bank_accounts))
		say("You have no bank account.")
		return

	var/list/difficulty_data = list(
		QUEST_DIFFICULTY_EASY = list(deposit = QUEST_DEPOSIT_EASY),
		QUEST_DIFFICULTY_MEDIUM = list(deposit = QUEST_DEPOSIT_MEDIUM),
		QUEST_DIFFICULTY_HARD = list(deposit = QUEST_DEPOSIT_HARD)
	)

	// Create a list with formatted difficulty choices showing deposits
	var/list/difficulty_choices = list()
	for(var/difficulty in difficulty_data)
		var/deposit = difficulty_data[difficulty]["deposit"]
		difficulty_choices["[difficulty] ([deposit] mammon deposit)"] = difficulty

	var/selection = tgui_input_list(user, "Select contract difficulty (deposit required)", "CONTRACTS", difficulty_choices)
	if(!selection)
		return

	// Get the actual difficulty key from our formatted choice
	var/actual_difficulty = difficulty_choices[selection]
	var/deposit = difficulty_data[actual_difficulty]["deposit"]

	if(SStreasury.bank_accounts[user] < deposit)
		say("Insufficient balance funds. You need [deposit] mammons in your meister.")
		return

	var/type_choices = GLOB.global_quest_types

	var/type_selection = tgui_input_list(user, "Select contract type", "CONTRACTS", type_choices[actual_difficulty])
	
	if(!type_selection)
		return

	if(user.mind.active_quest >= QUEST_MAX_ACTIVE_QUESTS)
		say("You have reached the maximum number of active quests. You can take up to [QUEST_MAX_ACTIVE_QUESTS] active quests at a time.")
		return

	// Instantiate appropriate quest subtype
	var/datum/quest/attached_quest
	switch(type_selection)
		if(QUEST_RETRIEVAL)
			attached_quest = new /datum/quest/retrieval()
		if(QUEST_KILL_EASY)
			attached_quest = new /datum/quest/kill/easy()
		if(QUEST_COURIER)
			attached_quest = new /datum/quest/courier()
		if(QUEST_CLEAR_OUT)
			attached_quest = new /datum/quest/kill/clearout()
		if(QUEST_RAID)
			attached_quest = new /datum/quest/kill/raid()
		if(QUEST_OUTLAW)
			attached_quest = new /datum/quest/kill/outlaw()

	if(!attached_quest)
		to_chat(user, span_warning("Invalid quest type selected!"))
		return

	// Configure quest
	attached_quest.quest_difficulty = actual_difficulty
	attached_quest.deposit_amount = attached_quest.calculate_deposit()

	// Set giver or receiver
	if(user.job != "Merchant" && user.job != "Steward")
		attached_quest.quest_receiver_reference = WEAKREF(user)
		attached_quest.quest_receiver_name = user.real_name
	else
		attached_quest.quest_giver_name = user.real_name
		attached_quest.quest_giver_reference = WEAKREF(user)

	// Find appropriate landmark
	var/obj/effect/landmark/quest_spawner/chosen_landmark = find_quest_landmark(actual_difficulty, type_selection)
	if(!chosen_landmark)
		to_chat(user, span_warning("No suitable location found for this contract!"))
		qdel(attached_quest)
		return

	// Generate quest content (spawns mobs/items)
	if(!attached_quest.generate(chosen_landmark))
		to_chat(user, span_warning("Failed to generate quest content!"))
		qdel(attached_quest)
		return

	// Create scroll
	var/obj/item/paper/scroll/quest/spawned_scroll = new(get_turf(src))
	user.put_in_hands(spawned_scroll)
	user.mind.active_quest += 1
	to_chat(user, span_notice("You have taken [user.mind.active_quest] active quests."))
	log_quest(user.ckey, user.mind, user, "Take [attached_quest.quest_type]")
	spawned_scroll.base_icon_state = attached_quest.get_scroll_icon()
	spawned_scroll.assigned_quest = attached_quest
	attached_quest.quest_scroll = spawned_scroll
	attached_quest.quest_scroll_ref = WEAKREF(spawned_scroll)

	// Reward calculation comes after generation & scroll creation to factor in distance for courier quests
	attached_quest.reward_amount = attached_quest.calculate_reward(get_turf(chosen_landmark))

	// Update scroll text
	spawned_scroll.update_quest_text()

	// Charge deposit
	SStreasury.bank_accounts[user] -= deposit
	SStreasury.treasury_value += deposit
	SStreasury.log_entries += "+[deposit] to treasury (quest deposit)"

/obj/structure/roguemachine/noticeboard/proc/find_quest_landmark(difficulty, type)
	// First try to find landmarks that match both difficulty AND type
	var/list/correctest_landmarks = list()
	GLOB.quest_landmarks_list = shuffle(GLOB.quest_landmarks_list)
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.quest_landmarks_list)
		if(landmark.quest_difficulty != difficulty || !(type in landmark.quest_type))
			continue

		var/has_clients_around = FALSE
		for(var/mob/M in get_hearers_in_view(world.view, landmark))
			if(!M.client)
				continue

			has_clients_around = TRUE

		if(has_clients_around)
			continue

		correctest_landmarks += landmark

	if(length(correctest_landmarks))
		return pick(correctest_landmarks)

	// If none found, try landmarks that match just the difficulty
	var/list/correcter_landmarks = list()
	for(var/obj/effect/landmark/quest_spawner/landmark in GLOB.quest_landmarks_list)
		if(landmark.quest_difficulty != difficulty)
			continue

		var/has_clients_around = FALSE
		for(var/mob/M in get_hearers_in_view(world.view, landmark))
			if(!M.client)
				continue

			has_clients_around = TRUE

		if(has_clients_around)
			continue

		correcter_landmarks += landmark

	if(length(correcter_landmarks))
		return pick(correcter_landmarks)

	return null

/obj/structure/roguemachine/noticeboard/proc/turn_in_contract(mob/user, obj/item/paper/scroll/quest/scroll_in_hand)
	var/obj/item/paper/scroll/quest/target_scroll = null

	if(scroll_in_hand)
		target_scroll = scroll_in_hand
		turn_in_scroll(user, target_scroll)
	else
		for(var/atom/movable/pawnable_loot in input_point)
			if(istype(pawnable_loot, /obj/item/paper/scroll/quest))
				target_scroll = pawnable_loot
				turn_in_scroll(user, target_scroll)


/obj/structure/roguemachine/noticeboard/proc/turn_in_scroll(mob/user, obj/item/paper/scroll/quest/scroll)
	var/reward = 0
	var/original_reward = 0
	var/total_deposit_return = 0
	if(scroll.assigned_quest?.complete)
		// Calculate base reward
		var/base_reward = scroll.assigned_quest.reward_amount
		original_reward += base_reward

		// Calculate deposit return
		var/deposit_return = scroll.assigned_quest.calculate_deposit()
		total_deposit_return += deposit_return
		
		// Apply Steward/Mechant bonus if applicable (only to the base reward)
		if(user.job == "Steward" || user.job == "Merchant")
			reward += base_reward * QUEST_HANDLER_REWARD_MULTIPLIER
		else
			reward += base_reward
		
		// Add deposit return to both reward totals
		reward += deposit_return
		original_reward += deposit_return

		if(user.mind.active_quest >= 1)
			user.mind.active_quest -= 1
			to_chat(span_notice("You now have [user.mind.active_quest] active quests."))
			log_quest(user.ckey, user.mind, user, "Finish [scroll.assigned_quest.quest_type]")
		
		qdel(scroll.assigned_quest)
		qdel(scroll)

	cash_in(round(reward), original_reward)

/obj/structure/roguemachine/noticeboard/proc/cash_in(reward, original_reward)
	var/list/coin_types = list(
		/obj/item/roguecoin/gold = FLOOR(reward / 10, 1),
		/obj/item/roguecoin/silver = FLOOR(reward % 10 / 5, 1),
		/obj/item/roguecoin/copper = reward % 5
	)

	for(var/coin_type in coin_types)
		var/amount = coin_types[coin_type]
		if(amount > 0)
			var/obj/item/roguecoin/coin_stack = new coin_type(get_turf(src))
			coin_stack.quantity = amount
			coin_stack.update_icon()
			coin_stack.update_transform()

	if(reward > 0)
		say(reward != original_reward ? \
			"Your handler assistance-increased reward of [reward] mammons has been dispensed! The difference is [reward - original_reward] mammons." : \
			"Your reward of [reward] mammons has been dispensed.")

/obj/structure/roguemachine/noticeboard/proc/abandon_contract(mob/user)
	var/obj/item/paper/scroll/quest/abandoned_scroll = locate() in input_point
	if(!abandoned_scroll)
		to_chat(user, span_warning("No contract scroll found in the input area!"))
		return

	var/datum/quest/quest = abandoned_scroll.assigned_quest
	if(!quest)
		to_chat(user, span_warning("This scroll doesn't have an assigned contract!"))
		return

	if(quest.complete)
		turn_in_contract(user)
		return

	var/refund = quest.calculate_deposit()

	// First try to return to quest giver
	var/mob/giver = quest.quest_giver_reference?.resolve()
	if(giver && (giver in SStreasury.bank_accounts))
		SStreasury.bank_accounts[giver] += refund
		SStreasury.treasury_value -= refund
		SStreasury.log_entries += "-[refund] from treasury (contract refund to handler)"
		to_chat(user, span_notice("The deposit has been returned to the contract giver."))
	// Otherwise try quest receiver
	else if(quest.quest_receiver_reference)
		var/mob/receiver = quest.quest_receiver_reference.resolve()
		if(receiver && (receiver in SStreasury.bank_accounts))
			SStreasury.bank_accounts[receiver] += refund
			SStreasury.treasury_value -= refund
			SStreasury.log_entries += "-[refund] from treasury (contract refund to volunteer)"
			to_chat(user, span_notice("You receive a [refund] mammon refund for abandoning the contract."))
		else
			cash_in(refund)
			SStreasury.treasury_value -= refund
			SStreasury.log_entries += "-[refund] from treasury (contract refund)"
			to_chat(user, span_notice("Your refund of [refund] mammon has been dispensed."))

	// Clean up quest items
	if(quest.quest_type == QUEST_COURIER && quest.target_delivery_item)
		quest.target_delivery_item = null
		for(var/obj/item/I in world)
			if(istype(I, quest.target_delivery_item))
				var/datum/component/quest_object/Q = I.GetComponent(/datum/component/quest_object)
				if(Q && Q.quest_ref == WEAKREF(quest))
					I.remove_filter("quest_item_outline")
					qdel(Q)
					qdel(I)


	user.mind.active_quest -= 1
	to_chat(user, span_notice("You now have [user.mind.active_quest] active quests."))
	log_quest(user.ckey, user.mind, user, "Abandon [abandoned_scroll.assigned_quest.quest_type]")
	abandoned_scroll.assigned_quest = null
	qdel(quest)
	qdel(abandoned_scroll)

/obj/structure/roguemachine/noticeboard/proc/print_contracts(mob/user)
	var/list/active_quests = list()
	for(var/obj/item/paper/scroll/quest/quest_scroll in world)
		if(quest_scroll.assigned_quest && !quest_scroll.assigned_quest.complete)
			active_quests += quest_scroll

	if(!length(active_quests))
		say("No active contracts found.")
		return

	var/obj/item/paper/scroll/report = new(get_turf(src))
	report.name = "Guild Contract Report"
	report.desc = "A list of currently active contracts issued by the Mercenary's Guild."

	var/report_text = "<center><b>MERCENARY'S GUILD - ACTIVE CONTRACTS</b></center><br><br>"
	report_text += "<i>Generated on [station_time_timestamp()]</i><br><br>"

	for(var/obj/item/paper/scroll/quest/quest_scroll in active_quests)
		var/datum/quest/quest = quest_scroll.assigned_quest
		var/area/quest_area = get_area(quest_scroll)
		report_text += "<b>Title:</b> [quest.title].<br>"
		report_text += "<b>Recipient:</b> [quest.quest_receiver_name ? quest.quest_receiver_name : "Unclaimed"].<br>"
		report_text += "<b>Type:</b> [quest.quest_type].<br>"
		report_text += "<b>Difficulty:</b> [quest.quest_difficulty].<br>"
		report_text += "<b>Last Known Location:</b> [quest_area ? quest_area.name : "Unknown Location"].<br>"
		report_text += "<b>Reward:</b> [quest.reward_amount] mammons.<br><br>"

	report.info = report_text
	say("Contract report printed.")
