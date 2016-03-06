extends Node

export var name = "NEW_LEVEL"

func _ready():
	pass

func get_parallax():
	print('get_parallax')
	return get_node('background').get_parallax()