//Augmented Eyesight: Gives you xray vision OR flash protection. High DNA cost because of how powerful it is.
//Possible todo: make a custom message for directing a penlight/flashlight at the eyes - not sure what would display though.

/datum/action/changeling/augmented_eyesight
	name = "Augmented Eyesight"
	desc = "Creates more light sensing rods in our eyes, allowing our vision to penetrate most blocking objects. Protects our vision from flashes while inactive."
	helptext = "Grants us x-ray vision or flash protection. We will become a lot more vulnerable to flash-based devices while x-ray vision is active."
	button_icon_state = "augmented_eyesight"
	chemical_cost = 0
	dna_cost = 2 //Would be 1 without xray vision
	active = FALSE

/datum/action/changeling/augmented_eyesight/on_purchase(mob/user) //The ability starts inactive, so we should be protected from flashes.
	if(!istype(user))
		return
	..()
	ADD_TRAIT(user, TRAIT_FLASH_PROTECTION)

/datum/action/changeling/augmented_eyesight/sting_action(mob/living/carbon/user)
	if(!istype(user))
		return
	..()
	if(!active)
		ADD_TRAIT(user, TRAIT_XRAY_VISION)
		REMOVE_TRAIT(user, TRAIT_FLASH_PROTECTION)
		to_chat(user, "<span class='notice'>We adjust our eyes to sense prey through walls.</span>")
		active = TRUE
	else
		ADD_TRAIT(user, TRAIT_FLASH_PROTECTION)
		REMOVE_TRAIT(user, TRAIT_XRAY_VISION)
		to_chat(user, "<span class='notice'>We adjust our eyes to protect them from bright lights.</span>")
		active = FALSE
	user.update_sight()
	return TRUE


/datum/action/changeling/augmented_eyesight/Remove(mob/user) //Get rid of x-ray vision and flash protection when the user refunds this ability
	if(!istype(user))
		return
	REMOVE_TRAIT(user, TRAIT_XRAY_VISION)
	REMOVE_TRAIT(user, TRAIT_FLASH_PROTECTION)
	user.update_sight()
	..()
