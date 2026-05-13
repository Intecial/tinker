extends ActionResource
class_name StackSellValueAction

@export var increment_value : int = 1
var current_value : int = 0

func execute(_actor: Actor) -> void:
	self.gear.sellValue += increment_value
