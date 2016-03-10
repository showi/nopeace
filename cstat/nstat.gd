extends Control

func _ready():
	pass

func to_s():
	var out = '[stat]\n'
	for child in get_children():
		out += '%s\n' % child.to_s()
	return out

func set_value(who, value):
	get_node(who).value = value
	
func get_value(who):
	return get_node(who).value

func hit(src):
	var sstat = src.stat
	#print('hit src: %s, damage: %s' % [sstat, sstat.get_value('damage')])
	var damage = sstat.get_value('damage')
	var shield = get_value('shield')
	var life = get_value('life')
	#print('damage: %s, shield: %s, life: %s' % [damage, shield, life])
	if shield > 0:
		set_value('shield', get_value('shield') - damage)
		damage -= shield
	if damage > 0:
		set_value('life', get_value('life') - damage)
	#print('life: %s' % get_value('life'))
	return get_value('life')