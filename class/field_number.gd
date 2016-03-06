extends Node2D

signal sig_value_changed(name, value)
signal sig_value_min(name, value)
signal sig_value_max(name, value)

export var field_name = 'foo'
export var value = 0 setget set_value
export var default = 100
export var dec_over_time = 0
export var inc_over_time = 0
export var value_min = 0
export var value_max = 100
export var afflictions_on_start = []

var afflictions = {}

onready var node_progress = get_node('Control/HBoxContainer/progress')
onready var node_label = get_node('Control/HBoxContainer/label')
	
func _ready():
	affliction_parse(afflictions_on_start)
	connect('sig_value_changed', node_progress, '_on_value_changed')
	set_label()
	set_progress()
	set_fixed_process(true)
	emit_signal('sig_value_changed', field_name, value)

func affliction_parse(text):
	for token in afflictions_on_start:
		var part = token.split(':')
		affliction_add(part[0], float(part[1]))

func affliction_remove(name):
	var p_value = afflictions[name]
	if p_value > 0:
		inc_over_time -= p_value
	else:
		dec_over_time -= p_value
	afflictions[name] = null

func affliction_add(name, p_value):
	if name in afflictions:
		affliction_remove(name)
	afflictions[name] = p_value
	if value > 0:
		inc_over_time += p_value
	else:
		dec_over_time += p_value

func _fixed_process(delta):
	var diff = (inc_over_time + dec_over_time)
	if diff != 0:
		set_value(value + diff * delta)

func connecting(target):
	connect('sig_value_changed', target, 'sig_value_changed')
	connect('sig_value_min', target, 'sig_value_min')
	connect('sig_value_max', target, 'sig_value_max')
	
func set_value(p_value):
	if p_value == value:
		return
	elif p_value < value_min:
		value = value_min
		emit_signal('sig_value_min', field_name, p_value)
	elif p_value > value_max:
		value = value_max
		emit_signal('sig_value_max', field_name, p_value)
	else:
		value = p_value
	emit_signal('sig_value_changed', field_name, p_value)

func to_s():
	return '%s: %s (def: %s, min: %s, max: %s)' % [field_name, value, default, value_min, value_max]

func set_label():
	node_label.set_text(field_name)

func set_progress():
	node_progress.set_value(value)
