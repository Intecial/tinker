extends ActionResource
class_name SelfDamageAction

@export var damage: int = 5
func execute(actor: Actor) -> void:
	actor.resolveDamage(damage)