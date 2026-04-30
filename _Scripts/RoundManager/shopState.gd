extends RoundState
class_name ShopState


@export var endRoundButton: Button
var stateRoundManager: RoundManager
func onEnter(roundManager: RoundManager) -> void:
	Constant.PANEL_MANAGER.switchPanel("Shop")
	
	endRoundButton.button_down.connect(endRound)
	endRoundButton.disabled = false
	stateRoundManager = roundManager
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

func endRound() -> void:
	stateRoundManager.transitionState("PREPARATIONSTATE")

func onExit(roundManager: RoundManager) -> void:
	roundManager.gearArray.enableArraySlots()
	endRoundButton.button_down.disconnect(endRound)
	endRoundButton.disabled = true