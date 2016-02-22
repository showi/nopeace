extends RigidBody2D

export var team = 0
export var kind = 1

var velocity = Vector2(0, -200)

func _ready():
	pass

func _integrate_forces(state):
	pass
	
func _fire(level, ev):
	set_pos(ev.pos)
	set_linear_velocity(velocity)
	pass