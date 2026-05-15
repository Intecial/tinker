extends StatusEffectResource
class_name Strength

@export var damage_mult: float

func evaluate(actor_context: ActorContext) -> void:
	actor_context.set_data("damage_multiplier", damage_mult)