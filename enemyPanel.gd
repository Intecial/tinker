extends GamePanel
class_name EnemyPanel


@onready var enemyStatView: EnemyStatView = $VBoxContainer2/EnemyStatView

#func _enter_tree() -> void:
#	Constant.ENEMY_PANEL = self  
	

func connectTargetView(enemyActor: EnemyActor) -> void:
	enemyStatView.connectTarget(enemyActor)
