extends 'res://weapon/ammo/ammo.gd'

onready var pathfollow = get_node('Path2D/PathFollow2D')

func reconnect():
	connect('fired', pathfollow, '_on_plasma_fired')
	.reconnect()