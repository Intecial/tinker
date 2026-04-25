extends RoundState
class_name CombatState

func onEnter(roundManager: RoundManager) -> void:
	print("Combatting")
	await Constant.TEXT_CONTAINER.showText("[center] [b]Combat [center] [b]Phase")
	roundManager.gearArray.disableArraySlots()
	
	await roundManager.gearArray.resolveGears()
	if Constant.PLAYER.target != null:
		await Constant.TEXT_CONTAINER.showText("[center] [b]Enemy [center] [b]Phase")
		await Constant.ENEMY_MANAGER.performAction()
	if Constant.PLAYER.target == null:	
		roundManager.transitionState("SHOPSTATE")
		return
	else:
		roundManager.transitionState("PREPARATIONSTATE")
	
	

func onExit(roundManager: RoundManager) -> void:
	roundManager.gearArray.enableArraySlots()