@abstract
extends Node
class_name EnemyState
 
@export var gear: GearResource
func onEnter(_enemy_state_machine: EnemyStateMachine) -> void:
	pass
	
func onExit(_enemy_state_machine: EnemyStateMachine) -> void:
	pass
	
func onUpdate(_enemy_state_machine: EnemyStateMachine) -> void:
	pass

@abstract
func get_evaluated_gear(_enemy_state_machine: EnemyStateMachine) -> GearResource

