extends 'res://class/np_object.gd'

func _on_enemy_body_enter(body):
	if body == null:
		return
	#print("body kind: %s" % body.kind)
	if body.kind == 2:# and body.team == 2: # enter void
		return kill()
	elif body.kind == kind == 0:
		return
	elif body.team != team:
		if body.get_owner():
			body.get_owner().hit_with(self, body)
		hit_by(body)
	elif body.kind == 0:
		body.kill()

func hit_with(target, ammo):
	# money += target.money
	pass

func hit_by(body):
	if body.damage > 0:
		self.life -= body.damage
		if self.life <= 0:
			self.life = 0
			kill()
			explode()
