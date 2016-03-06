extends "res://ship/enemy/enemy.gd"

signal fire_start
signal fire_stop

export var rotation_speed = 30
export var sequence = [0.5, 0.5, 1.5]
export var fire_angle_threasold = PI / 180
export var distance_threasold = 1500
export var min_rotation = 0.01

#onready var auto_fire_timer = get_node('auto_fire_timer')
onready var canon = get_node('weapon')

var _cache = {}
var ammos = []
var duration = 0
var sequence_idx = 0
var up_vec = Vector2(0, -1)
var down_vec = Vector2(0, 1)
var firing = false
var track = null

func _ready():
	._ready()
	if track == null:
		track = preload('res://class/mouse.gd').new(self)
	wakeup()

func sleep():
	set_fixed_process(false)
	fire_timer.stop()

func wakeup():
	set_fixed_process(true)
	fire_timer.start()

func reconnect():
	connect('fire_start', self, 'on_fire_start')
	connect('fire_stop', self, 'on_fire_stop')

func _on_fire_start():
	firing = true
	
func _on_fire_stop():
	firing = false

func _fixed_process(delta):
	update()
	if distance_to() <= distance_threasold:
		var angle = (angle_to() - canon.get_rot()) * (rotation_speed * delta)
		canon.set_rot(canon.get_rot() + angle)

func _drawd():
	var mp = track.get_mouse_pos()
	var cp = canon.get_pos()
	var angle = angle_to()
	#var screen_coord = get_viewport_transform() * ( get_global_transform() * get_pos() )
	#draw_circle(cp, 50.0, Color('#005500'))
	draw_circle(mp, 10.0, Color('#ff6666'))
	var le = up_vec.rotated(canon.get_rot())* mp.length()
	draw_circle(le, 10.0, Color('ffbb00'))
	draw_line(cp, mp, Color('#0000ff'))
	draw_line(cp, le, Color('#ffffff'))

func angle_to():
	return (canon.get_pos()).angle_to_point(track.get_mouse_pos())

func distance_to():
	return (track.get_mouse_pos() - get_pos()).length()

func fire():
	var fired = []
	var ammo
	var canon = get_node('weapon')
	for child in canon.get_children():
		ammo = child.duplicate(true)
		ammo.hide()
		#ammo.set_pos(ammo.get_pos() + get_global_pos())
		#var rot = (child.get_global_transform() * child.get_pos())
		ammo.set_initiator(canon, child.get_global_pos(), canon.get_rot())
		get_viewport().add_child(ammo)
		ammo.fire()

func _on_fire_timer_timeout():
	stop()
	#var dynamic = get_dynamic()
	var angle = angle_to() - canon.get_rot()
	if distance_to() > distance_threasold:
		sequence_idx = 0
	elif abs(angle) > fire_angle_threasold:
		sequence_idx = 0
	else:
		fire()
	if sequence_idx >= sequence.size():
		sequence_idx = 0
	fire_timer.set_wait_time(sequence[sequence_idx])
	sequence_idx += 1
	#auto_fire_timer.start()
	start()
