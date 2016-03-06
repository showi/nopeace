extends 'res://class/np_object.gd'

signal weapon_switch(who, name)

var model = null

export var weapon_selected = 'laser'
export var weapon_choice = ['laser', 'double_bullet', 'plasma', 'ball']
export var auto_fire = false
export var auto_switch = false
export var auto_switch_wait_time = 2.0
export var sequence = [1.0]
var sequence_idx = 0

onready var fire_timer = get_node('fire_timer')
onready var switch_timer = get_node('switch_timer')

const up_vec = Vector2(0, -1)

func _ready():
	if not weapon_selected:
		weapon_selected = weapon_random()
	weapon_select(weapon_selected)
	if auto_switch:
		auto_switch_start()
	print(to_s())

func to_s():
	return '[WeaponSystem/%s]\n\tselected:%s\n\tauto_fire: %s\n\tauto_switch: %s' % [get_instance_ID(), weapon_selected, auto_fire, auto_switch]

func auto_switch_start():
	switch_timer.set_wait_time(auto_switch_wait_time)
	switch_timer.start()

func weapon_select(name):
	fire_timer.stop()
	switch_timer.stop()
	if weapon_selected == name and model:
		return model
	if model:
		model.free()
	weapon_selected = name
	model = load_model(name).instance()
	model.auto_fire = false
	model.team = team
	model.hide()
	self.add_child(model)
	if auto_fire:
		fire_timer.set_wait_time(model.duration)
		fire_timer.start()
	emit_signal('weapon_switch', self, name)
	return model

func load_model(name):
	return load('res://weapon/model/weapon_%s.scn' % name)

func weapon_random():
	return weapon_choice[rand_range(0, weapon_choice.size())]

func fire(initiator):
	return model.fire(initiator)	

func hit_by_ammo(ammo):
	pass

func _on_auto_fire_timer_timeout():
	fire_timer.stop()
	fire(self)
	if sequence_idx > sequence.size():
		sequence_idx = 0
	fire_timer.set_wait_time(sequence[sequence_idx])	
	fire_timer.start()

func _on_switch_timer_timeout():
	weapon_select(weapon_random())
