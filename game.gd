
extends Node2D

var level_number = 1

onready var viewport = get_node("viewport")

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	set_process(true)
	var path = "res://level/%02d/level_%02d.scn" % [level_number, level_number]
	var level_scn = load(path)
	var level = level_scn.instance()
	viewport.add_child(level)
	print("[level] %s <%s>" % [level.name, path])

