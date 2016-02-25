extends "res://class/np_object.gd"

signal weapon_switch(whoe, name)

var model = null

export var weapon_selected = 'laser'
export var weapon_choice = ['laser', 'double_bullet', 'plasma']
export var auto_fire = false

onready var auto_fire_timer = get_node('auto_fire_timer')
var vec_up = Vector2(0, -1)

var _cache = {}

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
	print("name: %s" % name)
	if not(name in _cache):
		name = "res://weapon/model/weapon_%s.scn" % name
		_cache[name] = load(name)
	return _cache[name]

func fire(initiator, pos, lookat):
	return model.fire(initiator, pos, lookat)	


func _on_auto_fire_timer_timeout():
	for child in fire(self, Vector2(0,0), vec_up):
		child.set_layer_mask(2)
		child.set_linear_velocity(Vector2(0,0))
		model.add_child(child)
		child.show()
	