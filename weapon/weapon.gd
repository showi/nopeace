extends "res://class/np_object.gd"

export var duration = 3
export var auto_fire = false

onready var fire_timer = get_node('fire_timer')
onready var ammos = get_node('ammos')

var _draw_queue = []

func _ready():
	if auto_fire:
		auto_fire_start()

func auto_fire_stop():
	fire_timer.stop()

func _draw():
	print('draw')
	for pos in _draw_queue:
		draw_circle(pos, 10, Color('#ff00ff'))

func auto_fire_start():
	fire_timer.stop()
	fire(self)
	fire_timer.set_wait_time(duration)
	fire_timer.start()

func fire(initiator):
	var fired = []
	var ammo = null
	for child in ammos.get_children():
		ammo = child.duplicate(true)
		ammo.hide()
		ammo.team = initiator.team
		#_draw_queue.append(child.get_global_pos())
		ammo.set_initiator(initiator, initiator.get_global_pos(), initiator.get_rot())
		add_child(ammo)
		ammo.set_as_toplevel(true)
		ammo.fire()
		ammo.show()
	update()

func _on_auto_fire_timer_timeout():
	auto_fire_start()