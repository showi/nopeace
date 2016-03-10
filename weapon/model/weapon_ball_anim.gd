extends 'res://weapon/ammo/ammo.gd'

func hook_fixed_process(delta):
	set_rot(get_rot() + (rotation_speed * delta))