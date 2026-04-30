extends Resource
class_name StatusEffectResource

@export var actions: Array[ActionResource] = []

func evaluate(actor: Actor) -> void:
	for action: ActionResource in actions:
		action.execute(actor)