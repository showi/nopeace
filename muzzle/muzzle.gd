
extends Node2D

var freed = false
onready var kill_timer = get_node('kill_timer')

func _ready():
	set_fixed_process(true)
	kill_timer.start()

func _fixed_process(delta):
	if freed:
		kill_timer.stop()
		return free()

func _on_kill_timer_timeout():
	freed = true