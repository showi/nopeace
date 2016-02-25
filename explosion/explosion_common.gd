extends Node2D

onready var timer = get_node('Timer')
onready var sprite = get_node('AnimatedSprite')

var freed = false

func _ready():
	set_fixed_process(true)
	restart()

func _fixed_process(delta):
	if freed:
		self.free()

func restart():
	sprite.restart()
	timer.start()

func kill():
	hide()
	freed = true

func _on_Timer_timeout():
	kill()
