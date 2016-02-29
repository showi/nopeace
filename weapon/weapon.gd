extends "res://class/np_object.gd"

signal weapon_switch(whoe, name)

var model = null

export var weapon_selected = 'laser'
export var weapon_choice = ['laser', 'double_bullet', 'plasma']
export var auto_fire = false

onready var auto_fire_timer = get_node('auto_fire_timer')

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

func fire(initiator):
	return model.fire(initiator)	

func hit_by_ammo(ammo):
	pass

func _on_auto_fire_timer_timeout():
	var pos = get_pos()
	var dynamic = get_dynamic()
	for child in fire(self):
		child.set_layer_mask(2)
		dynamic.add_child(child)
		child.fire()
		child.show()
	auto_fire_timer.start()