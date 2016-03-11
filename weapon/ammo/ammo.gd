extends "res://class/np_physic.gd"

signal fired(ammo)
signal killed()

export var duration = 5
export var auto_fire = false

onready var kill_timer = get_node('kill_timer')
var field_number = preload('res://class/field_damage.scn')

var forces = Vector2()

func _ready():
	._ready()
	reconnect()
	set_fixed_process(true)
	if auto_fire:
		start()

func start():
	kill_timer.set_wait_time(duration)
	kill_timer.start()

func reconnect():
	.reconnect()
	kill_timer.connect('timeout', self, '_on_kill_timer_timeout')

func fire():
	var force = (up_vec.rotated(get_rot()).normalized() * speed)
	if energy > 0:
		var damage = stat.get_value('damage')
		var dmgcent = damage / 100.0
		stat.set_value('damage', damage + (dmgcent * energy))
		var sc = energy / 10
		get_node('Sprite').set_scale(Vector2(sc, sc))
		set_scale(Vector2(sc, sc))
	set_applied_force(force)
	show()
	start()
	emit_signal('fired', self)

func respawn():
	hide()
	restore_rigid()
	start()
	show()

func _on_kill_timer_timeout():
	kill()
