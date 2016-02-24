extends "/ship/ship.gd"

onready var s_money = get_node("/root/game/viewport/level/status/panel/hbox/money")
onready var s_life = get_node("/root/game/viewport/level/status/panel/hbox/life")
onready var s_shield = get_node("/root/game/viewport/level/status/panel/hbox/shield")

func _init():
	cstat = cstat_scn.instance()

func _ready():
	owner = self
	set_fixed_process(true)
	set_process_input(true)

func _input(ev):
	if ev.type==InputEvent.KEY:
		print("key: %s" % ev)
	elif (ev.type==InputEvent.MOUSE_BUTTON):
		#print("Mouse: %s" % ev)
		if ev.pressed == 1:
			fire(self, ev)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		self.set_pos(ev.pos)

func _fixed_process(delta):
	if s_life:
		s_money.set_text("%05s$" % money)
		s_life.set_percent_visible(life)
	if backup._restore:
		restore_rigid()
		backup._restore = false
		show()
