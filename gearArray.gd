extends GridContainer
class_name GearArray

@export var player: Actor
var assignedGears : Array[GearResource] = [] 

func _ready() -> void:
	Constant.GEAR_ARRAY = self
	for gearSlot: GearArraySlot in get_children():
		gearSlot.spinContent = true

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
			await gearArrSlot.gear.evaluate(player)
			if gearArrSlot.gear.isConsumable:
				gearArrSlot.removeGear()
		if Constant.PLAYER.target == null:
			return
