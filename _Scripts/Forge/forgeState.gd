extends RoundState
class_name ForgeState

@export var forge_panel: ForgePanel
var round_manager: RoundManager
func _ready() -> void:
	forge_panel.skip_button.button_down.connect(skip_forge)

func onEnter(roundManager: RoundManager) -> void:
	forge_panel.visible = true
	self.round_manager = roundManager
	await Constant.TEXT_CONTAINER.showText("[center] [b]Forge [center] [b]Phase")
	pass

func skip_forge() -> void:
	round_manager.next_button_click()
	pass

func onNextRound(_roundManager: RoundManager) -> void:
	_roundManager.transitionState("ROUTESTATE")
	

func onExit(roundManager: RoundManager) -> void:
	forge_panel.visible = false
	pass
