extends Node2D

export var num_explosion = 12

var explosions = []

func _init():
	preload_explosion()

func preload_explosion():
	var path = null
	for i in range(1, num_explosion + 1):
		path = "res://explosion/explosion%02d.scn" % i
		# print("Loading path: %s" % path)
		var module = load(path)
		explosions.append(module)

func _ready():
	pass

func at_index(index):
	return explosions[index]

func random(length=num_explosion):
	return explosions[rand_range(0, length)].instance()
