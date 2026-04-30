extends RoundState
class_name ForgeState

@export var endRoundButton: Button
var stateRoundManager: RoundManager
func onEnter(roundManager: RoundManager) -> void:
	self.stateRoundManager = roundManager
	Constant.PANEL_MANAGER.switchPanel("Forge")
	await Constant.TEXT_CONTAINER.showText("[center] [b]Forge [center] [b]Phase")
	endRoundButton.button_down.connect(endRound)
	endRoundButton.disabled = false
	pass

func endRound() -> void:
	stateRoundManager.transitionState("PREPARATIONSTATE")
	

func onExit(roundManager: RoundManager) -> void:
	endRoundButton.button_down.disconnect(endRound)
	endRoundButton.disabled = false
	pass
