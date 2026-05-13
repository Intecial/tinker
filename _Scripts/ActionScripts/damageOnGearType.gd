extends ActionResource
class_name DamageOnGearType

@export var gearType: GearResource.GearType
@export var action: DamageAction
@export var multiplier: int = 1

func execute(actor: Actor) -> void:
	var totalDamage: int = 0
	for i: GearArraySlot in Constant.GEAR_ARRAY.get_children():
		if i.gear != null && i.gear.gearType == self.gearType:
			totalDamage += multiplier
	action.damage += totalDamage
	action.execute(actor)
