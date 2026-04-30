extends GamePanel
class_name ShopPanel

@export var shopArray: GridContainer

@onready var sellSlot : GearSellSlot = $VBoxContainer/Panel/SellSlot
	
func initSellSlot()->void:
	sellSlot.initLocal()
