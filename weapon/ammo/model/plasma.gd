extends 'res://weapon/ammo/ammo.gd'

onready var pathfollow = get_node('Path2D/PathFollow2D')

func reconnect():
	.reconnect()
	if not is_connected('fired', pathfollow, '_on_plasma_fired'):
		connect('fired', pathfollow, '_on_plasma_fired')