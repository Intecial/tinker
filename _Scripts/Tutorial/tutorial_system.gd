extends Control
class_name Tutorial

@export var panels: Array[Control] = []
var current_index: int = 0
var current_panel: Control = null

func _ready() -> void:
	for panel: Control in get_children():
		panels.append(panel)
		panel.visible = false
	await get_tree().process_frame
	show_next_panel()
	
	
func show_next_panel() -> void:
	if current_index >= panels.size():
		end_tutorial()
		return
	
	if current_panel:
		await set_panel_visible(current_panel, false)
	
	current_panel = panels[current_index]
	await set_panel_visible(current_panel, true)
	current_index += 1
	
	await wait_for_input()
	show_next_panel()
	
func wait_for_input() -> void:
	await get_tree().create_timer(0.0).timeout 
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("ui_accept"): 
			break
			
func set_panel_visible(panel: Control, is_panel_visible: bool) -> void:
	if is_panel_visible:
		panel.modulate.a = 0.0  # reset before fade in
	panel.visible = true
	var targetAlpha : float = 1.0 if is_panel_visible else 0.0
	var tween : Tween = panel.create_tween()
	tween.tween_property(panel, "modulate:a", targetAlpha, 0.3)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN if !is_panel_visible else Tween.EASE_OUT)
	await tween.finished
	panel.visible = is_panel_visible
func end_tutorial() -> void:
	if current_panel:
		current_panel.visible = false
	print("Tutorial done!")
