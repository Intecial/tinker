extends RoundState
class_name CombatState

func onEnter(roundManager: RoundManager) -> void:
	await Constant.TEXT_CONTAINER.showText("[center] [b]Combat [center] [b]Phase")
	roundManager.gearArray.disableArraySlots()
	
	await roundManager.gearArray.resolveGears()
	if Constant.PLAYER.target != null:
		await Constant.TEXT_CONTAINER.showText("[center] [b]Enemy [center] [b]Phase")
		await Constant.ENEMY_MANAGER.performAction()
		Constant.PLAYER.target.upkeep()
	if Constant.PLAYER.target == null:	
		roundManager.transitionState("ROUTESTATE")
		return
	else:
		roundManager.transitionState("PREPARATIONSTATE")
	
	

func onExit(roundManager: RoundManager) -> void:
	roundManager.gearArray.enableArraySlots()
