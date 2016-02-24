extends Node2D

onready var player = get_node("player")
#
#var name = "music01"
var name = "res://asset/music/music01.wav"

func _ready():
	print("Playing music")
	player.stop_all()
	player.play(name, 1)


