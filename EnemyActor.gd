extends Actor
class_name EnemyActor

@export var enemyResource: EnemyResource

signal gear_prepared(value: GearResource)
var _preparedGear: GearResource = null
var preparedGear: GearResource : 
	get:
		return _preparedGear
	set(value):
		_preparedGear = value
		gear_prepared.emit(value)

signal on_gear_performed()
		

func initEnemy(initEnemyResource: EnemyResource) -> void:
	self.enemyResource = initEnemyResource
	self.health = initEnemyResource.health
	self.target = Constant.PLAYER

func prepareGear() -> void:
	var randomInt : int = randi_range(0, len(enemyResource.gears) - 1)
	preparedGear = enemyResource.gears[randomInt]

func performPreparedGear() -> void:
	preparedGear.evaluate(self)
	on_gear_performed.emit()
