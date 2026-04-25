extends Control
class_name EnemyStatView

@export var toolTip: PackedScene
@onready var enemyName: RichTextLabel = $MarginContainer2/PanelContainer/EnemyName
@onready var health: Stat = $HBoxContainer/Health
@onready var shield: Stat = $HBoxContainer/Shield
@onready var actionIcon: TextureRect = $ActionLabel/HBoxContainer/ActionIcon
@onready var actionText: RichTextLabel =  $ActionLabel/HBoxContainer/ActionText
@onready var actionLabel: ActionLabel = $ActionLabel
@onready var enemyIcon: TextureRect = $"../MarginContainer/PanelContainer/EnemyIcon"

var target: EnemyActor
func connectTarget(actor: EnemyActor) -> void:
	self.target = actor
	actor.shield_changed.connect(shield.render)
	actor.health_changed.connect(health.render)
	actor.action_prepared.connect(renderActionIcon)
	enemyName.text = actor.enemyResource.name
	enemyIcon.texture = actor.enemyResource.icon
	
func _exit_tree() -> void:
	target.shield_changed.disconnect(shield.render)
	target.health_changed.disconnect(health.render)
	target.action_prepared.disconnect(renderActionIcon)
	enemyName.text = ""

func renderActionIcon(action: ActionResource) -> void:
	actionIcon.texture = action.icon
	actionIcon.modulate = action.color
	actionText.text = action.actionName
	actionLabel.tooltip_text = action.description
