extends Node2D

var prunes = []

func _ready():
	pass #set_fixed_process(true)

func remove(node):
	#dynamic.remove_child(node)
	print('pool %s' % self)
	prunes.append(node)


func prune(node):
	prunes.append(node)

func pruneit():
	print("Pruning %s nodes" % prunes.size())
	for node in prunes:
		if node == null:
			continue
		#dynamic.remove_child(node)
		node.free()
	prunes = []

func _fixed_process(delta):
	pass

func _on_Timer_timeout():
	pruneit()

