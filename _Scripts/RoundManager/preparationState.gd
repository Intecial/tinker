extends RoundState
class_name PreparationState

@export var endRoundButton: Button

var stateRoundManager: RoundManager
#func _enter_tree() -> void:
#	endRoundButton.button_down.connect(endRound)
#	
#func _exit_tree() -> void:
#	endRoundButton.button_down.disconnect(endRound)
#	
func onEnter(roundManager: RoundManager) -> void:
	endRoundButton.disabled = false
	endRoundButton.button_down.connect(endRound)
	Constant.PANEL_MANAGER.switchPanel("Enemy")
	
	stateRoundManager = roundManager
	Constant.PLAYER.upkeep()
	roundManager.gearArray.enableArraySlots()
	if Constant.PLAYER.target != null and Constant.PLAYER.target.health <= 0:
		Constant.PLAYER.target = null
	if Constant.PLAYER.target == null:
		Constant.PLAYER.target = Constant.ENEMY_MANAGER.spawnEnemy()
		var enemyPanel: EnemyPanel = Constant.PANEL_MANAGER.getPanel("Enemy")
		enemyPanel.connectTargetView(Constant.PLAYER.target as EnemyActor)
	await Constant.TEXT_CONTAINER.showText("[center] [b]Preparation [center] [b]Phase")
	
	Constant.ENEMY_MANAGER.prepare()

func endRound() -> void:
	stateRoundManager.transitionState("COMBATSTATE")

func onExit(roundManager: RoundManager) -> void:
	endRoundButton.disabled = true
	roundManager.gearArray.disableArraySlots()
	endRoundButton.button_down.disconnect(endRound)
	
