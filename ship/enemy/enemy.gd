extends 'res://class/np_physic.gd'

const explosion_scn = preload("res://explosion/explosion.scn")
const powerup_scn = preload("res://powerup/powerup.scn")

var explosion = null

func _ready():
	._ready()
	explosion = explosion_scn.instance()
	stat.set_value('life', 80 + rand_range(0, 40))

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
