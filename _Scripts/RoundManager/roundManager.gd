extends Node
class_name RoundManager


var currentState: RoundState
@export var initialState: RoundState
@export var gearArray: GearArray
@export var mainUI: Control
var stateDict : Dictionary[String, RoundState]

func _ready() -> void:
	Constant.ROUND_MANAGER = self
	for childState: Node in get_children():
		stateDict.get_or_add(childState.name.to_upper(), childState)
	
	await get_tree().process_frame
	currentState = initialState
	currentState.onEnter(self)
	Constant.PLAYER.onDeath.connect(gameOver)

func gameOver() -> void:
#	get_tree().paused = true
	self.transitionState("GAMEOVERSTATE")

func _process(_delta: float) -> void:
	self.currentState.onUpdate(self)

func transitionState(newStateName: String) -> void:
	var newState : RoundState = stateDict.get(newStateName)
	if !newState:
		print("State not found")
		return
	if currentState == newState:
		print("Same as previous state")
		return
	
	currentState.onExit(self)
	currentState = newState
	currentState.onEnter(self)
