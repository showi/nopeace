extends 'res://class/np_physic.gd'

const explosion_scn = preload("res://explosion/explosion.scn")
const powerup_scn = preload("res://powerup/powerup.scn")

onready var drop_rate = get_node('stat/drop_rate')

var explosion = null

func _init():
	explosion = explosion_scn.instance()

func _ready():
	._ready()
	stat.set_value('life', 80 + rand_range(0, 40))

func drop():
	if drop_rate.value <= 0:
		return
	if rand_range(0.0, 1.0) >= drop_rate.value:
		return
	var powerup = powerup_scn.instance()
	powerup.set_pos(get_global_pos())
	get_dynamic().add_child(powerup)

func explode():
	var boom = explosion.random()
	boom.set_pos(get_global_pos())
	get_dynamic().add_child(boom)

func kill():
	hide()
	drop()
	explode()
	if is_respawning:
		set_respawn(true)
	else:
		.kill()
func set_respawn(value):
	_respawn = bool(value)

func get_respawn(value):
	return _respawn
