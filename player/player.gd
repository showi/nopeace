extends RigidBody2D

export var team = 0
export var kind = 0

var LAYER_PARTICLE = 0

var cstat_scn = preload("res://cstat/cstat.scn")
var bullet_scn = preload("res://fire/bullet.scn")

onready var al = get_node("arm/left")
onready var ar = get_node("arm/right")
onready var level = get_node("/root/game/viewport/level")


var last_arm = 0
var stat = null

func fire(target, ev):
	var bullet = bullet_scn.instance();
	bullet.hide()
	level.add_child(bullet)
	if last_arm:
		bullet.set_pos(al.get_pos())
		last_arm = 0
	else:
		bullet.set_pos(ar.get_pos())
		last_arm = 1
	bullet.show()
	bullet._fire(level, ev)

func engine(target, ev):
	pass #engine._show()	

func _input(ev):
	self.set_pos(ev.pos)
	if (ev.type==InputEvent.MOUSE_BUTTON):
		fire(self, ev)
	elif (ev.type==InputEvent.MOUSE_MOTION):
		engine(self, ev)


const GRAVITY = 200.0
const WALK_SPEED = 200

var velocity = Vector2()

func _fixed_process(delta):

    velocity.y += delta * GRAVITY

    if (Input.is_action_pressed("ui_left")):
        velocity.x = -WALK_SPEED
    elif (Input.is_action_pressed("ui_right")):
        velocity.x =  WALK_SPEED
    else:
        velocity.x = 0

    var motion = velocity * delta
    #move(motion)

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	stat = cstat_scn.instance()
	print("Player ready: %s" % stat)