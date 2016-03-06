extends 'res://ship/enemy/enemy.gd'

export var rot_speed = 20

func _fixed_process(delta):
	sprite.set_rot(sprite.get_rot() + (rot_speed * delta))
	._fixed_process(delta)