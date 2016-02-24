export var frame_max = 23
export var speed = 25

var accu = 0

func _ready():
	set_fixed_process(true)
	set_frame(int(accu))

func restart():
	accu = 0
	set_frame(int(accu))


func _fixed_process(delta):
	accu += delta * speed;
	if accu >= frame_max:
		accu = 0
	set_frame(int(accu))
	