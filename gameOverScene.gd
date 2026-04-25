extends Control
class_name GameOverScene

@onready var retryButton: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/Panel3/RetryButton

func loadMainGame() -> void:
	get_tree().change_scene_to_file("uid://5s8u6tgmbgg0")
	
	
