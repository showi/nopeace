extends "/ship/ship.gd"

onready var model = get_node('model')
onready var weapon = get_node('weapon')

var mouse_speed_factor = 12.0

var player_choice = ['player01', 'player02', 'player03']
var player_index = 0
var _cache = {}
var current_pos = Vector2(0,0)

func _ready():
	switch_model('player02')
	._ready()
	#set_as_toplevel(true)
	set_fixed_process(true)
	set_process_input(true)

var forces = Vector2()

func _input(event):
	if event.type == InputEvent.KEY:
		if not event.pressed:
			return
		if InputMap.event_is_action(event, 'fire_first'):
			fire(weapon)
		elif InputMap.event_is_action(event, 'ui_right'):
			set_rot(get_rot() - 0.3)
		elif InputMap.event_is_action(event, 'ui_left'):
			set_rot(get_rot() + 0.3)
		for name in ['laser', 'double_bullet', 'plasma', 'ball']:
			if InputMap.event_is_action(event, 'weapon_%s' % name):
				weapon.weapon_select(name)
				break
	elif (event.type == InputEvent.MOUSE_BUTTON):
		if event.pressed == 0:
			fire(weapon)
	elif (event.type == InputEvent.MOUSE_MOTION):
		#set_pos(event.pos)
		var diff = (event.pos - get_pos())
		#if diff.length() > 512:
		#	set_pos(event.pos)
		#	forces = Vector2()
		#else:
		forces += diff

func switch_model(name):
	if model:
		remove_child(model)
		model.free()
		model = null
	model = load_model(name).instance()
	model.team = team
	model.kind = kind
	add_child(model)
	model.connect('body_enter', self, '_on_body_enter')
	return model

func load_model(name):
	if not name in _cache:
		_cache[name] = load("res://ship/player/model/%s.scn" % name)
	return _cache[name]

func _fixed_process(delta):
	._fixed_process(delta)
	if forces != null:
		var df = forces * (delta * mouse_speed_factor)
		if df.length() < 0.001:
			forces = Vector2()
		else:
			set_pos(get_pos() + df)
			forces -= df
		if forces.length() < 0.0001:
			forces = Vector2()

func _on_weapon_weapon_switch( whoe, name ):
	if weapon:
		print('trigger')
		weapon.weapon_select(name)

