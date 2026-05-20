extends RoundState
class_name EnemyCombatState


func onEnter(_roundManager: RoundManager) -> void:
	if Constant.PLAYER.target == null:
		Constant.PLAYER.target = Constant.ENEMY_MANAGER.spawnEnemy()
		var enemy_actor: EnemyActor = Constant.PLAYER.target
		enemy_actor.on_enemy_die.connect(_roundManager.on_enemy_die)
		
#	if Constant.PLAYER.target != null:
	await get_tree().process_frame
#	await Constant.ENEMY_MANAGER.performAction()
	Constant.ENEMY_MANAGER.prepare()
	Constant.PLAYER.target.upkeep()
	_roundManager.transitionState("PREPARATIONSTATE")

func onExit(_roundManager: RoundManager) -> void:
	pass
