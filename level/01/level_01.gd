extends "/level/base.gd"

onready var dynamic = get_node("dynamic")

func _ready():
	print('Capture')
	var img = get_viewport().get_screen_capture()
	#var file = File.new()
	#var fh = file.open("res://capture/img01.bmp", file.WRITE);
	#file.store_buffer(img.)
	#file.close()
	img.save_png("res://capture/img01.png")
	
func add_dynamic(node):
	dynamic.add_child(node)

func _on_worldbound_body_enter( body ):
	print("into void")
