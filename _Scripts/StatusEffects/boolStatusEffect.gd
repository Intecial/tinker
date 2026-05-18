extends StatusEffectResource
class_name BoolStatusEffect

@export var context_tag: String 

func evaluate(actor_context: ActorContext) -> void:
	actor_context.set_data(context_tag, true)
