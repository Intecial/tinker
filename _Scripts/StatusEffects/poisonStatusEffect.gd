extends StatusEffectResource
class_name PoisonStatusEffect

@export var poison_damage: int = 1
func evaluate(actor_context: ActorContext) -> void:
	var actor: Actor = actor_context.actor
	actor.hurtHealth(poison_damage)