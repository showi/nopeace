extends 'res://ship/enemy/enemy.gd'

export var color_name = 'Black'
export var skin_name = ''
export var modulate_color = true

var skin_selected = null

onready var skin = get_node('skin')
onready var weapon = get_node('weapon')

func _ready():
	._ready()
	reconnect()
	if skin_name == '':
		skin_name = skin_random()
	skin_select(skin_name)
	save_rigid()
	set_children_property()
	set_fixed_process(true)

func set_children_property():
	weapon.team = team

func respawn():
	skin_select(skin_random())
	.respawn()

func hook_fixed_process(delta):
	if get_linear_velocity().length() < speed:
		apply_impulse(get_pos(), up_vec.rotated(get_rot()) * acceleration * delta)
		set_angular_velocity(0)

func skin_select(name):
	if skin_selected:
		skin_selected.hide()
	skin_name = name
	skin_selected = skin.get_node(name)
	if modulate_color:
		skin_selected.get_node('Sprite').modulate = Color(rand_range(0,1.0), rand_range(0,1.0), rand_range(0,1.0), rand_range(0.5, 1.0))	
	weapon.weapon_select(weapon.weapon_random())
	skin_selected.show()

func skin_random():
	return skin.get_child(rand_range(0, skin.get_child_count())).get_name()

func _on_skin_auto_change_timeout():
	skin_select(skin_random())
