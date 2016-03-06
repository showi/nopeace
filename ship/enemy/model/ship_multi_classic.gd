extends 'res://ship/enemy/enemy.gd'

export var color_name = 'Black'
export var skin_name = ''
export var modulate_color = true

var skin_selected = null

onready var skin = get_node('skin')

func _ready():
	._ready()
	if skin_name == '':
		skin_name = skin_random()
	skin_select(skin_name)
	save_rigid()
	set_fixed_process(true)

func respawn():
	skin_select(skin_random())
	.respawn()

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
	return get_node('skin').get_child(rand_range(0, get_node('skin').get_child_count())).get_name()

func _on_skin_auto_change_timeout():
	skin_select(skin_random())
