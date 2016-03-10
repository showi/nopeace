extends Node2D

var target = null
var parent = null
var _which = null

export var draw_radius = 10
export (Color) var draw_color = Color('#ff0000')

export var custom_drawing = true setget set_custom_drawing, get_custom_drawing
var _custom_drawing = true
	
func _init(p_target=null):
	if not p_target:
		p_target = self
	track(p_target)

func _ready():
	if not target:
		track(self)

func set_custom_drawing(value):
	_custom_drawing = bool(value)
	if _custom_drawing:
		set_fixed_process(true)
	else:
		set_fixed_process(false)

func get_custom_drawing():
	return _custom_drawing

func track(p_target):
	target = p_target
	parent = target.get_parent()
	if parent and parent.has_method('get_mouse_pos'):
		_which = parent

func get_mouse_pos():
	#if _which:
	#	return _which.get_mouse_pos()
	return target.get_viewport().get_mouse_pos()
