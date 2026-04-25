@abstract
extends Resource
class_name ActionResource

@export var icon: Texture2D
@export var color: Color
@export var actionName: String = ""
@export_multiline var description: String = ""

var animSpeed : float = 0.8

@abstract
func execute(actor: Actor) -> void


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
