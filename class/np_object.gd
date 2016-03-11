extends Node

export(int, 'n/a', 'player', 'enemy') var team = 0
export(int, 'n/a', 'ammo', 'ship', 'world', 'powerup', "shield", "weapon", "weaponSystem") var kind = 0

var _team = ['n/a', 'player', 'enemy']
var _kind = ['n/a', 'ammo', 'ship', 'world', 'powerup', 'shield', 'weapon', 'weaponSystem']

onready var global = get_node('/root/global')

var _pivot

func get_dynamic():
	return global.get_dynamic()

func kindH(p_kind):
	if p_kind == null or p_kind > _kind.size():
		p_kind = 0
	return _kind[p_kind]

func teamH(p_team):
	if p_team == null or p_team > _team.size():
		p_team = 0
	return _team[p_team]

func get_pivot():
	if not _pivot:
		return self
	return _pivot.get_ref()

func set_pivot(pivot):
	_pivot = weakref(pivot)