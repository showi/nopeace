extends 'res://class/np_object.gd'

const up_vec = Vector2(0, -1)
const down_vec = Vector2(0, 1)

var initiator = null

export var damage = 10
export var money = 100
export var life = 100
export var drop_rate = 0.2
export var is_respawning = true
export var speed = 200
export var speed_max = 300

func set_initiator(p_initiator):
	team = p_initiator.team
	set_rot(get_rot() + p_initiator.get_rot())
	initiator = weakref(p_initiator)

func get_initiator():
	if not initiator:
		return self
	return initiator.get_ref()

func _on_enemy_body_enter(body):
	if body == null:
		return
	if body.kind == 2:
		return kill()
	elif body.kind == kind == 1:
		return
	elif body.team != team:
		if body.kind == 0:
			if body.has_method('get_initiator'):
				var initiator = body.get_initiator()
				if initiator.has_method('hit_by_ammo'):
					initiator.hit_by_ammo(body)
				if initiator.has_method('hit_by'):
					hit_by(body)
			body.kill()

func hit_by_ammo(ammo):
	# money += target.money
	pass

func hit_by(body):
	if body.damage > 0:
		self.life -= body.damage
		if self.life <= 0:
			self.life = 0
			kill()
			explode()
