extends RoundState
class_name PreparationState

@export var endRoundButton: Button
@export var targetStatView: EnemyStatView

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
	Constant.SHOP_PANEL.hide()
	Constant.ENEMY_PANEL.show()
	Constant.TEXT_CONTAINER.showText("[center] [b]Preparation [center] [b]Phase")
	stateRoundManager = roundManager
	Constant.GEAR_INVENTORY.incomeGears()
	roundManager.gearArray.enableArraySlots()
	if Constant.PLAYER.target != null and Constant.PLAYER.target.health <= 0:
		Constant.PLAYER.target = null
	if Constant.PLAYER.target == null:
		Constant.PLAYER.target =await Constant.ENEMY_MANAGER.spawnEnemy()
		targetStatView.connectTarget(Constant.PLAYER.target as EnemyActor)
	
	Constant.ENEMY_MANAGER.prepare()
	print(Constant.PLAYER.target.health)

func endRound() -> void:
	stateRoundManager.transitionState("COMBATSTATE")

func onExit(roundManager: RoundManager) -> void:
	endRoundButton.disabled = true
	roundManager.gearArray.disableArraySlots()
	endRoundButton.button_down.disconnect(endRound)
	
