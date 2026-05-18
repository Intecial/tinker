extends ActionResource
class_name StatusEffectAplicator

@export var status_effects: Array[StatusEffectResource]
@export var is_instant: bool = false

func execute(actor: Actor) -> void:
	if is_instant:
		for stat: StatusEffectResource in status_effects:
			actor.add_status_effect(stat)
	else:
		for stat: StatusEffectResource in status_effects:
			actor.add_next_round_sfx(stat)
	actor.triggerStatusEffects()