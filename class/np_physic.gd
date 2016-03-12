extends 'res://class/np_object.gd'

var nstat = preload('res://cstat/nstat.scn')

const up_vec = Vector2(0, -1)
const down_vec = Vector2(0, 1)

export var is_respawning = true
export var speed = 200
export var acceleration = 600
export var rotation_speed = 30

var stat = null
var root = null
var energy = 0
var _backup = null
var _respawn = false
var _freed = false

func _ready():
	stat = stat_init()
	root = get_viewport()
	set_process(true)

func set_respawn(value):
	_respawn = bool(value)

func get_respawn():
	return _respawn

func set_freed(value):
	_freed = bool(value)

func get_freed():
	return _freed

func stat_init():
	if not has_node('stat'):
		var node = nstat.instance()
		node.set_name('stat')
		add_child(node)
	var node = get_node('stat')
	return node

func kill():
	_freed = true

func _fixed_process(delta):
	if _freed:
		return
	return hook_fixed_process(delta)

func _process(delta):
	if _freed:
		free()
		return false
	elif _respawn:
		restore_rigid()
		set_respawn(false)
		show()
		return true

func hook_fixed_process(delta):
	pass

func apply_speed():
	if speed != 0:
		set_applied_force(up_vec.rotated(get_rot()) * speed)

func reconnect():
	connect('body_enter_shape', self, '_on_body_enter_shape')
	
func _on_body_enter_shape( body_id, body, body_shape, local_shape ):
	return _on_body_enter(body)

func _on_body_enter(body):
	var freed = false
	if body.kind == 3 and team != null:
		return kill()
	elif not body.team  or not body.kind: # null and 'n/a'
		print('Error: No team or kind %s %s' % [body, body.get_name()])
		return false
	elif team == null or kind == null:
		print('Error: No team or kind (src) %s %s'  % [body, body.get_name()])
		return false
	elif body.team == team:
		return false	
	elif body.kind == kind == 1:
		return false
	#print('%s/%s -> %s/%s' % [kindH(kind), teamH(team), kindH(body.kind), teamH(body.team)])
	if body.kind == 1:
		hit_by_ammo(body)
		freed = true
	elif body.kind == 4:
		hit_by_powerup(body)
		freed = true
	if stat.hit(body) <= 0:
		kill()
	if freed:
		body.kill()

func drop():
	print('drop base')

func explode():
	print('explode base')

func hit_by_powerup(powerup):
	print('getting powerup')

func hit_by_ammo(ammo):
	var muzzle = preload('res://muzzle/muzzle.scn').instance()
	get_dynamic().add_child(muzzle)
	muzzle.set_global_pos(ammo.get_global_pos())

func save_rigid():
	_backup = {
		'pos': get_pos(),
		'linear_velocity': null,
		'rot':  get_rot(),
		'_restore': false
	}
	if has_method('get_linear_velocity'):
		_backup['linear_velocity'] = get_linear_velocity()

func restore_rigid():
	set_pos(_backup['pos'])
	set_rot(_backup['rot'])
	if _backup['linear_velocity'] != null:
		set_linear_velocity(_backup['linear_velocity'])
