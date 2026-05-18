extends ActionResource
class_name ApplyDebuffAction

@export var status_effects: Array[StatusEffectResource]
@export var is_instant: bool = false

func execute(actor: Actor) -> void:
	if is_instant:
		for stat: StatusEffectResource in status_effects:
			actor.target.add_status_effect(stat)
	else:
		for stat: StatusEffectResource in status_effects:
			actor.target.add_next_round_sfx(stat)
	actor.target.triggerStatusEffects()