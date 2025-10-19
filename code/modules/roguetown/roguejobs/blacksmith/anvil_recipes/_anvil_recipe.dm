/datum/anvil_recipe
	abstract_type = /datum/anvil_recipe
	var/name
	var/category = "Misc"
	var/list/additional_items = list()
	var/material_quality = 0 // Quality of the bar(s) used. Accumulated per added ingot.
	var/num_of_materials = 1 // Total number of materials used. Quality divided among them.
	var/skill_quality = 0 // Accumulated per hit based on calculations, will decide final result.
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/atom/req_bar
	var/atom/req_blade
	var/using_blade = FALSE
	var/atom/movable/created_item
	var/createditem_num = 1 // How many units to make.
	var/craftdiff = 0
	var/needed_item
	var/needed_item_text
	var/quality_mod = 0
	var/progress
	var/max_progress = 100
	var/i_type
	var/bar_health = 100 // Current material bar health, reduced by failures. At 0 HP it is deleted.
	var/numberofhits = 0 // Increased every time you hit the bar, the more you have to hit the bar the less quality of the product.
	var/numberofbreakthroughs = 0 // How many good hits we got on the metal, advances recipes 50% faster, reduces number of hits total, and restores bar_health
	var/datum/parent

/datum/anvil_recipe/New(datum/P, using_blade = FALSE, ...)
	parent = P // P is now the anvil
	. = ..()

	// Auto-detect if we're using a blade by checking what's on the anvil
	var/obj/machinery/anvil/anvil = P
	if(anvil && anvil.hingot != null)
		if(!using_blade && req_blade && istype(anvil.hingot, req_blade))
			using_blade = TRUE

	src.using_blade = using_blade

	// If using a blade, reduce material requirements
	if(using_blade && additional_items.len > 0)
		// Remove one material requirement when using a blade
		var/found_ingot = FALSE
		for(var/i in 1 to additional_items.len)
			var/path = additional_items[i]
			if(ispath(path, /obj/item/ingot))
				additional_items.Cut(i, i+1)
				found_ingot = TRUE
				break
		if(!found_ingot && additional_items.len > 0)
			// If no ingot found, just remove the first additional item
			additional_items.Cut(1, 2)

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE, advance_multiplier = 1)
	var/obj/machinery/anvil/anvil = parent
	if(!anvil.hingot)
		return FALSE
	if(!isliving(user))
		return
	var/mob/living/L = user
	var/moveup = 1
	var/proab = 0 // Probability to not spoil the bar
	var/skill_level	= user.get_skill_level(appro_skill)
	if(progress >= max_progress)
		to_chat(user, span_info("It's ready."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	if(needed_item)
		to_chat(user, span_info("Now it's time to add a [needed_item_text]."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	if(using_blade)
		// Blades are partially pre-formed, so easier to work with
		proab += 10 // +10% success chance when using blades
		if(breakthrough)
			moveup *= 1.2 // Blades respond better to good strikes
	// Calculate probability of a successful strike, based on smith's skill level
	if(!skill_level && !craftdiff)
		proab = 35
	else if(skill_level < craftdiff) //Way out of your league, buddy.
		proab = 10
	else
		proab = min(45 * skill_level, 100)
	// Roll the dice to see if the hit actually causes to accumulate progress
	if(prob(proab))
		moveup += round((skill_level * 6 * L.STASTR/10) * (breakthrough == 1 ? 1.5 : 1))
		moveup -= craftdiff
		progress = min(progress + moveup * advance_multiplier, max_progress)
		numberofhits += 1 * advance_multiplier
	else
		moveup = 0
		numberofhits += 1 * advance_multiplier // Increase regardless of success

	// This step is finished, check if more items are needed and restart the process
	if(progress >= max_progress && additional_items.len)
		needed_item = pick(additional_items)
		var/obj/item/I = needed_item
		needed_item_text = initial(I.name)
		additional_items -= needed_item
		progress = 0

	if(!moveup)
		user.mind.add_sleep_experience(appro_skill, advance_multiplier*L.STAINT/(craftdiff+3), FALSE) //Pity XP
		if(!prob(proab)) // Roll again, this time negatively, for consequences.
			user.visible_message(span_warning("[user] ruins the bar!"))
			skill_quality -= 1 // The more you fuck up, the less quality the end result will be.
			bar_health -= craftdiff // Difficulty of the recipe adds to how critical the failure is
			if(parent)
				var/obj/machinery/anvil/P = parent
				switch(skill_level)
					if(0)
						bar_health -= 25 // 4 strikes and you're out, buddy.
					if(1 to 3)
						bar_health -= floor(20 / skill_level)
					if(4)
						bar_health -= 5
					if(5 to 6)
						if(L.badluck(4)) // Unlucky, not unskilled.
							bar_health -= craftdiff
				if(bar_health <= 0)
					user.visible_message(span_danger("[user] destroys the bar!"))
					qdel(P.hingot)
					P.hingot = null
			return FALSE
		else
			user.visible_message(span_warning("[user] fumbles the bar!"))
			return FALSE

	else
		if(user.mind)
			skill_quality += (rand(skill_level*12, skill_level*14) * moveup)*advance_multiplier
			user.mind.add_sleep_experience(appro_skill, advance_multiplier*L.STAINT/(craftdiff+1), FALSE)

		if(breakthrough)
			user.visible_message(span_deadsay("[user] deftly strikes the bar!"))
			if(bar_health < 100)
				bar_health += 20 // Correcting the mistakes, ironing the kinks. Low chance, so rewarding.
		else
			user.visible_message(span_info("[user] strikes the bar!"))

		if(progress >= max_progress && !additional_items.len)
			if(using_blade)
				// Create the item(s)
				handle_creation(anvil.loc)
			else
				anvil.hingot.AddComponent(/datum/component/anvil_quenchable, src, anvil.hingot)
				to_chat(user, span_notice("The bar is ready to be quenched in a bin filled with clean water."))
			return FALSE
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user)
	needed_item = null
	user.visible_message(span_info("[user] adds [needed_item_text]"))
	needed_item_text = null

/datum/anvil_recipe/proc/handle_creation(turf/create_turf)
	// Calculate the quality once
	numberofhits = ceil(numberofhits / num_of_materials)
	if(numberofbreakthroughs)
		numberofhits -= numberofbreakthroughs
	material_quality = floor(material_quality/num_of_materials)-4
	skill_quality = floor((skill_quality/num_of_materials)/1500)+material_quality
	skill_quality -= floor(numberofhits * 0.25)
	var/modifier
	switch(skill_quality)
		if(BLACKSMITH_LEVEL_MIN to BLACKSMITH_LEVEL_SPOIL)
			modifier = 0.3
		if(BLACKSMITH_LEVEL_AWFUL)
			modifier = 0.5
		if(BLACKSMITH_LEVEL_CRUDE)
			modifier = 0.8
		if(BLACKSMITH_LEVEL_ROUGH)
			modifier = 0.9
		if(BLACKSMITH_LEVEL_COMPETENT)
			modifier = 1
		if(BLACKSMITH_LEVEL_FINE)
			modifier = 1.1
		if(BLACKSMITH_LEVEL_FLAWLESS)
			modifier = 1.2
		if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
			modifier = 1.3
			record_round_statistic(STATS_MASTERWORKS_FORGED)

	if(!modifier)
		return

	// Create all the items
	for(var/i = 1 to createditem_num)
		var/obj/item/I = new created_item(create_turf)
		// Apply the quality to each item
		I.name = initial(I.name) // Reset the name first
		if(modifier != 1)
			switch(modifier)
				if(0.3)
					I.name = "ruined [I.name]"
				if(0.5)
					I.name = "awful [I.name]"
				if(0.8)
					I.name = "crude [I.name]"
				if(0.9)
					I.name = "rough [I.name]"
				if(1.1)
					I.name = "fine [I.name]"
				if(1.2)
					I.name = "flawless [I.name]"
				if(1.3)
					I.name = "masterwork [I.name]"
					I.polished = 4
					I.AddComponent(/datum/component/metal_glint)

		I.sellprice *= modifier
		if(istype(I, /obj/item/lockpick))
			var/obj/item/lockpick/L = I
			L.picklvl = modifier

	if(parent)
		var/obj/machinery/anvil/anvil = parent
		anvil.hingot = null
		anvil.currecipe = null
		anvil.hott = null
		anvil.update_icon()

/datum/anvil_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=new_recipe;size=500x810")

/datum/anvil_recipe/proc/generate_html(mob/user)
	var/client/client = user
	if(!istype(client))
		client = user.client
	user << browse_rsc('html/book.png')
	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
		<body>
		  <div>
		    <h1>[icon2html(new created_item, user)][name]</h1>
			<h4>DESCRIPTION: [initial(created_item.desc)]</h4>
			<div>
		"}
	var/obj/item/clothing/suit/roguetown/armor/bookarmor = initial(new created_item)
	var/obj/item/rogueweapon/bookweapon = initial(created_item)

	if(!(bookarmor.armor == "")&&!isnull(bookarmor.armor) )
		var/obj/item/clothing/C = initial(new created_item)
		if(C.body_parts_covered)
			html += "\n<b>COVERAGE: </b>"
			html += " | "
			if(C.body_parts_covered == C.body_parts_covered_dynamic)
				for(var/zone in body_parts_covered2organ_names(C.body_parts_covered))
					html += "<b>[capitalize(zone)]</b> | "
			else
				var/list/zones = list()
				//We have some part peeled, so we turn the printout into precise mode and highlight the missing coverage.
				for(var/zoneorg in body_parts_covered2organ_names(C.body_parts_covered, precise = TRUE))
					zones += zoneorg
				for(var/zonedyn in body_parts_covered2organ_names(C.body_parts_covered_dynamic, precise = TRUE))
					html += "<b>[capitalize(zonedyn)]</b> | "
					if(zonedyn in zones)
						zones.Remove(zonedyn)
				for(var/zone in zones)			
					html += "<b><font color = '#470000'>[capitalize(zone)]</font></b> | "
			html += "<br>"
		if(C.body_parts_inherent)
			html += "<b>CANNOT BE PEELED: </b>"
			var/list/inherentList = body_parts_covered2organ_names(C.body_parts_inherent)
			if(length(inherentList) == 1)
				html += "<b><font color = '#000833'>[capitalize(inherentList[1])]</font></b><br>"
			else
				html += "| "
				for(var/zone in inherentList)
					html += "<b><font color = '#000833'>[capitalize(zone)]</b></font> | "
			html += "<br>"
		if(C.prevent_crits)
			if(length(C.prevent_crits))
				html += "\n<b>PREVENTS CRITS:</b>"
				for(var/X in C.prevent_crits)
					if(X == BCLASS_PICK)	//BCLASS_PICK is named "stab", and "stabbing" is its own damage class. Prevents confusion.
						X = "pick"
					html += ("\n<b>[capitalize(X)]</b><br>")
		html += "INTEGRITY: [bookarmor.max_integrity]<br>"
		if(bookarmor.armor_class == ARMOR_CLASS_HEAVY)
			html += "<b>AC: </b>HEAVY<br>"
		if(bookarmor.armor_class == ARMOR_CLASS_MEDIUM)
			html += "<b>AC: </b>MEDIUM<br>"
		if(bookarmor.armor_class == ARMOR_CLASS_LIGHT)
			html += "<b>AC: </b> LIGHT<br>"
	else if (!isnull(bookweapon) && bookweapon.force>1)
		html += "Combat Properties<br>"
		if(bookweapon.minstr)
			html += "\n<b>MIN.STR:</b> [bookweapon.minstr]<br>"
		
		if(bookweapon.force)
			html += "\n<b>FORCE:</b> [bookweapon.force]<br>"
		if(bookweapon.gripped_intents && !bookweapon.wielded)
			if(bookweapon.force_wielded)
				html += "\n<b>WIELDED FORCE:</b> [bookweapon.force_wielded]<br>"

		if(bookweapon.wbalance)
			html += "\n<b>BALANCE: </b>"
			if(bookweapon.wbalance == WBALANCE_HEAVY)
				html += "Heavy<br>"
			if(bookweapon.wbalance == WBALANCE_SWIFT)
				html += "Swift<br>"
			

		if(bookweapon.wlength != WLENGTH_NORMAL)
			html += "\n<b>LENGTH:</b> "
			switch(bookweapon.wlength)
				if(WLENGTH_SHORT)
					html += "Short<br>"
				if(WLENGTH_LONG)
					html += "Long<br>"
				if(WLENGTH_GREAT)
					html += "Great<br>"

		if(bookweapon.alt_intents)
			html += "\n<b>GRIP: ALT-GRIP (right click while in hand)</b><br>"
		if(bookweapon.gripped_intents)
			html += "\n<b>TWO-HANDED: Yes</b><br>"

		var/shafttext = get_blade_dulling_text(bookweapon, verbose = TRUE)
		if(shafttext)
			html += "\n<b>SHAFT:</b> [shafttext] <br>"

		if(bookweapon.twohands_required)
			html += "\n<b>BULKY</b><br>"
		if(bookweapon.can_parry)
			html += "\n<b>DEFENSE:</b> [bookweapon.wdefense]<br>"
		if(bookweapon.associated_skill && bookweapon.associated_skill.name)
			html += "\n<b>SKILL:</b> [bookweapon.associated_skill.name]<br>"
		
		if(bookweapon.intdamage_factor != 1 && bookweapon.force >= 5)
			html += "\n<b>INTEGRITY DAMAGE:</b> [bookweapon.intdamage_factor * 100]%<br>"

	
	if(craftdiff > 0)
		html += "<h1></h1>For those of [SSskills.level_names_plain[craftdiff]] skills<br>"
	else
		html += "<h1></h1>Suitable for all skills<br>"

	if(appro_skill == /datum/skill/craft/engineering) // SNOWFLAKE!!!
		html += "in Engineering<br>"

	html += {"<div>
		      <strong>Requirements</strong>
			  <br>"}

	html += "[icon2html(new req_bar, user)] Start with [initial(req_bar.name)] on an anvil.<br>"
	html += "Hammer the material.<br>"
	for(var/atom/path as anything in additional_items)
		html += "[icon2html(new path, user)] then add [initial(path.name)]<br>"
		html += "Hammer the material.<br>"

	html += {"
		</div>
		<div>
		"}

	if(createditem_num > 1)
		html += "<strong class=class='scroll'>and then you get</strong> <br> [createditem_num] [icon2html(new created_item, user)]  [initial(created_item.name)]<br>"
	else
		html += "<strong class=class='scroll'>and then you get</strong> <br> [icon2html(new created_item, user)]   [initial(created_item.name)]<br>"

	if(created_item.sellprice)
		html += "<strong class=class='scroll'>You can sell this for [created_item.sellprice] mammons at a normal quality</strong> <br>"
	else
		html += "<strong class=class='scroll'>This is worthless for export</strong> <br>"

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html
