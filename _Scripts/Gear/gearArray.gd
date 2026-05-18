extends Control
class_name GearArray

var assignedGears : Array[GearResource] = [] 
@export var gear_slots: Array[GearArraySlot] = []

func _enter_tree() -> void:
	Constant.GEAR_ARRAY = self

func _ready() -> void:
	for gearSlot: GearArraySlot in gear_slots:
		gearSlot.spinContent = true
		gearSlot.onGearSet.connect(onGearArrayChange)
		gearSlot.onGearRemoved.connect(onGearArrayChange)

func _exit_tree() -> void:
	for gearSlot: GearArraySlot in gear_slots:
		gearSlot.onGearSet.disconnect(onGearArrayChange)
		gearSlot.onGearRemoved.disconnect(onGearArrayChange)
	
func disableArraySlots() -> void:
	for gearArraySlot: GearArraySlot in gear_slots:
		gearArraySlot.disableSlot()

func enableArraySlots() -> void:
	for gearArraySlot: GearArraySlot in gear_slots:
		gearArraySlot.enableSlot()

func resolveGears() -> void:
	for gearArrSlot: GearArraySlot in gear_slots:
		if gearArrSlot.gear != null and Constant.PLAYER.target:
			gearArrSlot.screenShake()
			gearArrSlot.explode()
			await Constant.PLAYER.perform_gear(gearArrSlot.gear)
#			await gearArrSlot.gear.evaluate(player)
			if gearArrSlot.gear.isConsumable:
				Constant.PLAYER.gear_pouch.discard(gearArrSlot.gear)
				gearArrSlot.removeGear()
				# Put in gear_pouch
		if Constant.PLAYER.target == null:
			return

func onGearArrayChange(gear: GearArraySlot) -> void:
	pass
#	print(gear.name)
