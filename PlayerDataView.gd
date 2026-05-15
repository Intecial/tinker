extends PanelContainer
class_name PlayerDataView

@onready var health: Stat = $HBoxContainer3/HBoxContainer/Health
@onready var shield: Stat = $HBoxContainer3/HBoxContainer/Shield
@onready var knowledge: Stat = $HBoxContainer3/HBoxContainer/Knowledge

#func _enter_tree() -> void:
#	Constant.PLAYER.health_changed.connect(renderHealth)
func _ready() -> void:
	Constant.PLAYER.shield_changed.connect(shield.render)
	Constant.PLAYER.health_changed.connect(health.render)
	Constant.PLAYER.on_damage.connect(pop_number)
	Constant.PLAYER.knowledge_changed.connect(knowledge.render)
	
func _exit_tree() -> void:
	if Constant.PLAYER:
		Constant.PLAYER.shield_changed.disconnect(shield.render)
		Constant.PLAYER.health_changed.disconnect(health.render)
		Constant.PLAYER.knowledge_changed.disconnect(knowledge.render)
		Constant.PLAYER.on_damage.disconnect(pop_number)

func pop_number(amount: int) -> void:
	health.invoke_pop_up(amount, "-")
