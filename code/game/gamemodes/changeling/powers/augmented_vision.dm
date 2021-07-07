//Augmented Vision: Gives you x-ray vision OR flash immunity. High DNA cost because of how powerful it is.

/datum/action/changeling/augmented_vision
	name = "Augmented Vision"
	desc = "Creates more light sensing rods in our eyes, allowing our vision to penetrate most blocking objects. Protects our vision from flashes while inactive."
	helptext = "Grants us x-ray vision or flash protection. We will become much more vulnerable to flash-based devices while x-ray vision is active."
	button_icon_state = "augmented_vision"
	chemical_cost = 0
	dna_cost = 2 //Would be 1 without x-ray vision
	active = FALSE

/datum/action/changeling/augmented_vision/on_purchase(mob/user) //The ability starts inactive, so we should be protected from flashes.
	if(!istype(user))
		return
	..()
	ADD_TRAIT(user, TRAIT_FLASH_PROTECTION, CHANGELING_POWER)
	to_chat(user, "<span class='notice'>We adjust our vision to protect them from bright lights.</span>")

/datum/action/changeling/augmented_vision/sting_action(mob/living/carbon/user)
	if(!istype(user))
		return
	..()
	if(!active)
		REMOVE_TRAIT(user, TRAIT_FLASH_PROTECTION, CHANGELING_POWER)
		ADD_TRAIT(user, TRAIT_FLASH_VULNERABILITY, CHANGELING_POWER)
		ADD_TRAIT(user, TRAIT_XRAY_VISION, CHANGELING_POWER)
		to_chat(user, "<span class='notice'>We adjust our vision to sense prey through walls.</span>")
		active = TRUE
	else
		REMOVE_TRAIT(user, TRAIT_FLASH_VULNERABILITY, CHANGELING_POWER)
		REMOVE_TRAIT(user, TRAIT_XRAY_VISION, CHANGELING_POWER)
		ADD_TRAIT(user, TRAIT_FLASH_PROTECTION, CHANGELING_POWER)
		to_chat(user, "<span class='notice'>We adjust our vision to protect them from bright lights.</span>")
		active = FALSE
	user.update_sight()
	return TRUE


/datum/action/changeling/augmented_vision/Remove(mob/user) //Get rid of x-ray vision and flash protection when the user refunds this ability
	if(!istype(user))
		return
	REMOVE_TRAIT(user, TRAIT_FLASH_VULNERABILITY, CHANGELING_POWER)
	REMOVE_TRAIT(user, TRAIT_XRAY_VISION, CHANGELING_POWER)
	user.update_sight()
	..()
