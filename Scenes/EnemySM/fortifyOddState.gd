extends EnemyState
class_name FortifyOddState

func onEnter(_enemy_state_machine: EnemyStateMachine) -> void:
#	_enemy_state_machine.transitionState("RAISESTATE")
	pass
func onExit(_enemy_state_machine: EnemyStateMachine) -> void:
	pass

func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource:
	_enemy_state_machine.transitionState("RAISESTATE")
	return super.get_evaluated_gear(_enemy_state_machine)
