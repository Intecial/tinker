extends GridContainer
class_name GearInventory

@export var income: int = 3
var inventory : Array[GearArraySlot]

func _ready() -> void:
	Constant.GEAR_INVENTORY = self
	for gearArraySlot: GearArraySlot in get_children():
		inventory.append(gearArraySlot)
	
	await get_tree().process_frame
	var piggyBank: GearResource = Constant.GEAR_DICT["PiggyBank"].duplicate(true)
	inventory[0].setGear(Constant.GEAR_DICT["Income"])
	inventory[1].setGear(Constant.GEAR_DICT["Berserk"])
	inventory[2].setGear(piggyBank)
	
#	inventory[0].setGear(Constant.GEAR_DICT["Strike"])
#	inventory[1].setGear(Constant.GEAR_DICT["Defend"])
#	inventory[2].setGear(Constant.GEAR_DICT["Sentry"])

func incomeGears() -> void:
	pass
#	var i : int = income
#	for gearArraySlot: GearArraySlot in get_children():
#		if gearArraySlot.gear == null && i > 0:
#			var randomKey : String = Constant.BASIC_GEAR_DICT.keys().pick_random()
#			var randomGear : GearResource = Constant.BASIC_GEAR_DICT.get(randomKey)
#			gearArraySlot.setGear(randomGear)
#			i -= 1
