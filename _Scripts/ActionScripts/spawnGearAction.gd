extends ActionResource
class_name SpawnGearAction

@export var gearToSpawn: GearResource
func execute(_actor: Actor) -> void:
	for gearArrSlot: GearArraySlot in Constant.GEAR_INVENTORY.inventory:
		if gearArrSlot.gear == null:
			gearArrSlot.setGear(gearToSpawn)
			return
