/datum/anvil_recipe/valuables
	abstract_type = /datum/anvil_recipe/valuables
	appro_skill = /datum/skill/craft/blacksmithing
	craftdiff = SKILL_LEVEL_JOURNEYMAN // These are VALUABLES
	i_type = "Valuables"

/datum/anvil_recipe/valuables/gold
	name = "Statue, Gold"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/roguestatue/gold
	craftdiff = SKILL_LEVEL_EXPERT

/datum/anvil_recipe/valuables/silver
	name = "Statue, Silver"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/roguestatue/silver
	craftdiff = SKILL_LEVEL_EXPERT

/datum/anvil_recipe/valuables/iron
	name = "Statue, Iron"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/roguestatue/iron

/datum/anvil_recipe/valuables/aalloy
	name = "Statue, Decrepit" // decrepit
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/roguestatue/aalloy

/datum/anvil_recipe/valuables/steel
	name = "Statue, Steel"
	req_bar = /obj/item/ingot/steel
	created_item = /obj/item/roguestatue/steel

/*
/datum/anvil_recipe/valuables/eargol
	name = "gold earrings"
	req_bar = /obj/item/ingot/gold
	created_item = list(/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold,
						/obj/item/rogueacc/eargold)
	type = "Valuables"

/datum/anvil_recipe/valuables/earsil
	name = "silver earrings"
	req_bar = /obj/item/ingot/silver
	created_item = list(/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver,
						/obj/item/rogueacc/earsilver)*/
//	i_type = "Valuables"

/datum/anvil_recipe/valuables/ringg
	name = "Rings, Gold (x3)"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/ring/gold
	craftdiff = SKILL_LEVEL_EXPERT
	createditem_num = 3

/datum/anvil_recipe/valuables/ringa
	name = "Rings, Decrepit (x3)"
	req_bar = /obj/item/ingot/aalloy
	created_item = /obj/item/clothing/ring/aalloy
	createditem_num = 3

/datum/anvil_recipe/valuables/rings
	name = "Rings, Silver (x3)"
	req_bar = /obj/item/ingot/silver
	created_item = /obj/item/clothing/ring/silver
	craftdiff = SKILL_LEVEL_EXPERT
	createditem_num = 3

/datum/anvil_recipe/valuables/ornateamulet
	name = "Ornate Amulet"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/roguetown/ornateamulet
	craftdiff = SKILL_LEVEL_EXPERT

/datum/anvil_recipe/valuables/skullamulet
	name = "Skull Amulet"
	req_bar = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/roguetown/skullamulet
	craftdiff = SKILL_LEVEL_EXPERT

//Gold Rings
/datum/anvil_recipe/valuables/emeringg
	name = "Gemerald Ring, Gold (+1 Gemerald)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/roguegem/green)
	craftdiff = SKILL_LEVEL_EXPERT
	created_item = /obj/item/clothing/ring/emerald

/datum/anvil_recipe/valuables/rubyg
	name = "Rontz Ring, Gold (+1 Rontz)"
	req_bar = /obj/item/ingot/gold
	craftdiff = SKILL_LEVEL_EXPERT
	additional_items = list(/obj/item/roguegem/ruby)
	created_item = /obj/item/clothing/ring/ruby

/datum/anvil_recipe/valuables/topazg
	name = "Toper Ring, Gold (+1 Toper)"
	req_bar = /obj/item/ingot/gold
	craftdiff = SKILL_LEVEL_EXPERT
	additional_items = list(/obj/item/roguegem/yellow)
	created_item = /obj/item/clothing/ring/topaz

/datum/anvil_recipe/valuables/quartzg
	name = "Blortz Ring, Gold (+1 Blortz)"
	req_bar = /obj/item/ingot/gold
	craftdiff = SKILL_LEVEL_EXPERT
	additional_items = list(/obj/item/roguegem/blue)
	created_item = /obj/item/clothing/ring/quartz
	i_type = "Valuables"

/datum/anvil_recipe/valuables/sapphireg
	name = "Saffira Ring, Gold (+1 Saffira)"
	req_bar = /obj/item/ingot/gold
	craftdiff = SKILL_LEVEL_EXPERT
	additional_items = list(/obj/item/roguegem/violet)
	created_item = /obj/item/clothing/ring/sapphire

/datum/anvil_recipe/valuables/diamondg
	name = "Dorpel Ring, Gold (+1 Dorpel)"
	req_bar = /obj/item/ingot/gold
	craftdiff = SKILL_LEVEL_EXPERT
	additional_items = list(/obj/item/roguegem/diamond)
	created_item = /obj/item/clothing/ring/diamond

/datum/anvil_recipe/valuables/signet
	name = "Signet Ring"
	req_bar = /obj/item/ingot/gold
	craftdiff = SKILL_LEVEL_EXPERT
	created_item = /obj/item/clothing/ring/signet

