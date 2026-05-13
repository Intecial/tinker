extends Control
class_name EnemyStatView


@export var toolTip: PackedScene
@onready var enemyName: RichTextLabel = $MarginContainer2/PanelContainer/EnemyName
@onready var health: Stat = $HBoxContainer/Health
@onready var shield: Stat = $HBoxContainer/Shield
@onready var enemyIcon: TextureRect = $"../MarginContainer/PanelContainer/HBoxContainer/EnemyIcon"
@onready var enemyActiveGear: GearArraySlot = $"../MarginContainer/PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/GearArraySlot"
@onready var popUpManager: PopUpManager = $"../MarginContainer/PanelContainer/HBoxContainer/EnemyIcon/PopUpManager"
var target: EnemyActor
func _ready() -> void:
	enemyActiveGear.isDisabled = true

func connectTarget(actor: EnemyActor) -> void:
	self.target = actor
	actor.shield_changed.connect(shield.render)
	actor.health_changed.connect(health.render)
	actor.gear_prepared.connect(renderGear)
	actor.on_gear_performed.connect(popGear)
	actor.on_damage.connect(show_damage)
	enemyName.text = actor.enemyResource.name
	enemyIcon.texture = actor.enemyResource.icon
	
func show_damage(amount: int) -> void:
	print(show_damage)
	popUpManager.invoke(amount, popUpManager, "-")
	
func _exit_tree() -> void:
	target.shield_changed.disconnect(shield.render)
	target.health_changed.disconnect(health.render)
	target.gear_prepared.disconnect(renderGear)
	target.on_gear_performed.disconnect(popGear)
	target.on_damage.disconnect(show_damage)
	enemyName.text = ""

func popGear() -> void:
	enemyActiveGear.removeGear()

func renderGear(gear: GearResource) -> void:
	enemyActiveGear.setGear(gear)
	
