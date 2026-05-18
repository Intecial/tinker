extends GridContainer
class_name ShopArray

@export var shopPanel: ShopPanel
func _enter_tree() -> void:
	Constant.SHOP_ARRAY = self
	
func populateShop() -> void:
	for gearArrSlot: GearArraySlot in get_children():
		var randomKey : String = Constant.GEAR_DICT.keys().pick_random()
		var randomValue : GearResource = Constant.GEAR_DICT.get(randomKey)
		var duplicatedResource : GearResource = randomValue.duplicate(true)
		await gearArrSlot.setGear(duplicatedResource)

func clearShop() -> void:
	shopPanel.initSellSlot()
	for gearArrSlot: GearArraySlot in get_children():
		await gearArrSlot.initLoc()
		gearArrSlot.setGear(null)
