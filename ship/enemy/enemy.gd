extends "/ship/ship.gd"

export var auto_fire = false

onready var fire_timer = get_node('fire_timer')
onready var life_pb = get_node('Node2D/life_pb')
onready var weapon = get_node('weapon')

func _init():
	._init()
	life = 80 + rand_range(0, 40)

func _ready():
	._ready()
	var sprite = get_node('Sprite')
	sprite.modulate = Color(rand_range(0,1.0), rand_range(0,1.0), rand_range(0,1.0), rand_range(0.5, 1.0))	
	if auto_fire:
		start()

func start():
	fire_timer.set_wait_time(rand_range(1.0, 3.0))
	fire_timer.start()

func stop():
	fire_timer.stop()

func _fixed_process(delta):
	._fixed_process(delta)
	life_pb.set_value(life)
	
func _on_fire_timer_timeout():
	stop()
	var dynamic = get_dynamic()
	for ammo in weapon.fire(self):
		dynamic.add_child(ammo)
		ammo.fire()
		ammo.show()
	start()
