extends Node
class_name EnemyStateMachine


var currentState: EnemyState
@export var initialState: EnemyState
@export var enemy: EnemyActor

@export var enemy_context: ActorContext
var stateDict : Dictionary[String, EnemyState]

func init_sm(enemy_actor: EnemyActor) ->  void:
	self.enemy = enemy_actor
	self.enemy_context = enemy_actor.actorContext

func _ready() -> void:
	for childState: Node in get_children():
		stateDict.get_or_add(childState.name.to_upper(), childState)
	await get_tree().process_frame
	currentState = initialState
	currentState.onEnter(self)

func get_evaluated_gear() -> GearResource:
	return currentState.get_evaluated_gear(self)

func transitionState(newStateName: String) -> void:
	var newState : EnemyState = stateDict.get(newStateName)
	if !newState:
		print("State not found")
		return
	if currentState == newState:
		print("Same as previous state")
		return
	
	currentState.onExit(self)
	currentState = newState
	currentState.onEnter(self)
