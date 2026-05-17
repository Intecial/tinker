extends RoundState
class_name ForgeState

func onEnter(roundManager: RoundManager) -> void:
	Constant.PANEL_MANAGER.switchPanel("Forge")
	await Constant.TEXT_CONTAINER.showText("[center] [b]Forge [center] [b]Phase")
	pass

func onNextRound(_roundManager: RoundManager) -> void:
	_roundManager.transitionState("ROUTESTATE")
	

func onExit(roundManager: RoundManager) -> void:
	pass
