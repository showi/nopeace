extends Node2D

var life = 100
var shield = 100

func _ready():
	pass

func _on_hit(ev):
	print("Hit by something")