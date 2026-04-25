extends Panel
class_name ShopPanel

@export var shopArray: GridContainer

@onready var sellSlot : GearSellSlot = $VBoxContainer/Panel/SellSlot
func _enter_tree() -> void:
	Constant.SHOP_PANEL = self
	
func initSellSlot()->void:
	sellSlot.initLocal()