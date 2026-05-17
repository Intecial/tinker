extends EnemyState
class_name ExplodeState

func onEnter(_enemy_state_machine: EnemyStateMachine) -> void:
	pass
	
func onExit(_enemy_state_machine: EnemyStateMachine) -> void:
	pass

func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource:
	_enemy_state_machine.transitionState("INITSTATE")
	return gear
