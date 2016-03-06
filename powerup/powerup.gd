extends 'res://class/character.gd'

onready var timer = get_node('Timer')

func _ready():
	set_fixed_process(true)
	get_node('stat/damage').value = -25
	restart()

func _fixed_process(delta):
	if freed:
		timer.stop()
		return free()

func restart():
	timer.set_wait_time(rand_range(1, 3))
	timer.start()

func kill():
	hide()
	freed = true

func _on_Timer_timeout():
	kill()
