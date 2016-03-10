extends 'res://class/np_object.gd'

signal weapon_switch(who, name)

var model = null

export var weapon_selected = 'laser'
export var weapon_choice = ['laser', 'double_bullet', 'plasma', 'ball']
export var auto_fire = false
export var auto_switch = false
export var auto_switch_wait_time = 2.0
export var sequence = [0.5]

var sequence_idx = 0
var energy = 0

onready var fire_timer = get_node('fire_timer')
onready var switch_timer = get_node('switch_timer')

func _ready():
	reconnect()
	if not weapon_selected:
		weapon_selected = weapon_random()
	weapon_select(weapon_selected)

func reconnect():
	if not fire_timer.is_connected('timeout', self, '_on_fire_timer_timeout'):
		fire_timer.connect('timeout', self, '_on_fire_timer_timeout')
	if not switch_timer.is_connected('timeout', self, '_on_switch_timer_timeout'):
		switch_timer.connect('timeout', self, '_on_switch_timer_timeout')		

func auto_switch_start():
	switch_timer.set_wait_time(auto_switch_wait_time)
	switch_timer.start()

func auto_fire_sequence_next():
	sequence_idx += 1
	if sequence_idx >= sequence.size():
		sequence_idx = 0
	return sequence[sequence_idx]

func auto_fire_start():
	var next = auto_fire_sequence_next()
	fire_timer.set_wait_time(next)	
	fire_timer.start()

func auto_fire_stop():
	fire_timer.stop()

func weapon_select(name):
	fire_timer.stop()
	switch_timer.stop()
	if weapon_selected == name and model:
		pass#return model
	else:
		if model:
			model.free()
		weapon_selected = name
		model = load_model(name).instance()
		model.team = team
		add_child(model)
		emit_signal('weapon_switch', self, name)
	if auto_fire:
		fire_timer.set_wait_time(0.1)
		fire_timer.start()
	if auto_switch:
		switch_timer.start()
	return model

func load_model(name):
	return load('res://weapon/model/weapon_%s.scn' % name)

func weapon_random():
	return weapon_choice[rand_range(0, weapon_choice.size())]

func fire():
	return model.fire(energy)

func _on_fire_timer_timeout():
	auto_fire_stop()
	fire()
	auto_fire_start()
	
func _on_switch_timer_timeout():
	weapon_select(weapon_random())

func to_s():
	return '[WeaponSystem/%s]\n\tselected:%s\n\tauto_fire: %s\n\tauto_switch: %s' % [get_instance_ID(), weapon_selected, auto_fire, auto_switch]
