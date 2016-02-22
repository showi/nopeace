
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
onready var timeout = get_node("Timer")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _show():
	self.show()
	timeout.start()

func _on_timeout():
	self.hide()
