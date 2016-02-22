extends RigidBody2D

export var team = 1
export var kind = 0

var explosion_scn = preload("res://explosion/explosion.scn")
var bullet_scn = preload("res://fire/bullet.scn")
var bullet
onready var level = get_node("/root/game/viewport/level")

func _ready():
	set_fixed_process(true)
	bullet = bullet_scn.instance()

func _fixed_process(delta):
	pass

func _on_enemy_body_enter( body ):
	if body.team == null or body.team == team:
		return
	if body.kind != 1:
		return
	var explosion = explosion_scn.instance()
	explosion.set_pos(body.get_pos())
	level.add_child(explosion)
	level.prune(self)
	level.prune(body)