extends 'res://ship/enemy/enemy.gd'

export var entity_selected = ''
export var random_rotation_speed = true
export var random_speed = true

onready var entities = get_node('entities')

func _ready():
	entities_hide_all()
	if entity_selected == '':
		entity_selected = entity_random()
	entity_select(entity_selected)
	if random_rotation_speed:
		rotation_speed = rand_range(-rotation_speed, rotation_speed)
	if random_speed:
		speed = rand_range(0, speed)
	if rotation_speed:
		set_fixed_process(true)
	set_rot(rand_range(-PI, PI))
	apply_speed()

func _fixed_process(delta):
	var entity = entities.get_node(entity_selected)
	entity.set_rot(entity.get_rot() + rotation_speed * delta)

func entity_select(name):
	if entity_selected:
		entity_hide(entity_selected)
	entity_show(entity_selected)

func entity_hide(name):
	var e = entities.get_node(name)
	if e.is_connected('body_enter_shape', self, '_on_body_enter_shape'):
		e.disconnect('body_enter_shape', self, '_on_body_enter_shape')
	e.hide()
	e.team = team
	e.kind = kind

func entity_show(name):
	var e = entities.get_node(name)
	if not e.is_connected('body_enter_shape', self, '_on_body_enter_shape'):
		e.connect('body_enter_shape', self, '_on_body_enter_shape')
	entities.get_node(name).show()

func entities_hide_all():
	for entity in entities.get_children():
		entity.hide()
		entity.team = team
		entity.kind = kind

func entity_random():
	return entities.get_child(rand_range(0, entities.get_child_count())).get_name()

func respawn():
	entity_select(entity_random())
	.respawn()