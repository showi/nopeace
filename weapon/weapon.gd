extends "res://class/np_object.gd"

signal weapon_switch(whoe, name)

var model = null

export var weapon_selected = 'laser'
export var weapon_choice = ['laser', 'double_bullet', 'plasma']
export var auto_fire = false

onready var auto_fire_timer = get_node('auto_fire_timer')
onready var game = get_node('/root/game')

const up_vec = Vector2(0, -1)

func _ready():
	if weapon_selected:
		switch_model(weapon_selected)

func switch_model(name):
	var hide = false
	if model:
		hide = model.is_hidden()
		model.free()		
	weapon_selected = name
	model = load_model(name).instance()
	if hide:
		model.hide()
	else:
		model.show()
	self.add_child(model)
	if auto_fire:
		auto_fire_timer.set_wait_time(model.duration)
		auto_fire_timer.start()
	emit_signal('weapon_switch', self, name)
	return model

func load_model(name):
	return load("res://weapon/model/weapon_%s.scn" % name)

func fire(initiator, pos, lookat):
	return model.fire(initiator, pos, lookat)	

func _on_auto_fire_timer_timeout():
	var pos = get_pos()
	var dynamic = game.get_dynamic()
	for child in fire(self, pos, up_vec):
		child.set_layer_mask(2)
		child.set_linear_velocity(pos)
		dynamic.add_child(child)
		child.fire(up_vec.rotated(get_rot()).normalized())
		child.show()
	auto_fire_timer.start()