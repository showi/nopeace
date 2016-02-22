
extends Node2D

var name = "First can be better"

var prunes = []

func _ready():
	set_fixed_process(true)

func prune(node):
	prunes.append(node)
	
func _fixed_process(delta):
	for node in prunes:
		self.remove_child(node)
	prunes = []