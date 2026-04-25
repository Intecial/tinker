extends GridContainer
class_name ShopArray


func _enter_tree() -> void:
	Constant.SHOP_ARRAY = self
	
func populateShop() -> void:
	for gearArrSlot: GearArraySlot in get_children():
		var randomKey : String = Constant.GEAR_DICT.keys().pick_random()
		var randomValue : GearResource = Constant.GEAR_DICT.get(randomKey)
		await gearArrSlot.setGear(randomValue)

func clearShop() -> void:
	Constant.SHOP_PANEL.initSellSlot()
	for gearArrSlot: GearArraySlot in get_children():
		await gearArrSlot.initLoc()
		gearArrSlot.setGear(null)
