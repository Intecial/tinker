extends ActionResource
class_name SpawnGearAction

@export var gear:GearResource

func execute(actor: Actor) -> void:
	for gearArrSlot: GearArraySlot in Constant.GEAR_INVENTORY.inventory:
		if gearArrSlot.gear == null:
			gearArrSlot.setGear(gear)
			
			await self.flash(Constant.FX_LAYER)
			return
	

func flash(layer: FXLayer) -> void:
	var rect : ColorRect = ColorRect.new()
	rect.color = Color.RED
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	layer.add_child(rect)
	
	var tween : Tween = layer.create_tween()
	tween.tween_property(rect, "color:a", 0.0, animSpeed)
	tween.tween_callback(func() -> void: onFlashDone(rect)) 
	
	await tween.finished
	

func onFlashDone(rect: ColorRect) -> void:
	rect.queue_free()
	pass
