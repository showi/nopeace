extends "res://class/np_object.gd"

export var duration = 3
export var auto_fire = true

onready var fire_timer = get_node('auto_fire_timer')
onready var ammos = get_node('ammos')

func _ready():
	if auto_fire:
		auto_fire_start()

func auto_fire_stop():
	fire_timer.stop()

func auto_fire_start():
	auto_fire_stop()
	fire(self)
	fire_timer.set_wait_time(duration)
	fire_timer.start()

func fire(initiator):
	var fired = []
	var ammo = null
	for child in ammos.get_children():
		ammo = child.duplicate(true)
		ammo.hide()
		ammo.set_initiator(initiator)
		fired.append(ammo)
	return fired

func _on_auto_fire_timer_timeout():
	auto_fire_start()