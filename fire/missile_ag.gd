extends Node2D

onready var timer = get_node("Timer")
onready var step01 = get_node("step01")
onready var step02 = get_node("step02")

var index = 0

func _ready():
	timer.start()

func hide_all():
	step01.hide()
	step02.hide()

func next():
	print('n')
	if index > 3:
		timer.stop()
		call_deferred('free', self)
		return
	if index == 0:
		step02.hide()
		step01.show()
	elif index == 1:
		step01.hide()
		step02.get_node("explosion/AnimatedSprite").restart()
		step02.show()
	index += 1
	timer.start()

func _on_Timer_timeout():
	next()	
