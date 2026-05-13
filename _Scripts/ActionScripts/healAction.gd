extends ActionResource
class_name HealAction

@export var amount: int = 5
func execute(actor: Actor) -> void: 
	actor.addHealth(amount)