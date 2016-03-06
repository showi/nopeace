extends 'res://class/np_object.gd'

var nstat = preload('res://cstat/nstat.scn')

const up_vec = Vector2(0, -1)
const down_vec = Vector2(0, 1)

export var is_respawning = true
export var speed = 200
export var speed_max = 300

var stat = null

var initiator = null
var _backup = null
var root = null

class Initiator:
	var src = null
	var pos = null
	var rot = null
	var initial_force = null
	func _init(p_src, p_pos, p_rot):
		self.src = weakref(p_src)
		self.pos = p_pos
		self.rot = p_rot

func stat_init():
	if not has_node('stat'):
		var node = nstat.instance()
		node.set_name('stat')
		add_child(node)
	return get_node('stat')

func _ready():
	stat = stat_init()
	root = get_viewport()

func set_initiator(p_initiator, pos, rot):
	initiator = Initiator.new(p_initiator, pos, rot)
	
func get_initiator():
	return initiator

func _on_body_enter(body):
	# print('%s(%s)/%s(%s) -> %s/%s' % [kind2human(kind), kind, team2human(team), team, kind2human(body.kind), team2human(body.team)])
	if body.kind == 3 and team != null:
		return kill()
	elif not body.team  or not body.kind: # null and 'n/a'
		#print('Error: No team or kind')
		return false
	elif team == null or kind == null:
		#print('Error: No team or kind (src)')
		return false
	elif body.team == team:
		return false	
	elif body.kind == kind == 1:
		return false
	elif body.kind == 1:
		hit_by_ammo(body)
	return hit_by(body)

func hit_by_ammo(ammo):
	var muzzle = preload('res://muzzle/muzzle.scn').instance()
	muzzle.set_global_pos(ammo.get_global_pos())
	root.add_child(muzzle)

func hit_by(body):
	if stat.get_value('damage') != 0:
		stat.set_value('life', stat.get_value('life') - stat.get_value('damage'))
		if stat.get_value('life') == 0:
			kill()

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
