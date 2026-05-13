extends ActionResource
class_name DamageAction

@export var damage: int = 5

func execute(actor: Actor) -> void:
	if actor.target:
		actor.target.resolveDamage(damage)
#		await flash(Constant.FX_LAYER)
