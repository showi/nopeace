extends Node

export(int, "player", "enemy", "n/a") var team
export(int, "ammo", "ship", "world", "powerup", "shield", "weapon", "weaponSystem") var kind

var owner = null
var freed = false

func _init(team=team, kind=kind):
	self.team = team
	self.kind = kind
