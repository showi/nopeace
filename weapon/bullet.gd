extends RigidBody2D

export var team = 0
export var kind = 1
var owner = null
var damage = 33
var _look_at = Vector2(0, -1)
var velocity = Vector2(0, -400)
var alive = true

onready var level = get_node("/root/game/viewport/level")

func _ready():
	set_fixed_process(true)

func _on_kill_timer_timeout():
	alive = false
	
func _fixed_process(delta):
	if not alive:
		free()
	
func _fire(p_owner, event):
	owner = p_owner
	team = p_owner.team
	set_rot(owner.get_rot())
	set_pos(event.pos)
	if team == 0: 
		set_linear_velocity(velocity.rotated(get_rot()))
	else:
		set_linear_velocity(Vector2(velocity.x, - velocity.y).rotated(get_rot()))
	set_angular_damp(owner.get_angular_damp())
