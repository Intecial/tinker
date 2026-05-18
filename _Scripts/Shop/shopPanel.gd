extends GamePanel
class_name ShopPanel

@export var shopArray: GridContainer

@export var sellSlot : GearSellSlot 

@export var skip_button: Button
	
func initSellSlot()->void:
	sellSlot.initLocal()
