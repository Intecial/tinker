extends Button
class_name NextRound

@export var player: Actor
@export var gearArray: GearArray

func _enter_tree() -> void:
#	self.button_down.connect(gearArray.invoke(actor))
	pass

func _exit_tree() -> void:
#	self.button_down.disconnect(gearArray.invoke(actor))
	pass