extends RoundState
class_name GameOverState


func onEnter(roundManager: RoundManager) -> void:
	var overlay : ColorRect = ColorRect.new()
	overlay.color = Color(0, 0, 0, 0)
	overlay.anchor_right = 1.0
	overlay.anchor_bottom = 1.0
	get_tree().current_scene.add_child(overlay)
	
	var tween : Tween = overlay.create_tween()
	tween.tween_property(overlay, "color:a", 1.0, 1.0)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
	await tween.finished
	
	get_tree().change_scene_to_file("uid://d0yn4sshhimwe")
	
func onExit(roundManager: RoundManager) -> void:
	pass
	
