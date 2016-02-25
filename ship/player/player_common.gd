extends "/ship/ship.gd"

onready var s_money = get_node("/root/game/viewport/level/status/panel/hbox/money")
onready var s_life = get_node("/root/game/viewport/level/status/panel/hbox/life")
onready var s_shield = get_node("/root/game/viewport/level/status/panel/hbox/shield")

func _init():
	cstat = cstat_scn.instance()

func _ready():
	owner = get_parent()
	set_fixed_process(true)

func _fixed_process(delta):
	if s_life:
		s_money.set_text("%05s$" % money)
		s_life.set_percent_visible(life)
	if backup._restore:
		restore_rigid()
		backup._restore = false
		show()
