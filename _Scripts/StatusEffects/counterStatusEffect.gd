extends StatusEffectResource
class_name CounterStatusEffect

#@export var counter_tag: String
func evaluate(actor_context: ActorContext) -> void:
	pass
#	if actor_context.try_get_data(counter_tag):
#		var count: int = actor_context.try_get_data(counter_tag)
#		actor_context.set_data(counter_tag, count + 1)
#	else:
#		actor_context.set_data(counter_tag, 1)