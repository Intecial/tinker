extends ActionResource
class_name ShieldAction

@export var shieldAmount: int = 5
func execute(actor: Actor) -> void:
	actor.addShield(shieldAmount)