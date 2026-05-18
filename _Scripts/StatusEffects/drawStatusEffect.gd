extends StatusEffectResource
class_name DrawStatusEffect

func evaluate(actor_context: ActorContext) -> void:
	var actor: Actor = actor_context.actor
	var drawn_gear : GearResource = actor.gear_pouch.draw()
	Constant.GEAR_INVENTORY.add_gear(drawn_gear)