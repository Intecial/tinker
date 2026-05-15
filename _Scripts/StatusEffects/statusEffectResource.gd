@abstract
extends Resource
class_name StatusEffectResource

#@export var actions: Array[ActionResource] = []
@abstract
func evaluate(actor_context: ActorContext) -> void