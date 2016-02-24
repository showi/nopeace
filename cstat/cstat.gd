extends Node2D

var stats = {
	'lvl': 1,
	'life': 100,
	'life_retry': 3,
	'shield': {
		'mag': 100,
		'phy': 100,
	},
	'atk': {
		'phy': 10,
		'mag': 100,
	},
	'def': {
		'phy': 100,
		'mag': 100,
	},
	'stats': {
		'count': {
			'hit': 0,
			'powerup': 0,
		}
	}
}

var lvl_factor = 0.001

func _ready():
	print("mag atk: %s" % calc_mag_atk())
	print("phy atk: %s" % calc_phy_atk())

func calc_level_factor(lvl):
	return lvl_factor * lvl

func calc_mag_def():
	return calc_level_factor(stats.lvl) * (stats.shield.mag + stats.def.mag)

func calc_phy_def():
	return calc_level_factor(stats.lvl) * (stats.shield.phy + stats.def.phy)
	
func calc_mag_atk():
	return calc_level_factor(stats.lvl) * (stats.atk.mag)

func calc_phy_atk():
	return calc_level_factor(stats.lvl) * (stats.atk.phy)
