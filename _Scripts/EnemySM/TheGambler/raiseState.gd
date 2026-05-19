extends EnemyState
class_name RaiseState

func onEnter(_enemy_state_machine: EnemyStateMachine) -> void:
	pass

func onExit(_enemy_state_machine: EnemyStateMachine) -> void:
	pass

func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource:
	var enemy_actor: EnemyActor = _enemy_state_machine.enemy
	var bets_array : Array[StatusEffectResource] = enemy_actor.statusEffects.filter(func(x: StatusEffectResource) -> bool: return x.name == "Bet")
	var num_of_bets: int = len(bets_array)
	
	if enemy_actor.shield <= 0:
		_enemy_state_machine.transitionState("FORTIFYODDSTATE")
	elif num_of_bets >= 10:
		_enemy_state_machine.transitionState("CASHOUTSTATE")
	return super.get_evaluated_gear(_enemy_state_machine)
