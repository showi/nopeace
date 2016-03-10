extends "res://ship/enemy/enemy.gd"

signal fire_start
signal fire_stop

export var rotation_speed = 30
export var sequence = [0.5, 0.5, 1.5]
export var fire_angle_threasold = PI / 180
export var distance_threasold = 1500
export var min_rotation = 0.01

var duration = 0
var sequence_idx = 0
var track = null

onready var ammos = get_node('ammos')

func _ready():
	._ready()
	if track == null:
		track = preload('res://class/mouse.gd').new(ammos)
	set_fixed_process(true)

func sleep():
	set_fixed_process(false)
	fire_timer.stop()

func _fixed_process(delta):
	if distance_to() <= distance_threasold:
		ammos.set_rot( angle_to())
	update()

func get_mouse_pos():
	return get_global_transform().inverse() * get_viewport_transform().inverse() * get_viewport().get_mouse_pos()

func _draw():
	var mp = get_mouse_pos()
	var cp = ammos.get_pos()
	var angle = angle_to()
	print('angle: %s' % angle)
	#var screen_coord = get_viewport_transform() * ( get_global_transform() * get_pos() )
	draw_circle(cp, 50.0, Color('#aa55aa'))
	draw_circle(mp, 5.0, Color('#0000aa'))
	var le = up_vec.rotated(ammos.get_rot())* mp.length()
	draw_circle(le, 10.0, Color('dd0000'))
	#draw_line(cp, mp, Color('#0000ff'))
	#draw_line(cp, le, Color('#ffffff'))

func angle_to():
	return get_pos().angle_to_point(get_mouse_pos())

func distance_to():
	return (get_mouse_pos() - ammos.get_pos()).length()

func fire_helper():
	print('fire helper rot: %s' % ammos.get_rot())
	var ammo
	for child in ammos.get_children():
		ammo = child.duplicate(true)
		ammo.set_initiator(self, get_pos(), ammos.get_rot())
		ammo.set_as_toplevel(true)
		get_viewport().add_child(ammo)
		ammo.fire()

func get_fire_wait_time():
	return sequence[sequence_idx]

func apply_speed():
	pass

func fire():
	print('fire')
	var angle = angle_to() - ammos.get_rot()
	if distance_to() > distance_threasold:
		sequence_idx = 0
	elif abs(angle) > fire_angle_threasold:
		sequence_idx = 0
	else:
		fire_helper()
	if sequence_idx < sequence.size():
		sequence_idx = 0
	else:
		sequence_idx += 1