extends EnemyState
class_name GoToNextState

@export var next_state: EnemyState
func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource:
	print(next_state.name.to_upper())
	_enemy_state_machine.transitionState(next_state.name.to_upper())
	return gear
