extends GamePanel
class_name EnemyPanel


@onready var enemyStatView: EnemyStatView = $VBoxContainer2/EnemyStatView
@onready var gearSlot: GearArraySlot = $VBoxContainer2/MarginContainer/PanelContainer/HBoxContainer/MarginContainer/VBoxContainer/GearArraySlot
#func _enter_tree() -> void:
#	Constant.ENEMY_PANEL = self  
	

func connectTargetView(enemyActor: EnemyActor) -> void:
	enemyStatView.connectTarget(enemyActor)
#
#func _input(event: InputEvent) -> void:
#	if Input.is_action_pressed("space"):
#		print("Test")
#		enemyStatView.show_damage(50)
#		
