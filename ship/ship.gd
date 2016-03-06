extends 'res://class/np_physic.gd'

const explosion_scn = preload("res://explosion/explosion.scn")
const powerup_scn = preload("res://powerup/powerup.scn")

var _respawn = false
var explosion = null

var backup = {
	"pos": Vector2(),
	"rot": 0,
	"velocity": Vector2(),
}

func _ready():
	._ready()
	set_applied_force(up_vec.rotated(get_rot()) * speed)

func _init():
	explosion = explosion_scn.instance()

func set_respawn(value):
	_respawn = bool(value)

func drop():
	var drop_rate = get_node('stat/drop_rate')
	if drop_rate.value <= 0:
		return
	if rand_range(0.0, 1.0) >= drop_rate.value:
		return
	var powerup = powerup_scn.instance()
	powerup.set_pos(get_global_pos())
	get_viewport().add_child(powerup)

func kill():
	hide()
	drop()
	explode()
	if is_respawning:
		set_respawn(true)
	else:
		free()

func _fixed_process(delta):
	if _respawn:
		restore_rigid()
		set_respawn(false)
		show()
	update()

func fire(weapon):
	weapon.fire(self)

func explode():
	var boom = explosion.random()
	boom.set_pos(get_global_pos())
	get_viewport().add_child(boom)

func _on_respawn_timer_timeout():
	respawn()