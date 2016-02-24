extends Node2D
# 0: player, 1: enemy, 2: other
export(int, "player", "enemy", "other") var team
# 0: ship, 1: shot, 2: world, 3: powerup, 4: shield
export(int, "ship", "shot", "world", "powerup", "shield") var kind
export var money = 100
export var life = 100
export var drop_rate = 0.2
export var damage = 10
export var respawn = true

const explosion_scn = preload("res://explosion/explosion.scn")
#preload("res://explosion/explosion.scn")
const bullet_scn = preload("res://fire/bullet.scn")
const cstat_scn = preload("res://cstat/cstat.scn")
const powerup_scn = preload("res://powerup/powerup.scn")
const pool_scn = preload("res://pool/pool.scn")

onready var level = get_node("/root/game/viewport/level")

var owner = null
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
	level.add_dynamic(powerup)

func kill(delete):
	hide()
	drop()
	if delete:
		call_deferred('free', self)
	else:
		respawn()
	
func _fixed_process(delta):
	if backup._restore:
		restore_rigid()
		backup._restore = false
		show()

func hit_with(target, ammo):
	money += target.money

func _on_respawn_timer_timeout():
	respawn()
	
func fire(target, ev):
	bullet = bullet_scn.instance()
	bullet.hide()
	level.add_dynamic(bullet)
	bullet.get_node('particle').set_color('ff0000')
	bullet.set_rot(-target.get_rot())
	bullet.look_at(target.get_pos())
	bullet.show()
	bullet._fire(target, ev)

func _on_enemy_body_enter( body ):
	if body == null:
		return
	elif body.kind == 2 and body.team == 2: # enter void
		if self.kind==1:
			kill(false)
		else:
			free(self)
		return
	#if body.team != team:
	body.owner.hit_with(self, body)
	if body.damage > 0:
		self.life -= body.damage
	if self.life <= 0:
		self.life = 0
		var e = explosion.random()
		e.set_pos(body.get_pos())
		level.add_dynamic(e)
		kill((team != 1))
