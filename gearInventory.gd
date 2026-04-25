extends GridContainer
class_name GearInventory

@export var income: int = 3
var inventory : Array[GearArraySlot]

func _ready() -> void:
	Constant.GEAR_INVENTORY = self
	for gearArraySlot: GearArraySlot in get_children():
		inventory.append(gearArraySlot)

func incomeGears() -> void:
	var i : int = income
	for gearArraySlot: GearArraySlot in get_children():
		if gearArraySlot.gear == null && i > 0:
			var randomKey : String = Constant.BASIC_GEAR_DICT.keys().pick_random()
			var randomGear : GearResource = Constant.BASIC_GEAR_DICT.get(randomKey)
			gearArraySlot.setGear(randomGear)
			i -= 1
