extends Control
class_name EnemyStatView


#@export var toolTip: PackedScene
@export var health: Stat
@export var shield: Stat
@onready var enemyName: RichTextLabel = $VBoxContainer/EnemyName
#@onready var enemyIcon: TextureRect = $"../MarginContainer/PanelContainer/HBoxContainer/EnemyIcon"
#@onready var enemyActiveGear: GearArraySlot = $"../MarginContainer/PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/GearArraySlot"
#@onready var popUpManager: PopUpManager = $"../MarginContainer/PanelContainer/HBoxContainer/EnemyIcon/PopUpManager"
var target: EnemyActor
#func _ready() -> void:
#	enemyActiveGear.isDisabled = true

func connectTarget(actor: EnemyActor) -> void:
	actor.shield_changed.connect(shield.render)
	actor.health_changed.connect(health.render)
	actor.on_damage.connect(show_damage)
	enemyName.text = actor.enemyResource.name
#	
func show_damage(amount: int) -> void:
	print("test")
#	popUpManager.invoke(amount, popUpManager, "-")
	
func _exit_tree() -> void:
	target.shield_changed.disconnect(shield.render)
	target.health_changed.disconnect(health.render)
	target.on_damage.disconnect(show_damage)
	enemyName.text = ""

#func popGear() -> void:
#	enemyActiveGear.removeGear()

#func renderGear(gear: GearResource) -> void:
#	enemyActiveGear.setGear(gear)
	
