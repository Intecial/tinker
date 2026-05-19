extends RoundState
class_name PreparationState

func onEnter(roundManager: RoundManager) -> void:
#	Constant.PANEL_MANAGER.switchPanel("Enemy")

	Constant.PLAYER.upkeep()
	roundManager.gearArray.enableArraySlots()
	if Constant.PLAYER.target != null and Constant.PLAYER.target.health <= 0:
		Constant.PLAYER.target = null
	if Constant.PLAYER.target == null:
		Constant.PLAYER.target = Constant.ENEMY_MANAGER.spawnEnemy()
		var enemy_actor: EnemyActor = Constant.PLAYER.target
		enemy_actor.on_enemy_die.connect(roundManager.on_enemy_die)
		
	await Constant.TEXT_CONTAINER.showText("[center] [b]Preparation [center] [b]Phase")
	
	Constant.ENEMY_MANAGER.prepare()

func onNextRound(_roundManager: RoundManager) -> void:
	_roundManager.transitionState("COMBATSTATE")

func onExit(roundManager: RoundManager) -> void:
	roundManager.gearArray.disableArraySlots()
	
