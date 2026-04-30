extends Node
class_name EnemyManager

@export_category("Income Multiplier")
@export var baseIncome: int = 5
@export var maxIncomeCounter: int = 5
@export var income : Curve
var incomeCounter: int = 0

@export_category("Enemy Health Multiplier")
@export var enemyPackedScene: PackedScene
@export var enemyHealthCurve: Curve
@export var baseHealthIncrement: int = 5
@export var maxEnemyCounter: int = 10
var enemyCounter: int = 0

var roundNumber: int = 0

var activeEnemy : EnemyActor = null
func _enter_tree() -> void:
	Constant.ENEMY_MANAGER = self
	
func calculateEnemyHealth(enemyActor: EnemyActor) -> int:
	var t: float = float(enemyCounter) / float(maxEnemyCounter)
	
	t = clamp(t, 0.0, 1.0)
	enemyCounter += 1
	if t >= 1.0:
		enemyCounter = 0
		baseHealthIncrement += baseHealthIncrement
		
	var multiplier: float = enemyHealthCurve.sample(t)
	
	return int(enemyActor.health + (baseHealthIncrement + enemyActor.health) * multiplier)
	
func increaseRound(enemy_actor: EnemyActor) -> void:
	enemy_actor.onDeath.disconnect(increaseRound.bind(enemy_actor))
	
	var t : float = float(incomeCounter) / float(maxIncomeCounter)
	t = clamp(t, 0.0, 1.0)
	var multiplier : float = income.sample(t)
	
	Constant.PLAYER.addKnowledge(int(baseIncome * multiplier) + baseIncome)
	if t >= 1.0:
		incomeCounter = 0
		baseIncome += baseIncome
	roundNumber += 1
	incomeCounter += 1

func spawnEnemy() -> EnemyActor:
	var actor: EnemyActor = enemyPackedScene.instantiate()
	var randomInt: int = randi_range(0, len(Constant.ENEMY_RESOURCES) - 1)
	var resource :EnemyResource = Constant.ENEMY_RESOURCES[randomInt]
	actor.initEnemy(resource)
	actor.health = calculateEnemyHealth(actor)
	self.add_child(actor)
	self.activeEnemy = actor
	actor.onDeath.connect(increaseRound.bind(actor))
	return actor
	

func prepare() -> void:
	if activeEnemy == null :
		return
	activeEnemy.prepareAction()

func performAction() -> void:
	if activeEnemy == null :
		return
	activeEnemy.resetShields()
	activeEnemy.performPreparedAction()
	
