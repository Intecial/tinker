extends Control
class_name PopUpManager

@export var popUp: PackedScene

func invoke(amount: int, parent: Node, front: String) -> void :
	var copy: DamagePopUp = popUp.instantiate()
	parent.add_child(copy)
	copy.set_damage_text(amount, front)
	
	var tween : Tween = copy.create_tween()
	tween.set_parallel(true)
	tween.tween_property(copy, "position", copy.position + Vector2(0, -50), 0.6)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(copy, "modulate:a", 0.0, 0.6)
	
	await tween.finished
	copy.queue_free()