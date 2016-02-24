extends Node2D

export var team = 0
export var kind = 4

var damage = 0
var owner = null

func _ready():
	owner = self
	var timer = get_node('Timer')
	timer.set_wait_time(rand_range(0.25, 1.45))
	timer.start()

func _on_Timer_timeout():
	hide()
	call_deferred('free', self)

func hit_with(target, ammo):
	pass