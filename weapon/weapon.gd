extends "res://class/np_object.gd"

export var duration = 3
export var auto_fire = false

onready var ammos = get_node('ammos')
var fire_timer = null

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
	fire_timer.set_wait_time(duration + rand_range(0, 5))
	fire_timer.start()

var vec_up = Vector2(0, -1)

func fire(energy=0):
	var ammo = null
	var rot = get_parent().get_rot()
	var dynamic = get_dynamic()
	for child in ammos.get_children():
		ammo = child.duplicate(true)
		ammo.energy = energy
		ammo.team = team
		#ammo.set_collision_mask(team)
		ammo.set_rot(get_pivot().get_rot())
		ammo.set_pos(get_global_transform() *  Vector2())
		dynamic.add_child(ammo)
		ammo.fire()
		
func _on_auto_fire_timer_timeout():
	fire(self)
	auto_fire_start()