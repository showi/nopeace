extends "/level/base.gd"

onready var dynamic = get_node("dynamic")

func add_dynamic(node):
	dynamic.add_child(node)

func _on_worldbound_body_enter( body ):
	print("into void")
