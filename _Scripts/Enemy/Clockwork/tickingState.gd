extends EnemyState
class_name TickingState

func onEnter(_enemy_state_machine: EnemyStateMachine) -> void:
	pass
#	_enemy_state_machine.enemy_context.
	
func onExit(_enemy_state_machine: EnemyStateMachine) -> void:
	pass

func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource:
	var countdown: int = _enemy_state_machine.enemy_context.try_get_persistent_data("countdown")
	countdown -= 1
	_enemy_state_machine.enemy_context.set_persistent_data("countdown", countdown)
	if (countdown) <= 0:
		_enemy_state_machine.transitionState("EXPLODESTATE")
	return gear