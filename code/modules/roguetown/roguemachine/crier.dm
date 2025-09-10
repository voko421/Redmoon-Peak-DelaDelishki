#define TAB_ROUSMAIN 1
#define TAB_SCOMLOG 2
#define TAB_PAYMENTS 3
#define TAB_MANAGESCOMS 4

/obj/structure/roguemachine/crier
	name = "rous master"
	desc = "The crier's most trusted friend."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "crier_machine"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/current_tab = TAB_ROUSMAIN
	var/locked = FALSE
	var/keycontrol = "crier"

/obj/structure/roguemachine/crier/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/roguekey))
		var/obj/item/roguekey/K = P
		if(K.lockid == keycontrol || istype(K, /obj/item/roguekey/lord))
			locked = !locked
			playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
			return
		else
			to_chat(user, span_warning("Wrong key."))
			return
	if(istype(P, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/K = P
		if(!K.contents.len)
			return
		var/list/keysy = K.contents.Copy()
		for(var/obj/item/roguekey/KE in keysy)
			if(KE.lockid == keycontrol)
				locked = !locked
				playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
				return
		to_chat(user, span_warning("Wrong key."))
		return

/obj/structure/roguemachine/crier/Topic(href, href_list)
	. = ..()
	if(!usr.canUseTopic(src, BE_CLOSE) || locked)
		return
	if(href_list["switchtab"])
		current_tab = text2num(href_list["switchtab"])
	return attack_hand(usr)

/obj/structure/roguemachine/crier/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(locked)
		to_chat(user, span_warning("It's locked. Of course."))
		return
	user.changeNext_move(CLICK_CD_INTENTCAP)
	playsound(loc, 'sound/misc/keyboard_enter.ogg', 100, FALSE, -1)
	var/canread = user.can_read(src, TRUE)
	var/contents
	switch(current_tab)
		if(TAB_ROUSMAIN)
			contents += "<center>ROUS MASTER<BR>"
			contents += "--------------<BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_SCOMLOG]'>\[Broadcast Log\]</a><BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_PAYMENTS]'>\[Broadcaster Payments\]</a><BR>"
			contents += "<a href='?src=\ref[src];switchtab=[TAB_MANAGESCOMS]'>\[Manage Broadcasters\]</a><BR>"
			contents += "</center>"
	
		if(TAB_SCOMLOG)
			contents += "<center><b>BROADCAST LOG</b></center><hr>"
			if(!length(GLOB.broadcast_list))
				contents += "<i>No broadcasts logged yet.</i><br>"
			else
				// Show most recent first
				for(var/i = length(GLOB.broadcast_list), i > 0, i--)
					var/entry = GLOB.broadcast_list[i]
					var/msg = entry["message"]
					var/num = entry["number"]
					var/tag = entry["tag"]
					var/time = entry["timestamp"]

					contents += "#[num][tag ? " ([tag])" : ""] @ [time]:<br>"
					contents += "[msg]<br><hr>"

			contents += "<br><a href='?src=\ref[src];switchtab=[TAB_ROUSMAIN]'>\[Back\]</a>"

	if(!canread)
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 700, 800)
	popup.set_content(contents)
	popup.open()

#undef TAB_ROUSMAIN
#undef TAB_SCOMLOG
#undef TAB_PAYMENTS
#undef TAB_MANAGESCOMS