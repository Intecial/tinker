extends Control
class_name TextContainer

@onready var heading_label: RichTextLabel = $Label

func _enter_tree() -> void:
	Constant.TEXT_CONTAINER = self

func showText(txt: String) -> void:
	heading_label.text = str(txt)
	
	# Start off-screen (left)
	heading_label.position.x = -heading_label.size.x
	
	# Optional: vertically center
	heading_label.position.y = get_viewport_rect().size.y / 4
	
	var tween : Tween = create_tween()
	tween.tween_property(
		heading_label,
		"position:x",
		get_viewport_rect().size.x / 2 - heading_label.size.x / 2,
		0.8
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	
	# Wait 1.5 seconds

	await get_tree().create_timer(1.5).timeout
	# Slide out to the right
	var tween2 :Tween = create_tween()
	tween2.tween_property(heading_label, "position:x", get_viewport_rect().size.x / 2  + heading_label.size.x, 0.8)

	await tween2.finished
