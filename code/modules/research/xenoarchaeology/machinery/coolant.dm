/obj/structure/reagent_dispensers/coolanttank
	name = "coolant tank"
	desc = "A tank of industrial coolant"
	icon = 'icons/obj/objects.dmi'
	icon_state = "coolanttank"
	amount_per_transfer_from_this = 10

/obj/structure/reagent_dispensers/coolanttank/Initialize(mapload, ...)
	. = ..()
	reagents.add_reagent("coolant",1000)

/obj/structure/reagent_dispensers/coolanttank/bullet_act(var/obj/item/projectile/Proj)
	if(Proj.get_structure_damage())
		if(!istype(Proj ,/obj/item/projectile/plasma/lastertag) && !istype(Proj ,/obj/item/projectile/beam/practice) )
			if (!(Proj.testing))
				explode()

/obj/structure/reagent_dispensers/coolanttank/ex_act()
	explode()

/obj/structure/reagent_dispensers/coolanttank/explode()
	var/datum/effect/effect/system/smoke_spread/S = new /datum/effect/effect/system/smoke_spread
	//S.attach(src)
	S.set_up(5, 0, src.loc)

	playsound(src.loc, 'sound/effects/smoke.ogg', 50, 1, -3)
	spawn(0)
		S.start()

	var/datum/gas_mixture/env = src.loc.return_air()
	if(env)
		if (reagents.total_volume > 750)
			env.temperature = 0
		else if (reagents.total_volume > 500)
			env.temperature -= 100
		else
			env.temperature -= 50

	sleep(10)
	if(src)
		qdel(src)
