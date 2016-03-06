extends Node

var fname = null setget set_fname, get_fname
var value = null setget set_value, get_value
var default = null setget set_default, get_default
var type = null setget set_type, get_type

func _init(p_name, p_value, p_default):
	fname = p_name
	value = p_value
	default = p_default

func set_fname(name):
	fname = name

func get_fname():
	return fname

func set_value(p_value):
	value = p_value
	
func get_value():
	return value

func set_default(p_default):
	default = p_default

func get_default():
	return default

func set_type(p_type):
	type = p_type

func get_type():
	return type