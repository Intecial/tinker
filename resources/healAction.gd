extends ActionResource
class_name HealAction

@export var amount: int = 5
func execute(actor: Actor) -> void: 
	actor.addHealth(amount)
	await flash(Constant.FX_LAYER)
	
func flash(layer: FXLayer) -> void:
	var rect : ColorRect = ColorRect.new()
	rect.color = Color.GREEN
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	layer.add_child(rect)
	
	var tween : Tween = layer.create_tween()
	tween.tween_property(rect, "color:a", 0.0, animSpeed)
	tween.tween_callback(rect.queue_free) # clean up after
	
	await tween.finished
