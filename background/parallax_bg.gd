extends ParallaxLayer

func _ready():
	set_process(true)

func _process(delta):
	var curpos = get_pos()
	curpos.y = curpos.y  + 25 * delta
	set_pos(curpos)

