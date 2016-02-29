extends ParallaxLayer

export var speed = 15

func _ready():
	set_process(true)

func _process(delta):
	var curpos = get_global_pos()
	curpos.y = curpos.y  + speed * delta
	set_pos(curpos)

