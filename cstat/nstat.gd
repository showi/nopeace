extends Control

func _ready():
	pass

func to_s():
	var out = '[stat]\n'
	for child in get_children():
		out += '%s\n' % child.to_s()
	return out

func set_value(who, value):
	get_node(who).value = value
	
func get_value(who):
	return get_node(who).value
