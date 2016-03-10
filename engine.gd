extends Node2D

onready var timeout = get_node("Timer")

func _ready():
	pass

func _show():
	self.show()
	timeout.start()

func _on_timeout():
	self.hide()
