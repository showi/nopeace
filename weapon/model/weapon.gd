extends "res://class/np_object.gd"

export var duration = 3
export var auto_fire = true

onready var fire_timer = get_node('fire_timer')
onready var ammos = get_node('ammos')

func _ready():
	if auto_fire:
		auto_fire_start()

func auto_fire_stop():
	fire_timer.stop()

func auto_fire_start():
	auto_fire_stop()
	for ammo in fire(self):
		get_dynamic().add_child(ammo)
		ammo.show()
	fire_timer.set_wait_time(duration)
	fire_timer.start()

func fire(initiator):
	var fired = []
	var ammo = null
	for child in ammos.get_children():
		ammo = child.duplicate(true)
		ammo.team = initiator.team
		ammo.hide()
		ammo.set_initiator(initiator, ammo.get_global_pos(), ammo.get_rot())
		fired.append(ammo)
	return fired

func _on_auto_fire_timer_timeout():
	auto_fire_start()