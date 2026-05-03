extends Control
class_name EnemyStatView

@export var toolTip: PackedScene
@onready var enemyName: RichTextLabel = $MarginContainer2/PanelContainer/EnemyName
@onready var health: Stat = $HBoxContainer/Health
@onready var shield: Stat = $HBoxContainer/Shield
@onready var actionText: RichTextLabel =  $ActionLabel/HBoxContainer/ActionText
@onready var enemyIcon: TextureRect = $"../MarginContainer/PanelContainer/HBoxContainer/EnemyIcon"
@onready var enemyActiveGear: GearArraySlot = $"../MarginContainer/PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/GearArraySlot"

var target: EnemyActor
func _ready() -> void:
	enemyActiveGear.isDisabled = true

func connectTarget(actor: EnemyActor) -> void:
	self.target = actor
	actor.shield_changed.connect(shield.render)
	actor.health_changed.connect(health.render)
	actor.gear_prepared.connect(renderGear)
	actor.on_gear_performed.connect(popGear)
	enemyName.text = actor.enemyResource.name
	enemyIcon.texture = actor.enemyResource.icon
	
func _exit_tree() -> void:
	target.shield_changed.disconnect(shield.render)
	target.health_changed.disconnect(health.render)
	target.gear_prepared.disconnect(renderGear)
	target.on_gear_performed.disconnect(popGear)
	enemyName.text = ""

func popGear() -> void:
	enemyActiveGear.removeGear()

func renderGear(gear: GearResource) -> void:
	enemyActiveGear.setGear(gear)
	
