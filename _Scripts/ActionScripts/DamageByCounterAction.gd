extends ActionResource
class_name DamageByCounterAction

@export var counter_tag: String
@export var consume_all: bool

func execute(actor: Actor) -> void:
	var sfx: Array[StatusEffectResource] = actor.target.statusEffects.filter(func(x: StatusEffectResource) -> bool: return x.name == counter_tag)
	var amount: int = len(sfx)
	actor.dealDamage(amount)
	if consume_all:
		for i: StatusEffectResource in sfx:
			actor.target.statusEffects.erase(i)
			actor.target.triggerStatusEffects()
	
func flash(layer: FXLayer) -> void:
	pass