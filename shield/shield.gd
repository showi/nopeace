extends RigidBody2D

var team = 0
var kind = 5
var owner = null
var damage = 10

func _ready():
	owner = get_parent()

func hit_with(target, ammo):
	pass


func _on_shield_body_enter( body ):
	print("Something touch shield")