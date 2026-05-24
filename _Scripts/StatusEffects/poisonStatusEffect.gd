extends StatusEffectResource
class_name PoisonStatusEffect

enum EffectOn { SELF, TARGET, BOTH }
@export var poison_damage: int = 1
@export var effect_on: EffectOn
@export var is_blockable: bool = false
func evaluate(actor_context: ActorContext) -> void:
	var actor: Actor = actor_context.actor
	if effect_on == EffectOn.SELF || effect_on == EffectOn.BOTH:
		resolve_damage(actor)
	if effect_on == EffectOn.TARGET || effect_on == EffectOn.BOTH:
		resolve_damage(actor.target)

func resolve_damage(actor: Actor) -> void:
	if is_blockable:
		actor.dealDamage(poison_damage)
	else:
		actor.hurtHealth(poison_damage)