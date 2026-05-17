extends Actor
class_name EnemyActor

@export var is_debug: bool
@export var enemyResource: EnemyResource
var enemyStateMachine: EnemyStateMachine


signal gear_prepared(value: GearResource)
var _preparedGear: GearResource = null
var preparedGear: GearResource : 
	get:
		return _preparedGear
	set(value):
		_preparedGear = value
		gear_prepared.emit(value)

signal on_gear_performed()

#func _ready() -> void:
#	if is_debug:
#		self.initEnemy(enemyResource)
#
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("space") and is_debug:
#		print(enemyStateMachine.get_evaluated_gear().gearName)
func initEnemy(initEnemyResource: EnemyResource) -> void:
	self.enemyResource = initEnemyResource
	self.health = initEnemyResource.health
	self.target = Constant.PLAYER
	var create_sm: EnemyStateMachine = initEnemyResource.enemy_state_machine.instantiate()
	print("Is Actor Context available?" + str(self.actorContext))
	self.add_child(create_sm)
	create_sm.init_sm(self)
	self.enemyStateMachine = create_sm
	

func prepareGear() -> void:
#	var randomInt : int = randi_range(0, len(enemyResource.gears) - 1)
	preparedGear = enemyStateMachine.get_evaluated_gear()
#	preparedGear = enemyResource.gears[randomInt]

func performPreparedGear() -> void:
	await preparedGear.evaluate(self)
	on_gear_performed.emit()
