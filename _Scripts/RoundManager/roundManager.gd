extends Node
class_name RoundManager


var currentState: RoundState
@export var initialState: RoundState
@export var player_ui: PlayerUI
var gearArray: GearArray
var stateDict : Dictionary[String, RoundState]

var next_round: Button
var current_dead_enemy : EnemyResource 

func on_enemy_die(enemy_resource: EnemyResource) -> void:
	current_dead_enemy = enemy_resource
	transitionState("ENEMYDROPSTATE")

func _ready() -> void:
	Constant.ROUND_MANAGER = self
	next_round = player_ui.get_next_round_button()
	next_round.button_down.connect(next_button_click)
	gearArray = Constant.GEAR_ARRAY
	for childState: Node in get_children():
		stateDict.get_or_add(childState.name.to_upper(), childState)
	
	await get_tree().process_frame
	currentState = initialState
	currentState.onEnter(self)
	Constant.PLAYER.onDeath.connect(gameOver)

func _exit_tree() -> void:
	next_round.button_down.disconnect(next_button_click)

func gameOver() -> void:
#	get_tree().paused = true
	self.transitionState("GAMEOVERSTATE")

func _process(_delta: float) -> void:
	self.currentState.onUpdate(self)

func transitionState(newStateName: String) -> void:
	var newState : RoundState = stateDict.get(newStateName)
	if !newState:
		return
	if currentState == newState:
		return
	
	currentState.onExit(self)
	currentState = newState
	currentState.onEnter(self)

func next_button_click() -> void:
	currentState.onNextRound(self)

