extends Node2D

export var level_number = 1

onready var viewport = get_node("viewport")
var dynamic = null

func _ready():
	print("[screen] %s" % get_screen_size())
	load_level(level_number)

func get_dynamic(default='mock_dynamic'):
	if dynamic:
		return dynamic
	dynamic = get_node('/root/game/viewport/level/dynamic')
	if not dynamic:
		dynamic = get_node(default)
	return dynamic

func get_screen_size():
	return get_viewport_rect().size
	
func load_level(level_number):
	var path = "res://level/%02d/level_%02d.scn" % [level_number, level_number]
	var level_scn = load(path)
	var level = level_scn.instance()
	viewport.add_child(level)
	print("[level] %s <%s>" % [level.name, path])
