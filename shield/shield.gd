extends 'res://class/np_physic.gd'

onready var parent = get_node('../')
onready var shield = get_node('stat/shield')

func _ready():
	._ready()
	set_fixed_process(true)
	#connect('body_enter_shape', self, '_on_body_enter_shaper')
	
func _fixed_process(delta):
	if shield.value <= 0:
		hide()
	else:
		show()
