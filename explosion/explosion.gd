
extends Node2D

onready var timer = get_node("Timer")

func _ready():
	timer.start()


func _on_Timer_timeout():
	self.hide()
	self.get_parent().prune(self)
