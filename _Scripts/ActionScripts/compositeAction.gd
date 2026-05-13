extends ActionResource
class_name CompositeAction

@export var actions: Array[ActionResource]

func execute(actor: Actor) -> void:
	for action: ActionResource in actions:
		action.execute(actor)
