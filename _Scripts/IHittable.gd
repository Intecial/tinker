
class_name IHittable extends Node


func _ready() -> void:
	owner = get_parent()
	
	assert(owner.has_method("Hit"))
	assert(owner.has_method("HandleInput"))
	assert(owner.has_method("OnRayExit"))
	
func Hit():
	return owner.Hit()
	
func HandleInput():
	return owner.HandleInput()
	
func OnRayExit():
	return owner.OnRayExit