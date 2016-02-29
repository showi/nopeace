extends "res://class/np_physic.gd"


const explosion_scn = preload("res://explosion/explosion.scn")
const cstat_scn = preload("res://cstat/cstat.scn")
const powerup_scn = preload("res://powerup/powerup.scn")

var explosion = null
var bullet = null 
var cstat = null

var backup = {
	"_restore": false,
	"pos": Vector2(),
	"rot": 0,
	"velocity": Vector2(),
	"life": 100,
}

func _ready():
	save_rigid()
	set_fixed_process(true)

func _init():
	explosion = explosion_scn.instance()

func save_rigid():
	var pos = get_pos()
	var vel = get_linear_velocity()
	backup.rot = get_rot()
	backup.pos.x = pos.x
	backup.pos.y = pos.y
	backup.velocity.x = vel.x
	backup.velocity.y = vel.y
	backup.life = life

func restore_rigid():
	set_pos(backup.pos)
	set_rot(backup.rot)
	set_linear_velocity(backup.velocity)
	life = backup.life

func respawn():
	backup._restore = true

func drop():
	if drop_rate <= 0:
		return
	if rand_range(0.0, 1.0) >= drop_rate:
		return
	var powerup = powerup_scn.instance()
	powerup.set_pos(self.get_pos())
	get_dynamic().add_child(powerup)

func kill():
	hide()
	drop()
	if is_respawning:
		respawn()
	else:
		print('kill ship')
		free()

func _fixed_process(delta):
	if backup._restore:
		restore_rigid()
		backup._restore = false
		show()
	apply_impulse(get_pos(), up_vec.rotated(get_rot()).normalized() *  speed * delta)
	set_angular_velocity(0)

func fire(weapon):
	var pos = get_pos()
	var dynamic = get_dynamic()
	for ammo in weapon.fire(self):
		dynamic.add_child(ammo)
		ammo.fire()
		ammo.show()

func explode():
	var boom = explosion.random()
	boom.set_pos(get_pos())
	get_dynamic().add_child(boom)

func _on_respawn_timer_timeout():
	respawn()