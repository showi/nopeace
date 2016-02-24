
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
onready var path = get_node("/root/game/viewport/level/path/01")

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	pass # get_parent().set_offset()


