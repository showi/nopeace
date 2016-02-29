extends Node2D

export(int, "player", "enemy", "n/a") var team
export(int, "ammo", "ship", "world", "powerup", "shield", "weapon", "weaponSystem") var kind


var freed = false

func get_dynamic():
	if has_node('/root/game/level/dynamic'):
		return get_node('/root/game/level/dynamic')
	if has_node('/root/game/mock_dynamic'):
		return get_node('/root/game/mock_dynamic')
	return get_node('mock_dynamic')