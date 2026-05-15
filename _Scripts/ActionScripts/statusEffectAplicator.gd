extends ActionResource
class_name StatusEffectAplicator

@export var status_effects: Array[StatusEffectResource]
@export var num_of_effects: int = 1

func execute(actor: Actor) -> void:
	for num: int in num_of_effects:
		for stat: StatusEffectResource in status_effects:
			actor.add_status_effect(stat)
	actor.triggerStatusEffects()