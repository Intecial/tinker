extends GridContainer
class_name GearArray

@export var player: Actor
var assignedGears : Array[GearResource] = [] 

func _ready() -> void:
	Constant.GEAR_ARRAY = self
	for gearSlot: GearArraySlot in get_children():
		gearSlot.spinContent = true
		gearSlot.onGearSet.connect(onGearArrayChange)
		gearSlot.onGearRemoved.connect(onGearArrayChange)

func _exit_tree() -> void:
	for gearSlot: GearArraySlot in get_children():
		gearSlot.onGearSet.disconnect(onGearArrayChange)
		gearSlot.onGearRemoved.disconnect(onGearArrayChange)
	
func disableArraySlots() -> void:
	for gearArraySlot: GearArraySlot in get_children():
		gearArraySlot.disableSlot()

func enableArraySlots() -> void:
	for gearArraySlot: GearArraySlot in get_children():
		gearArraySlot.enableSlot()

func resolveGears() -> void:
	for gearArrSlot: GearArraySlot in get_children():
		if gearArrSlot.gear != null and Constant.PLAYER.target:
			gearArrSlot.screenShake()
			gearArrSlot.explode()
			await player.perform_gear(gearArrSlot.gear)
#			await gearArrSlot.gear.evaluate(player)
			if gearArrSlot.gear.isConsumable:
				gearArrSlot.removeGear()
		if Constant.PLAYER.target == null:
			return

func onGearArrayChange(gear: GearArraySlot) -> void:
	print(gear.name)