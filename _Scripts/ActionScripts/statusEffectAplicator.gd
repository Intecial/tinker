extends ActionResource
class_name StatusEffectAplicator

@export var status_effects: Array[StatusEffectResource]
@export var num_of_effects: int = 1

func execute(actor: Actor) -> void:
	for num: int in num_of_effects:
		actor.statusEffects += status_effects
	actor.triggerStatusEffects()