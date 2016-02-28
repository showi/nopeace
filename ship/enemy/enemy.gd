extends "/ship/ship.gd"

export var speed = 600
export var auto_fire = false

var velocity = Vector2(0, speed)
var up_vec = Vector2(0, -1)

onready var timer = get_node('fire_timer')
onready var life_pb = get_node('life_pb')
onready var weapon = get_node('weapon')
#onready var game = get_node('/root/game')

func _init():
	owner = self
	life = 80 + rand_range(0, 40)
	
func _ready():
	set_fixed_process(true)
	var sprite = get_node('Sprite')
	sprite.modulate = Color(rand_range(0,1.0), rand_range(0,1.0), rand_range(0,1.0), rand_range(0.5, 1.0))	

func _fixed_process(delta):
	apply_impulse(get_pos(), up_vec.rotated(get_rot()).normalized() *  speed * delta)
	set_angular_velocity(0)
	life_pb.set_value(life)
	
func _on_fire_timer_timeout():
	var dynamic = game.get_dynamic()
	for ammo in weapon.fire(self, get_pos(), up_vec.rotated(get_rot()).normalized()):
		dynamic.add_child(ammo)
		ammo.fire(up_vec.rotated(get_rot()).normalized())
		ammo.show()
	timer.set_wait_time(rand_range(1.4, 3))
