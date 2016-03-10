extends Node

var _dynamic_body = null
var is_level = false

func _ready():
	pass #print('create dynamic')
	#create_dynamic()

func set_dynamic(p_dynamic):
	_dynamic_body = p_dynamic

func get_dynamic():
	return get_viewport()
	if not _dynamic_body:
		_dynamic_body = get_node('/root/dynamicBodies')
	return _dynamic_body

func create_dynamic():
	if _dynamic_body != null:
		return
	#if has_node('/root/dynamicBodies'):
	#	return
	#print('adding node dynamic')
	var root = get_node('/root')
	var node = Node2D.new()
	node.set_name('dynamicBodies')
	root.add_child(node)
	_dynamic_body = node
	if not is_level:
		call_deferred('attach_root')

func attach_root():
	print('adding dynamic to /root')
	if not _dynamic_body.get_parent():
		get_node('/root').add_child(_dynamic_body)

