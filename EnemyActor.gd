extends Actor
class_name EnemyActor

@export var enemyResource: EnemyResource

var _preparedAction: ActionResource = null
var preparedAction: ActionResource :
	get:
		return _preparedAction
	set(value):
		_preparedAction = value
		action_prepared.emit(value)

signal action_prepared(value: ActionResource)

#signal actionPrepared

func initEnemy(initEnemyResource: EnemyResource):
	self.enemyResource = initEnemyResource
	self.health = initEnemyResource.health
	self.target = Constant.PLAYER

func prepareAction() -> void:
	var randomInt : int = randi_range(0, len(enemyResource.actions) - 1)
	preparedAction = enemyResource.actions[randomInt]

func performPreparedAction() -> void:
	preparedAction.execute(self)