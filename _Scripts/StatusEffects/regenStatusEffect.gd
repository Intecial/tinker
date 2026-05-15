extends StatusEffectResource
class_name RegenStatusEffect


@export var heal_amount: int = 1
func evaluate(actor_context: ActorContext) -> void:
	var actor: Actor = actor_context.actor
	actor.addHealth(heal_amount)