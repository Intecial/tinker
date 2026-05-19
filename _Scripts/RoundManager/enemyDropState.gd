extends RoundState
class_name EnemyDropState

@export var enemy_drop_panel: EnemyDrop

var round_manager: RoundManager

func _ready() -> void:
	enemy_drop_panel.skip_button.button_down.connect(skip_button)
	pass

func onEnter(_roundManager: RoundManager) -> void:
	self.round_manager = _roundManager
	enemy_drop_panel.init_drop(_roundManager.current_dead_enemy)
	enemy_drop_panel.visible = true

func skip_button() -> void:
	round_manager.next_button_click()

func onExit(_roundManager: RoundManager) -> void:
	enemy_drop_panel.visible = false

func onNextRound(_roundManager: RoundManager) -> void:
	_roundManager.transitionState("ROUTESTATE")
