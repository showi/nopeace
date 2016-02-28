extends Node2D

onready var timer = get_node('Timer')
onready var sprite = get_node('AnimatedSprite')

var freed = false
var factor = 1.2
var scale_vec = Vector2(factor, factor)
onready var animated = get_node('AnimatedSprite')

func _ready():
	set_fixed_process(true)
	restart()

func _fixed_process(delta):
	if freed:
		self.free()
		return
	animated.scale(get_scale() + (scale_vec*delta))
	

func restart():
	sprite.restart()
	timer.start()

func kill():
	hide()
	freed = true

func _on_Timer_timeout():
	kill()
