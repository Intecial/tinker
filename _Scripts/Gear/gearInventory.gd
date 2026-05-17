extends GridContainer
class_name GearInventory

@export var income: int = 3
var inventory : Array[GearArraySlot]

func _ready() -> void:
	Constant.GEAR_INVENTORY = self
	for gearArraySlot: GearArraySlot in get_children():
		inventory.append(gearArraySlot)
	
	await get_tree().process_frame
#	var piggyBank: GearResource = Constant.GEAR_DICT["Investment"].duplicate(true)
#	inventory[0].setGear(Constant.GEAR_DICT["Income"])
	self.add_gear(Constant.GEAR_DICT["ApplyLubricant"])
	self.add_gear(Constant.GEAR_DICT["ApplyLubricant"])
#	inventory[2].setGear(piggyBank)
#	inventory[3].setGear(Constant.GEAR_DICT["GainStrength"])
	self.add_gear(Constant.GEAR_DICT["Spark"])

func add_gear(gear: GearResource) -> void:
	for i: GearArraySlot in inventory:
		if i.gear == null:
			i.setGear(gear)
			return
func incomeGears() -> void:
	pass
#	var i : int = income
#	for gearArraySlot: GearArraySlot in get_children():
#		if gearArraySlot.gear == null && i > 0:
#			var randomKey : String = Constant.BASIC_GEAR_DICT.keys().pick_random()
#			var randomGear : GearResource = Constant.BASIC_GEAR_DICT.get(randomKey)
#			gearArraySlot.setGear(randomGear)
#			i -= 1
