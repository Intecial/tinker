extends MarginContainer
class_name PedestalDropContainer

@export var gadgetPedestal: GadgetPedestal

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is GearArraySlot 

func _drop_data(_at_position: Vector2, data: Variant) -> void:	
	if !(data is GearArraySlot):
		return

	@warning_ignore("unsafe_cast")
	var fromSlot : GearArraySlot = data as GearArraySlot
	if fromSlot.isShop:
		return

	if fromSlot.isShop:
		if not Constant.PLAYER.useKnowledge(fromSlot.gear.buyValue):
			return
	
	if not gadgetPedestal.try_populate_gadget(fromSlot.gear):
		return
	
	fromSlot.setGear(null)
