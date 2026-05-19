extends ActionResource
class_name ShieldByCounterAction

enum ConsumeMode { NONE, ONE, HALF, ALL }
enum StatOn { TARGET, SELF }

@export var counter_tag: String
@export var sfx_on: StatOn
@export var consume_mode: ConsumeMode = ConsumeMode.NONE

func execute(actor: Actor) -> void:
	var sfx: Array[StatusEffectResource] = []
	var chosen_actor: Actor
	if sfx_on == StatOn.TARGET:
		chosen_actor = actor.target
	if sfx_on == StatOn.SELF:
		chosen_actor = actor
		
	sfx = chosen_actor.statusEffects.filter(
		func(x: StatusEffectResource) -> bool: return x.name == counter_tag
	)
	var amount: int = sfx.size()
	actor.addShield(amount)
	_consume(chosen_actor, sfx)

func _consume(actor: Actor, sfx: Array[StatusEffectResource]) -> void:
	var to_remove: Array[StatusEffectResource] = []

	match consume_mode:
		ConsumeMode.ONE:
			if sfx.size() > 0:
				to_remove = [sfx[0]]
		ConsumeMode.HALF:
			to_remove = sfx.slice(0, sfx.size() / 2)
		ConsumeMode.ALL:
			to_remove = sfx
		ConsumeMode.NONE:
			pass
	if to_remove.is_empty():
		return

	for fx: StatusEffectResource in to_remove:
		actor.target.statusEffects.erase(fx)
	actor.target.triggerStatusEffects()
	