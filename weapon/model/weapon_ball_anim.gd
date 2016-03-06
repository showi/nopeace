extends 'res://weapon/ammo/ammo.gd'

func _fixed_process(delta):
	if not ._fixed_process(delta):
		return
	set_rot(get_rot() + (speed * delta))
