extends EnemyState
class_name InitState

@export var countdown: int = 3
func onEnter(_enemy_state_machine: EnemyStateMachine) -> void:
	_enemy_state_machine.enemy_context.set_persistent_data("countdown", countdown)

func onExit(_enemy_state_machine: EnemyStateMachine) -> void:
	pass
	
func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource:
	_enemy_state_machine.transitionState("TICKINGSTATE")
	return gear
