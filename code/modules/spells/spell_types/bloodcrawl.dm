/obj/effect/proc_holder/spell/bloodcrawl
	name = "Blood Crawl"
	desc = ""
	recharge_time = 0
	clothes_req = FALSE
	//If you couldn't cast this while phased, you'd have a problem
	phase_allowed = TRUE
	selection_type = "range"
	range = 1
	cooldown_min = 0
	overlay = null
	action_icon_state = "bloodcrawl"
	action_background_icon_state = "bg_demon"
	var/phased = FALSE

/obj/effect/proc_holder/spell/bloodcrawl/choose_targets(mob/user = usr)
	for(var/obj/effect/decal/cleanable/target in range(range, get_turf(user)))
		if(target.can_bloodcrawl_in())
			perform(target)
			return
	revert_cast()
	to_chat(user, span_warning("There must be a nearby source of blood!"))

/obj/effect/proc_holder/spell/bloodcrawl/perform(obj/effect/decal/cleanable/target, recharge = 1, mob/living/user = usr)
	if(istype(user))
		if(phased)
			if(user.phasein(target))
				phased = FALSE
		else
			if(user.phaseout(target))
				phased = TRUE
		start_recharge()
		return
	revert_cast()
	to_chat(user, span_warning("I are unable to blood crawl!"))
