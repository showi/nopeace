extends "res://class/np_object.gd"

export var duration = 3

func fire(initiator, pos, lookat):
	var fired = []
	var ammo = null
	for child in get_children():
		ammo = child.duplicate(true)
		ammo.hide()
		ammo.team = initiator.team
		ammo.set_owner(initiator)
		ammo.set_pos(child.get_global_pos())
		ammo.set_rot(child.get_rot())
		fired.append(ammo)
	return fired