/datum/anvil_recipe/valuables/signet/silver
	name = "Blessed Silver Signet Ring"
	craftdiff = SKILL_LEVEL_MASTER
	req_bar = /obj/item/ingot/silverblessed
	created_item = /obj/item/clothing/ring/signet/silver	

/datum/anvil_recipe/valuables/signet/silver/inq
	name = "Blessed Silver Signet Ring"
	craftdiff = SKILL_LEVEL_MASTER
	req_bar = /obj/item/ingot/silverblessed/bullion
	created_item = /obj/item/clothing/ring/signet/silver	

// Silver ingots are now in play, and as such, the steel rings have been converted to silver with their value adjusted accordingly. -Kyogon

/datum/anvil_recipe/valuables/emerings
	name = "Gemerald Ring, Silver (+1 Gemerald)"
	req_bar = /obj/item/ingot/silver
	craftdiff = SKILL_LEVEL_MASTER
	additional_items = list(/obj/item/roguegem/green)
	created_item = /obj/item/clothing/ring/emeralds

/datum/anvil_recipe/valuables/rubys
	name = "Rontz Ring, Silver (+1 Rontz)"
	req_bar = /obj/item/ingot/silver
	craftdiff = SKILL_LEVEL_MASTER
	additional_items = list(/obj/item/roguegem/ruby)
	created_item = /obj/item/clothing/ring/rubys

/datum/anvil_recipe/valuables/topazs
	name = "Toper Ring, Silver (+1 Toper)"
	req_bar = /obj/item/ingot/silver
	craftdiff = SKILL_LEVEL_MASTER
	additional_items = list(/obj/item/roguegem/yellow)
	created_item = /obj/item/clothing/ring/topazs

/datum/anvil_recipe/valuables/quartzs
	name = "Blortz Ring, Silver (+1 Blortz)"
	req_bar = /obj/item/ingot/silver
	craftdiff = SKILL_LEVEL_MASTER
	additional_items = list(/obj/item/roguegem/blue)
	created_item = /obj/item/clothing/ring/quartzs

/datum/anvil_recipe/valuables/sapphires
	name = "Saffira Ring, Silver (+1 Saffira)"
	req_bar = /obj/item/ingot/silver
	craftdiff = SKILL_LEVEL_MASTER
	additional_items = list(/obj/item/roguegem/violet)
	created_item = /obj/item/clothing/ring/sapphires

/datum/anvil_recipe/valuables/diamonds
	name = "Dorpel Ring, Silver (+1 Dorpel)"
	req_bar = /obj/item/ingot/silver
	craftdiff = SKILL_LEVEL_MASTER
	additional_items = list(/obj/item/roguegem/diamond)
	created_item = /obj/item/clothing/ring/diamonds

/datum/anvil_recipe/valuables/terminus
	name = "Terminus Est (+1 Gold Bar, +1 Steel, +1 Rontz)"
	req_bar = /obj/item/ingot/gold
	additional_items = list(/obj/item/ingot/gold, /obj/item/ingot/steel, /obj/item/roguegem/ruby)
	created_item = /obj/item/rogueweapon/sword/long/exe/cloth
	craftdiff = SKILL_LEVEL_MASTER
	appro_skill = /datum/skill/craft/weaponsmithing
	i_type = "Weapons"

/datum/anvil_recipe/valuables/dragon
	name = "Dragonstone Ring (Secret!)"
	req_bar = /obj/item/ingot/blacksteel
	additional_items = list(/obj/item/ingot/gold, /obj/item/roguegem/blue, /obj/item/roguegem/violet, /obj/item/clothing/neck/roguetown/psicross/silver)
	created_item = /obj/item/clothing/ring/dragon_ring
	craftdiff = SKILL_LEVEL_LEGENDARY

/datum/anvil_recipe/valuables/hope
	name = "Ring Of Omnipotence (Secret!)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/clothing/ring/statgemerald, /obj/item/clothing/ring/statonyx, /obj/item/clothing/ring/statamythortz, /obj/item/clothing/ring/statrontz)
	created_item = /obj/item/clothing/ring/statdorpel
	craftdiff = SKILL_LEVEL_LEGENDARY

/datum/anvil_recipe/valuables/daemonslayer
	name = "Daemonslayer (Secret!)"
	req_bar = /obj/item/ingot/silver
	additional_items = list(/obj/item/ingot/silver, /obj/item/ingot/silver, /obj/item/ingot/silver, /obj/item/ingot/silver/, /obj/item/ingot/draconic, /obj/item/ingot/weeping, /obj/item/riddleofsteel, /obj/item/grown/log/tree)
	created_item = /obj/item/rogueweapon/greatsword/psygsword/dragonslayer
	appro_skill = /datum/skill/craft/weaponsmithing
	craftdiff = SKILL_LEVEL_LEGENDARY
