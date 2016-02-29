extends "res://class/np_physic.gd"

signal fired(ammo)

export var duration = 5
export var auto_fire = false

onready var kill_timer = get_node('kill_timer')

var up_vec = Vector2(0, -1)
var forces = Vector2()

func _ready():
	reconnect()
	freed = false
	if auto_fire:
		fire()

func start():
	set_fixed_process(true)
	kill_timer.set_wait_time(duration)
	kill_timer.start()

func reconnect():
	if not kill_timer.is_connected('timeout', self, '_on_kill_timer_timeout'):
		kill_timer.connect('timeout', self, '_on_kill_timer_timeout')

func _fixed_process(delta):
	if freed:
		kill_timer.stop()
		return free()
	apply_impulse(get_pos(), forces * delta)
	set_angular_velocity(0)

func fire():
	var owner = get_initiator()
	var lookat = up_vec.rotated(owner.get_rot()).normalized()
	forces = lookat * speed
	set_linear_velocity(forces)
	set_rot(get_rot() + owner.get_rot())
	set_pos(get_global_pos() + owner.get_global_pos())
	emit_signal('fired', self)
	start()

func kill():
	freed = true

func hit_with():
	pass

func _on_kill_timer_timeout():
	kill()