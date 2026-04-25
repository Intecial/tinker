extends ActionResource
class_name DamageOnGearType

@export var gearType: GearResource.GearType
@export var action: DamageAction
@export var multiplier: int = 1

func execute(actor: Actor) -> void:
	var totalDamage: int = 0
	for i: GearArraySlot in Constant.GEAR_ARRAY.get_children():
		if i.gear != null && i.gear.gearType == self.gearType:
			totalDamage += multiplier
	print(totalDamage)
	action.damage += totalDamage
	print(action.damage)
	action.execute(actor)
	await flash(Constant.FX_LAYER)
	

func flash(layer: FXLayer) -> void:
	var rect : ColorRect = ColorRect.new()
	rect.color = Color.RED
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	layer.add_child(rect)
	
	var tween : Tween = layer.create_tween()
	tween.tween_property(rect, "color:a", 0.0, self.animSpeed)
	tween.tween_callback(func() -> void: onFlashDone(rect)) 
	
	await tween.finished
	

func onFlashDone(rect: ColorRect) -> void:
	rect.queue_free()
	pass
