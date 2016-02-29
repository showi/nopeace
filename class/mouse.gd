extends Node

var target = null
var parent = null
var _which = null

func _init(p_target):
	target = p_target
	parent = target.get_parent()
	if parent and parent.has_method('get_mouse_pos'):
		_which = parent

func get_mouse_pos():
	if _which:
		return _which.get_mouse_pos()
	return target.get_global_transform().inverse() * target.get_viewport_transform().inverse() * (target.get_viewport().get_mouse_pos())
