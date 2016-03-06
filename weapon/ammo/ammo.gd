extends "res://class/character.gd"

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
	freed = false
	set_fixed_process(true)
	if auto_fire:
		fire()

func start():
	kill_timer.set_wait_time(duration)
	kill_timer.start()

func reconnect():
	if not is_connected('body_enter', self, '_on_body_enter'):
		connect('body_enter', self, '_on_body_enter')
	if not kill_timer.is_connected('timeout', self, '_on_kill_timer_timeout'):
		kill_timer.connect('timeout', self, '_on_kill_timer_timeout')

func _fixed_process(delta):
	if freed:
		kill_timer.stop()
		emit_signal('killed')
		free()
		return false
	return true

func fire():
	if initiator:
		var src = initiator.src.get_ref()
		if not src:
			print('Error no ref nod')
			return
		var force = (up_vec.rotated(initiator.rot).normalized() * speed)
		if src.team != null:
			team = src.team
		set_rot(initiator.rot)
		set_pos(initiator.pos)
		set_applied_force(force)
	else:
		set_applied_force(up_vec * speed)
	show()
	start()
	emit_signal('fired', self)

func respawn():
	hide()
	restore_rigid()
	start()
	show()

func kill():
	if is_respawning:
		respawn()
	else:
		freed = true
	return freed

func hit_with():
	pass

func _on_kill_timer_timeout():
	kill()
