extends 'res://class/np_physic.gd'

onready var timer = get_node('Timer')

func _ready():
	set_fixed_process(true)
	restart()

func _fixed_process(delta):
	if freed:
		timer.stop()
		return self.free()

func restart():
	owner = self
	timer.set_wait_time(rand_range(1, 3))
	timer.start()

func kill():
	hide()
	freed = true

func _on_Timer_timeout():
	kill()
