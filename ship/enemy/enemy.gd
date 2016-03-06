extends 'res://class/np_physic.gd'

const explosion_scn = preload("res://explosion/explosion.scn")
const powerup_scn = preload("res://powerup/powerup.scn")

export var auto_fire = false

onready var fire_timer = get_node('fire_timer')
onready var weapon = get_node('weapon')
var explosion = null
var _respawn = null

func _init():
	explosion = explosion_scn.instance()
	._init()
	
func _ready():
	._ready()
	stat.set_value('life', 80 + rand_range(0, 40))
	set_applied_force(up_vec.rotated(get_rot()) * speed)
	if auto_fire:
		start()

func _fixed_process(delta):
	if _respawn:
		restore_rigid()
		set_respawn(false)
		show()
	update()

func start():
	fire_timer.set_wait_time(rand_range(1.0, 3.0))
	fire_timer.start()

func stop():
	fire_timer.stop()
	
func _on_fire_timer_timeout():
	stop()
	weapon.fire(self)
	start()

func drop():
	var drop_rate = get_node('stat/drop_rate')
	if drop_rate.value <= 0:
		return
	if rand_range(0.0, 1.0) >= drop_rate.value:
		return
	var powerup = powerup_scn.instance()
	powerup.set_pos(get_global_pos())
	get_viewport().add_child(powerup)

func explode():
	var boom = explosion.random()
	boom.set_pos(get_global_pos())
	get_viewport().add_child(boom)

func set_respawn(value):
	_respawn = bool(value)

func get_respawn(value):
	return _respawn

func kill():
	hide()
	drop()
	explode()
	if is_respawning:
		set_respawn(true)
	else:
		free()
