extends Node2D

var speed = 30;
var parent;

func _ready():
	set_fixed_process(true)
	parent = get_parent()
	parent.set_offset(0)
	#set_pos(parent.get_pos())

func _fixed_process(delta):
	parent.set_offset(parent.get_offset() + (speed * delta)) 
