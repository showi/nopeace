extends "res://class/np_object.gd"

var _cache = {}
var ammos = []
var duration = 0

func _ready():
	preload_ammo()

func preload_ammo():
	var cls
	for child in get_children():	
		cls = weakref(load_model(child.get_name().split(' ')[0]))
		duration += cls.get_ref().instance().duration
		ammos.append([weakref(child), cls])
	
func load_model(name):
	var nid
	if not (name in _cache):
		_cache[name] = load('res://weapon/ammo/model/%s.scn' % name)
	return _cache[name]
 
func fire(initiator, pos, lookat):
	var fired = []
	var ammo = null
	var child = null
	for tuple in ammos:
		var ws = tuple[0].get_ref()
		if not ws:
			continue
		ammo = tuple[1].get_ref().instance()
		ammo.hide()
		ammo.team = initiator.team
		ammo.kind = initiator.kind
		ammo.owner = initiator
		ammo.set_pos((tuple[0].get_ref().get_transform() * pos))
		#nammo.look_at(lookat)
		ammo.set_linear_velocity(lookat * ammo.speed)
		fired.append(ammo)
	return fired
