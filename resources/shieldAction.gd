extends ActionResource
class_name ShieldAction

@export var shieldAmount: int = 5
func execute(actor: Actor) -> void:
	actor.addShield(shieldAmount)
	await flash(Constant.FX_LAYER)


func flash(layer: FXLayer) -> void:
	var rect : ColorRect = ColorRect.new()
	rect.color = Color(0.2, 0.6, 1.0, 0.4)
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	layer.add_child(rect)
	
	var tween : Tween = layer.create_tween()
	tween.tween_property(rect, "color:a", 0.0, animSpeed)
	tween.tween_callback(rect.queue_free) # clean up after
	
	await tween.finished
