extends "res://class/np_object.gd"

signal fired(ammo)

export var duration = 5
export var damage = 75
export var speed = 300
export var auto_fire = false

#export var kind = 0
#export var team = 3
#var freed = false

onready var kill_timer = get_node('kill_timer')

var up_vec = Vector2(0, -1)
var forces = Vector2()

func _ready():
	reconnect()
	freed = false
	if auto_fire:
		fire(Vector2(0, -1))

func start():
	set_fixed_process(true)
	kill_timer.set_wait_time(duration)
	kill_timer.start()

func reconnect():
	kill_timer.connect('timeout', self, '_on_kill_timer_timeout')

func _fixed_process(delta):
	if freed:
		kill_timer.stop()
		return free()
	apply_impulse(get_pos(), forces * delta)
	set_angular_velocity(0)

func fire(lookat):
	forces = lookat * speed
	set_linear_velocity(forces)
	set_rot(up_vec.angle_to(lookat))
	emit_signal('fired', self)
	start()

func kill():
	freed = true

func hit_with():
	pass

func _on_kill_timer_timeout():
	kill()