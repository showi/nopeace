extends Node

export var path_fmt = 'res://capture/nopeace_%02s.png'

var index = 0
var viewport = null
var record = false

func _ready():
	viewport = get_viewport()
	# start()
	
func start():
	index = 0
	record = true
	set_fixed_process(true)	

func stop():
	record = false
	set_fixed_process(false)
	set_process(false)

func _fixed_process(delta):
	record_frame()

func record_frame():
	viewport.queue_screen_capture()
	yield(get_tree(), 'idle_frame')
	yield(get_tree(), 'idle_frame')
	var img = viewport.get_screen_capture()
	if img.get_width() < 1 or img.get_height() < 1:
		return
	img.save_png(path_fmt % index)
	index += 1

	#var file = File.new()
	#var fh = file.open("res://capture/img01.bmp", file.WRITE);
	#file.store_buffer(img.)
	#file.close()
