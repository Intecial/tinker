extends RoundState
class_name ShopState

@export var shop_panel: ShopPanel

var round_manager: RoundManager
func _ready() -> void:
	shop_panel.skip_button.button_down.connect(skip_pressed)

func onEnter(roundManager: RoundManager) -> void:
#	Constant.PANEL_MANAGER.switchPanel("Shop")
	self.round_manager = roundManager
	shop_panel.visible = true
	Constant.SHOP_ARRAY.clearShop()
	await Constant.TEXT_CONTAINER.showText("[center] [b]Shop [center] [b]Phase")
	roundManager.gearArray.enableArraySlots()
	await Constant.SHOP_ARRAY.populateShop()
#	await roundManager.gearArray.resolveGears()
#	if Constant.PLAYER.target != null:
#		await Constant.ENEMY_MANAGER.performAction()
#	else:
#		roundManager.transitionState("SHOPSTATE")
#	roundManager.transitionState("PREPARATIONSTATE")

func skip_pressed() -> void:
	self.round_manager.next_button_click()

func onNextRound(_roundManager: RoundManager) -> void:
	_roundManager.transitionState("ROUTESTATE")

func onExit(roundManager: RoundManager) -> void:
	shop_panel.visible = false
	roundManager.gearArray.enableArraySlots()
