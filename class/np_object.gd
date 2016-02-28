extends Node2D

export(int, "player", "enemy", "n/a") var team
export(int, "ammo", "ship", "world", "powerup", "shield", "weapon", "weaponSystem") var kind

var owner = null
var freed = false
var dynamic = null

func _init(team=team, kind=kind):
	self.team = team
	self.kind = kind

func get_dynamic():
	if has_node('/root/game/dynamic'):
		return get_node('/root/node/dynamic')
	return get_node('mock_dynamic')