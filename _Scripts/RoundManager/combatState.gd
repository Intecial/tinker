extends RoundState
class_name CombatState

@export var gadget_pedestal: GadgetPedestal

func onEnter(roundManager: RoundManager) -> void:
	await Constant.TEXT_CONTAINER.showText("[center] [b]Combat [center] [b]Phase")
	roundManager.gearArray.disableArraySlots()
	if gadget_pedestal.is_ready and gadget_pedestal.is_active:
		await gadget_pedestal.resolve()
	await roundManager.gearArray.resolveGears()
	
	if Constant.PLAYER.target:
		await Constant.TEXT_CONTAINER.showText("[center] [b]Enemy [center] [b]Phase")
		await Constant.ENEMY_MANAGER.performAction()
		roundManager.transitionState("ENEMYCOMBATSTATE")
#		await Constant.TEXT_CONTAINER.showText("[center] [b]Enemy [center] [b]Phase")
#		await Constant.ENEMY_MANAGER.performAction()
#		Constant.PLAYER.target.upkeep()
#	
#		roundManager.transitionState("PREPARATIONSTATE")
	
	

func onExit(roundManager: RoundManager) -> void:
	roundManager.gearArray.enableArraySlots()
