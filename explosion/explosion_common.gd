extends Node2D

onready var timer = get_node('Timer')
onready var sprite = get_node('AnimatedSprite')

func _ready():
	restart()

func restart():
	sprite.restart()
	timer.start()

func _on_Timer_timeout():
	self.hide()
	call_deferred('free', self)

