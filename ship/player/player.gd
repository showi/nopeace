extends "/ship/ship.gd"

onready var model = get_node('model')
onready var weapon = get_node('weapon')

var mouse_speed_factor = 12.0

var player_choice = ['player01', 'player02', 'player03']
var player_index = 0
var _cache = {}
var current_pos = Vector2(0,0)
var forces = Vector2()


func _ready():
	reconnect()
	._ready()
	energy = stat.get_node('energy')
	switch_model('player02')
	save_rigid()
	set_fixed_process(true)
	set_process_input(true)
	print('player %s %s' % [kind, team])

func _input(event):
	if event.type == InputEvent.KEY:
		if InputMap.event_is_action(event, 'fire_first'):
			fire_helper(event)
		elif InputMap.event_is_action(event, 'ui_right'):
			set_rot(get_rot() - 0.3)
		elif InputMap.event_is_action(event, 'ui_left'):
			set_rot(get_rot() + 0.3)
		for name in ['laser', 'double_bullet', 'plasma', 'ball']:
			if InputMap.event_is_action(event, 'weapon_%s' % name):
				weapon.weapon_select(name)
				break
	elif (event.type == InputEvent.MOUSE_BUTTON):
		fire_helper(event)
	elif (event.type == InputEvent.MOUSE_MOTION):
		forces = (event.pos - get_pos())

func fire_helper(event):
	if event.pressed:
		energy.affliction_add('regen', 100)
	else:
		weapon.energy = energy.value
		if energy.affliction_exists('regen'):
			energy.affliction_remove('regen')
		energy.value = 0
		fire(weapon)

func switch_model(name):
	if model:
		remove_child(model)
		model.free()
		model = null
	model = load_model(name).instance()
	model.team = team
	model.kind = kind
	add_child(model)
	return model

func load_model(name):
	if not name in _cache:
		_cache[name] = load("res://ship/player/model/%s.scn" % name)
	return _cache[name]

func hook_fixed_process(delta):
	.hook_fixed_process(delta)
	if forces != null:
		var df = forces * (delta * mouse_speed_factor)
		set_pos(get_pos() + df)
		forces = null

func _on_weapon_weapon_switch( who, name ):
	if weapon:
		weapon.weapon_select(name)

func _on_life_sig_value_changed( name, value ):
	stat.set_value('life', value)

