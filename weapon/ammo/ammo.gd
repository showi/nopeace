extends "res://class/np_object.gd"

export var duration = 5
export var damage = 75
export var speed = 300

onready var timer = get_node('Timer')

func _ready():
	set_fixed_process(true)
	timer.set_wait_time(duration)
	timer.start()

func _fixed_process(delta):
	if freed:
		timer.stop()
		return self.free()

func kill():
	#hide()
	freed = true

func _on_Timer_timeout():
	kill()

func hit_with():
	pass