extends 'res://class/np_physic.gd'

export var powerup_list = ['life', 'shield']
export var powerup_selected = 'life'
export var powerup_duration = 3

onready var kill_timer = get_node('kill_timer')
onready var sprite = get_node('sprite')

func _ready():
	reconnect()
	get_node('stat/damage').value = -25
	if not powerup_selected:
		powerup_select(powerup_random())
	if powerup_duration > 0:
		kill_timer_start()
	set_fixed_process(true)

func reconnect():
	.reconnect()
	kill_timer.connect('timeout', self, '_on_kill_timer_timeout')

func powerup_random():
	return powerup_list[rand_range(0, powerup_list.size())]

func powerup_select(name):
	if powerup_selected:
		powerup_hide(powerup_selected)
	powerup_show(name)

func powerup_hide(name):
	sprite.get_node(name).hide()

func powerup_show(name):
	print('show %s' % name)
	sprite.get_node(name).show()

func _fixed_process(delta):
	if _freed:
		kill_timer.stop()
	._fixed_process(delta)

func kill_timer_start():
	kill_timer.set_wait_time(powerup_duration)
	kill_timer.start()

func _on_kill_timer_timeout():
	kill()
