extends "res://class/np_physic.gd"

export var money = 100
export var life = 100
export var drop_rate = 0.2
export var damage = 10
export var is_respawning = true

const explosion_scn = preload("res://explosion/explosion.scn")
const cstat_scn = preload("res://cstat/cstat.scn")
const powerup_scn = preload("res://powerup/powerup.scn")

onready var game = get_node("/root/game")

var explosion = null
var bullet = null 
var cstat = null

const up_vec = Vector2(0, -1)

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
	team = 0
	kind = 0
	owner = self
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
	game.get_dynamic().add_child(powerup)

func kill():
	hide()
	drop()
	if is_respawning:
		respawn()
	else:
		free()

func _fixed_process(delta):
	if backup._restore:
		restore_rigid()
		backup._restore = false
		show()

func fire(weapon):
	var pos = get_pos()
	var dynamic = game.get_dynamic()
	for ammo in weapon.fire(self, pos, up_vec):
		dynamic.add_child(ammo)
		ammo.fire(up_vec.rotated(get_rot()).normalized())
		ammo.show()

func explode():
	var boom = explosion.random()
	boom.set_pos(get_pos())
	game.get_dynamic().add_child(boom)

func _on_respawn_timer_timeout():
	respawn()