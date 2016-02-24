extends "/ship/ship.gd"

var velocity = Vector2(0, 900)
var _lookat = Vector2(0, 1)
onready var timer = get_node('fire_timer')
onready var life_pb = get_node('life_pb')

func _init():
	owner = self
	team = 1
	kind = 0
	life = 80 + rand_range(0, 40)
	
func _ready():
	set_fixed_process(true)
	bullet = bullet_scn.instance()
	var sprite = get_node('Sprite')
	sprite.modulate = Color(rand_range(0,1.0), rand_range(0,1.0), rand_range(0,1.0), rand_range(0.5, 1.0))	

func _fixed_process(delta):
	apply_impulse(get_pos(), velocity * delta)
	set_angular_velocity(0)
	life_pb.set_value(life)
	
func _on_fire_timer_timeout():
	timer.set_wait_time(rand_range(1.4, 3))
	self.fire(self, {'pos': self.get_pos(), 'color': Color('#ff00ff')})
