extends Actor
class_name EnemyActor

@export var is_debug: bool
@export var enemyResource: EnemyResource

@onready var sprite: Sprite2D = $Sprite2D
@onready var enemy_ui_panel: EnemyUI = $CanvasLayer/EnemyUIPanel
var enemyStateMachine: EnemyStateMachine
signal on_enemy_die(enemy_resource: EnemyResource)


signal gear_prepared(value: GearResource)
var _preparedGear: GearResource = null
var preparedGear: GearResource : 
	get:
		return _preparedGear
	set(value):
		_preparedGear = value
		gear_prepared.emit(value)

signal on_gear_performed()

func _ready() -> void:
	super._ready()
	self.onDeath.connect(on_enemy_actor_die)
	
func _exit_tree() -> void:
	self.onDeath.disconnect(on_enemy_actor_die)

func on_enemy_actor_die() -> void:
	on_enemy_die.emit(enemyResource)
	
func initEnemy(initEnemyResource: EnemyResource) -> void:
	self.enemyResource = initEnemyResource
	self.health = initEnemyResource.health
	self.shield = 0
	self.target = Constant.PLAYER
	self.sprite.texture = initEnemyResource.icon
	self.permanentAction = initEnemyResource.permanent_actions.duplicate_deep(true)
	enemy_ui_panel.connect_actor(self)
	_place_ui_panel()
	var create_sm: EnemyStateMachine = initEnemyResource.enemy_state_machine.instantiate()
	self.add_child(create_sm)
	create_sm.init_sm(self)
	self.enemyStateMachine = create_sm

func _place_ui_panel() -> void:
	var texture_size : Vector2 = sprite.texture.get_size() * sprite.scale
	var top_right :Vector2 = sprite.global_position + Vector2(texture_size.x / 2, -texture_size.y / 2)
	enemy_ui_panel.global_position = top_right

func prepareGear() -> void:
#	var randomInt : int = randi_range(0, len(enemyResource.gears) - 1)
	preparedGear = enemyStateMachine.get_evaluated_gear()
#	preparedGear = enemyResource.gears[randomInt]

func performPreparedGear() -> void:
	await preparedGear.evaluate(self)
	on_gear_performed.emit()
