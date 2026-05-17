extends RoundState
class_name ShopState

func onEnter(roundManager: RoundManager) -> void:
	Constant.PANEL_MANAGER.switchPanel("Shop")
	
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

func onNextRound(_roundManager: RoundManager) -> void:
	_roundManager.transitionState("ROUTESTATE")

func onExit(roundManager: RoundManager) -> void:
	roundManager.gearArray.enableArraySlots()