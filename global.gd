extends Node

var _dynamic_body = null
var is_level = false

func set_dynamic(p_dynamic):
	if not p_dynamic:
		print('setting null dynamic')
	_dynamic_body = p_dynamic

func get_dynamic():
	if not _dynamic_body:
		_dynamic_body = get_node('/root')
	return _dynamic_body
