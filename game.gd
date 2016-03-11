extends Node2D 

export var level_number = 1

onready var global = get_node("/root/global")
onready var viewport = get_node("viewport")

var dynamic = null

func _ready():
	global.is_level = true
	print("[screen] %s" % get_screen_size())
	load_level(level_number)

func get_screen_size():
	return get_viewport_rect().size
	

func load_level(level_number):
	var path = "res://level/%02d/level_%02d.scn" % [level_number, level_number]
	var level_scn = load(path)
	var level = level_scn.instance()
	global.set_dynamic(level.find_node('dynamicBodies', true, false))
	viewport.add_child(level)
	print("[level] %s <%s>" % [level.name, path])
