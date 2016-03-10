extends "res://class/np_object.gd"

export var duration = 3
export var auto_fire = false

onready var ammos = get_node('ammos')
var fire_timer = null

var _draw_queue = []

func _ready():
	fire_timer = fire_init()
	set_children_properties()
	if auto_fire:
		auto_fire_start()
	
func set_children_properties():
	for ammo in ammos.get_children():
		ammo.hide()
		ammo.team = team

func fire_init():
	if not has_node('fire_timer'):
		var node = Timer.new()
		node.set_name('fire_timer')
		add_child(node)
	return get_node('fire_timer')

func auto_fire_stop():
	fire_timer.stop()

func auto_fire_start():
	fire_timer.stop()
	fire_timer.set_wait_time(duration)
	fire_timer.start()

var vec_up = Vector2(0, -1)

func fire(energy=0):
	var ammo = null
	var rot = get_parent().get_rot()
	var t = get_global_transform()
	for child in ammos.get_children():
		ammo = child.duplicate(false)
		ammo.energy = energy
		#ammo.set_initiator(i, i.get_global_pos() + child.get_pos(), initiator.get_rot(), energy)
		get_viewport().add_child(ammo)
		ammo.set_as_toplevel(true)
		ammo.set_pos(child.get_global_pos())
		ammo.set_rot(rot)
		ammo.fire()
		#ammo.set_as_toplevel(true)
		
func _on_auto_fire_timer_timeout():
	fire(self)
	auto_fire_start()