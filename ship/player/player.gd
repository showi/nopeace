extends "/ship/ship.gd"

onready var s_money = get_node("/root/game/viewport/level/status/panel/hbox/money")
onready var s_life = get_node("/root/game/viewport/level/status/panel/hbox/life")
onready var s_shield = get_node("/root/game/viewport/level/status/panel/hbox/shield")
onready var s_weapon = get_node("/root/game/viewport/level/status/panel_weapon/weapon")

onready var model = get_node('model')
onready var weapon = get_node('weapon')

var mouse_speed_factor = 100.0

var player_choice = ['player01', 'player02', 'player03']
var player_index = 0
var _cache = {}
var current_pos = Vector2(0,0)

func _init():
	cstat = cstat_scn.instance()

func _ready():
	._ready()
	set_process_input(true)
	load_model('player02')

var forces = Vector2()

func _input(event):
	if event.type == InputEvent.KEY:
		if not event.pressed:
			return
		for name in ['laser', 'double_bullet', 'plasma']:
			if InputMap.event_is_action(event, 'weapon_%s' % name):
				weapon.switch_model(name)
				print("switched: %s" % name)
	elif (event.type == InputEvent.MOUSE_BUTTON):
		if event.pressed == 0:
			fire(weapon)
	elif (event.type == InputEvent.MOUSE_MOTION):
		forces += (event.pos - get_global_pos())

func _draw():
	draw_circle(get_global_pos(), 10.0, Color('#ff0000'))

func switch_model(name):
	if model:
		remove_child(model)
		model.free()
		model = null
	model = load_model(name).instance()
	add_child(model)
	return model

func load_model(name):
	if not(name in _cache):
		_cache[name] = load("res://ship/player/model/%s.scn" % name)
	return _cache[name]

func _fixed_process(delta):
	._fixed_process(delta)
	if s_life:
		s_money.set_text("%05s$" % money)
		s_life.set_percent_visible(life)
	if forces != null:
		var df = forces * (delta * mouse_speed_factor)
		set_pos(get_pos() + forces)
		forces -= df
		#if forces.length() < 0.001:
		forces = Vector2()
	#update()

func _on_Timer_timeoutddddd():
	if player_index > player_choice.size() - 1:
		player_index = 0
	#switch_model(player_choice[player_index])
	player_index += 1

func _on_weapon_weapon_switch( whoe, name ):
	if s_weapon:
		s_weapon.switch_model(name)
