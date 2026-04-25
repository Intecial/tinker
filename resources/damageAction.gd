extends ActionResource
class_name DamageAction

@export var damage: int = 5

func execute(actor: Actor) -> void:
	actor.target.resolveDamage(damage)
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
